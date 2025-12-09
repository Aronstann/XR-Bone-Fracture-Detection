# ai_server.py
from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from ultralytics import YOLO
import uvicorn
import numpy as np
import cv2
import base64
from datetime import datetime

# Path to your trained YOLO detection model
MODEL_PATH = r"weights/best.pt"

# Load model once at startup
model = YOLO(MODEL_PATH)

history = []

app = FastAPI()

# Allow Flutter (any origin) to call this API while developing
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],   # for dev; you can restrict later
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    # 1) Read image from upload
    img_bytes = await file.read()
    nparr = np.frombuffer(img_bytes, np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    if img is None:
        return {"error": "Could not decode image"}

    h, w = img.shape[:2]

    # 2) Run YOLO detection
    #    You can adjust conf here if you like (e.g. conf=0.10)
    results = model(img)[0]

    boxes_out = []
    best_conf = 0.0

    if results.boxes is not None and len(results.boxes) > 0:
        for b in results.boxes:
            x1, y1, x2, y2 = map(float, b.xyxy[0])
            conf = float(b.conf[0])
            cls_id = int(b.cls[0])

            # Append to JSON list
            boxes_out.append({
                "x1": x1,
                "y1": y1,
                "x2": x2,
                "y2": y2,
                "conf": conf,
                "class_id": cls_id,
            })

            if conf > best_conf:
                best_conf = conf

            # 3) Draw red rectangle + confidence on the image
            cv2.rectangle(img, (int(x1), int(y1)), (int(x2), int(y2)),
                          (0, 0, 255), 2)
            cv2.putText(
                img,
                f"pred {conf:.2f}",
                (int(x1), max(0, int(y1) - 10)),
                cv2.FONT_HERSHEY_SIMPLEX,
                0.6,
                (0, 0, 255),
                2,
                cv2.LINE_AA,
            )

    has_fracture = len(boxes_out) > 0

    # 4) Encode annotated image as base64 JPEG
    ok, buffer = cv2.imencode(".jpg", img)
    if not ok:
        return {"error": "Failed to encode annotated image"}

    img_b64 = base64.b64encode(buffer.tobytes()).decode("utf-8")

    # 5) Build response
    response = {
        "has_fracture": has_fracture,
        "best_confidence": best_conf,
        "num_boxes": len(boxes_out),
        "boxes": boxes_out,
        "annotated_image_b64": img_b64,
        "width": w,
        "height": h,
        "timestamp": datetime.now().isoformat()
    }
        # 6) Save to history (you can limit size if you want)
    history.append(response)

    return response

@app.get("/history")
async def get_history():
    # You can reverse it to show latest first
    return {"history": list(reversed(history))}
    
if __name__ == "__main__":
    # Run local server
    uvicorn.run(app, host="127.0.0.1", port=8000)
