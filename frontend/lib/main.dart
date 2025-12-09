import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'db_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const XRBoneApp());
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

final themeNotifier = ThemeNotifier();

class XRBoneApp extends StatefulWidget {
  const XRBoneApp({super.key});

  @override
  State<XRBoneApp> createState() => _XRBoneAppState();
}

class _XRBoneAppState extends State<XRBoneApp> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(() {
      setState(() {});
    });
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF2196F3),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2196F3),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        labelStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0xFF2196F3).withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF2196F3),
          side: const BorderSide(color: Color(0xFF2196F3), width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF64B5F6),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2196F3),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        labelStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0xFF2196F3).withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF64B5F6),
          side: const BorderSide(color: Color(0xFF64B5F6), width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: const Color(0xFF1E1E1E),
      ),
      dividerColor: Colors.grey.shade800,
      iconTheme: const IconThemeData(color: Colors.white70),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XRBone',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.isDarkMode ? _buildDarkTheme() : _buildLightTheme(),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildFloatingIcon(IconData icon, double size, Color color, 
      double topPct, double leftPct, double angle, {bool isRight = false}) {
    final screenSize = MediaQuery.of(context).size;
    return Positioned(
      top: screenSize.height * topPct,
      left: isRight ? null : screenSize.width * leftPct,
      right: isRight ? screenSize.width * leftPct : null,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 2000),
        curve: Curves.elasticOut,
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: Transform.rotate(
              angle: angle * value,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(icon, size: size, color: color),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        const Color(0xFF1E1E1E),
                        const Color(0xFF121212),
                        const Color(0xFF0D0D0D),
                      ]
                    : [
                        const Color(0xFF2196F3).withOpacity(0.1),
                        const Color(0xFF64B5F6).withOpacity(0.05),
                        Colors.white,
                      ],
              ),
            ),
          ),
          
          _buildFloatingIcon(Icons.monitor_heart, 35, Colors.red.shade400, 0.12, 0.08, -0.2),
          _buildFloatingIcon(Icons.biotech, 40, Colors.purple.shade400, 0.25, 0.12, 0.3, isRight: true),
          _buildFloatingIcon(Icons.health_and_safety, 30, Colors.green.shade400, 0.35, 0.05, 0.15),
          _buildFloatingIcon(Icons.vaccines, 32, Colors.blue.shade400, 0.68, 0.1, -0.25),
          _buildFloatingIcon(Icons.medical_services, 38, Colors.orange.shade400, 0.72, 0.08, 0.2, isRight: true),
          
          Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.9, end: 1.0),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        builder: (context, double scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2196F3).withOpacity(0.3),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: isDark
                                      ? [
                                          const Color(0xFF2A2A2A),
                                          const Color(0xFF1E1E1E),
                                        ]
                                      : [
                                          Colors.white,
                                          const Color(0xFF2196F3).withOpacity(0.1),
                                        ],
                                ),
                              ),
                              child: const Icon(
                                Icons.health_and_safety_rounded,
                                size: 80,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                        ).createShader(bounds),
                        child: const Text(
                          "XRBone",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      Text(
                        "Advanced Skeletal Diagnostics",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Precision • Innovation • Care",
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? const Color(0xFF64B5F6) : Colors.blue[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      
                      SizedBox(
                        width: 280,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                            shadowColor: const Color(0xFF2196F3).withOpacity(0.5),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Enter Portal", style: TextStyle(fontSize: 18)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String user = _usernameController.text.trim();
    String pass = _passwordController.text;

    if (user.isEmpty || pass.isEmpty) {
      setState(() {
        _errorMessage = "Please fill all fields";
        _isLoading = false;
      });
      return;
    }

    Map<String, dynamic>? userData = await DatabaseHelper.instance.loginUser(user, pass);

    if (userData != null) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage(userData: userData)),
      );
    } else {
      setState(() {
        _errorMessage = "Invalid username or password";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Patient Login"),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.login_rounded,
                        size: 48,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sign in to continue",
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),

                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Enter your username",
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
                      ),
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[600],
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    ),
                    const SizedBox(height: 24),

                    if (_errorMessage != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Register",
                              style: TextStyle(
                                color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  int? _selectedPicIndex = 0;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final List<Map<String, dynamic>> avatars = [
    {'icon': Icons.person, 'color': Colors.blue},
    {'icon': Icons.face, 'color': Colors.green},
    {'icon': Icons.account_circle, 'color': Colors.orange},
    {'icon': Icons.emoji_emotions, 'color': Colors.purple},
    {'icon': Icons.sentiment_satisfied_alt, 'color': Colors.pink},
    {'icon': Icons.boy, 'color': Colors.teal},
    {'icon': Icons.girl, 'color': Colors.deepOrange},
    {'icon': Icons.accessibility_new, 'color': Colors.indigo},
  ];

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedPicIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a profile picture"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final user = {
      'username': _usernameController.text.trim(),
      'password': _passwordController.text,
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'profile_pic_index': _selectedPicIndex!,
    };

    try {
      await DatabaseHelper.instance.registerUser(user);
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Create Account"),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_add_rounded,
                          size: 48,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Create your patient account",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 32),

                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          hintText: "Choose a username",
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        validator: (val) => 
                            (val == null || val.length < 3) ? "Min 3 characters" : null,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "your.email@example.com",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        validator: (val) =>
                            (val == null || !val.contains('@')) ? "Invalid email" : null,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: "Phone",
                          hintText: "+1234567890",
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        validator: (val) =>
                            (val == null || val.length < 10) ? "Invalid phone" : null,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Min 6 characters",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey[600],
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        validator: (val) =>
                            (val == null || val.length < 6) ? "Min 6 characters" : null,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _confirmPassController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          hintText: "Re-enter password",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey[600],
                            ),
                            onPressed: () => 
                                setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                          ),
                        ),
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        validator: (val) => (val != _passwordController.text)
                            ? "Passwords don't match"
                            : null,
                      ),
                      const SizedBox(height: 24),

                      Text(
                        "Choose a Profile Avatar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: avatars.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedPicIndex == index;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedPicIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? avatars[index]['color'].withOpacity(0.15)
                                    : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? avatars[index]['color'] : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
                                  width: isSelected ? 3 : 2,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: avatars[index]['color'].withOpacity(0.3),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    avatars[index]['icon'],
                                    size: 36,
                                    color: avatars[index]['color'],
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(height: 4),
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: avatars[index]['color'],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),

                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleRegister,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text("Register"),
                      ),
                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 14),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                  color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DashboardPage({super.key, required this.userData});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    themeNotifier.addListener(_onThemeChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    themeNotifier.removeListener(_onThemeChange);
    super.dispose();
  }

  void _onThemeChange() {
    setState(() {});
  }

  void _showSettingsDialog() {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.settings,
                    color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.notifications_outlined,
                    color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                  ),
                  title: Text(
                    "Notifications",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                  subtitle: Text(
                    "Manage notifications",
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12),
                  ),
                  trailing: Icon(Icons.chevron_right, color: isDark ? Colors.grey[400] : Colors.grey),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.language_outlined,
                    color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                  ),
                  title: Text(
                    "Language",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                  subtitle: Text(
                    "English",
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12),
                  ),
                  trailing: Icon(Icons.chevron_right, color: isDark ? Colors.grey[400] : Colors.grey),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                  ),
                  title: Text(
                    "Privacy",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                  subtitle: Text(
                    "Manage your data",
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12),
                  ),
                  trailing: Icon(Icons.chevron_right, color: isDark ? Colors.grey[400] : Colors.grey),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                  ),
                  title: Text(
                    "About",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                  subtitle: Text(
                    "Version 1.0.0",
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12),
                  ),
                  trailing: Icon(Icons.chevron_right, color: isDark ? Colors.grey[400] : Colors.grey),
                  onTap: () {},
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Close",
                  style: TextStyle(color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        // Background color matched to the content area instead of Primary Blue
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        
        // TabBar moved to Title
        title: TabBar(
          controller: _tabController,
          labelColor: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
          unselectedLabelColor: isDark ? Colors.grey[500] : Colors.grey,
          indicatorColor: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(icon: Icon(Icons.home_rounded, size: 20), text: "Home"),
            Tab(icon: Icon(Icons.add_box_rounded, size: 20), text: "Request"),
            Tab(icon: Icon(Icons.history_rounded, size: 20), text: "History"),
            Tab(icon: Icon(Icons.person_rounded, size: 20), text: "Profile"),
          ],
        ),

        // Buttons moved to Actions
        actions: [
          Center(child: _buildThemeToggle(isDark)),
          const SizedBox(width: 8),
          Center(child: _buildSettingsButton(isDark)),
          const SizedBox(width: 16),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        // Removed 'const' keyword to allow rebuilding when theme changes
        children: [
          HomePage(userData: widget.userData),
          ApplyXrayPage(), 
          HistoryPage(),
          ProfilePage(userData: widget.userData),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark) {
    return GestureDetector(
      onTap: () {
        themeNotifier.toggleTheme();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark 
              ? Colors.white.withOpacity(0.1) 
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween(begin: 0.5, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDark),
            color: isDark ? Colors.amber : Colors.blueGrey,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsButton(bool isDark) {
    return GestureDetector(
      onTap: _showSettingsDialog,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark 
              ? Colors.white.withOpacity(0.1) 
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.settings_rounded,
          color: isDark ? Colors.white70 : Colors.blueGrey,
          size: 20,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, dynamic> userData;
  const HomePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome, ${userData['username']}!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Your medical dashboard",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 40),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.dashboard_customize,
                    size: 80,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Add Your Custom Elements Here",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "This section is ready for your custom widgets and components",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfilePage({super.key, required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isHovering = false;
  late int _currentProfilePicIndex;
  
  @override
  void initState() {
    super.initState();
    _currentProfilePicIndex = widget.userData['profile_pic_index'] ?? 0;
  }
  
  final List<Map<String, dynamic>> avatars = [
    {'icon': Icons.person, 'color': Colors.blue},
    {'icon': Icons.face, 'color': Colors.green},
    {'icon': Icons.account_circle, 'color': Colors.orange},
    {'icon': Icons.emoji_emotions, 'color': Colors.purple},
    {'icon': Icons.sentiment_satisfied_alt, 'color': Colors.pink},
    {'icon': Icons.boy, 'color': Colors.teal},
    {'icon': Icons.girl, 'color': Colors.deepOrange},
    {'icon': Icons.accessibility_new, 'color': Colors.indigo},
  ];

  void _showProfilePictureDialog() {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Choose Profile Picture",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: isDark ? Colors.white70 : Colors.black54),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: avatars.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _currentProfilePicIndex;
                    return InkWell(
                      onTap: () async {
                        setState(() {
                          _currentProfilePicIndex = index;
                        });
                        
                        final db = await DatabaseHelper.instance.database;
                        await db.update(
                          'users',
                          {'profile_pic_index': index},
                          where: 'id = ?',
                          whereArgs: [widget.userData['id']],
                        );
                        
                        if (!mounted) return;
                        Navigator.of(context).pop();
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 12),
                                Text("Profile picture updated!"),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? const Color(0xFF2196F3).withOpacity(0.1)
                              : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected 
                                ? const Color(0xFF2196F3)
                                : (isDark ? Colors.grey.shade600 : Colors.grey.shade300),
                            width: isSelected ? 3 : 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                avatars[index]['icon'],
                                size: 40,
                                color: avatars[index]['color'],
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2196F3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final int patientId = widget.userData['id'] ?? 0;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (_) => setState(() => _isHovering = true),
                                    onExit: (_) => setState(() => _isHovering = false),
                                    child: GestureDetector(
                                      onTap: _showProfilePictureDialog,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: _isHovering 
                                                    ? const Color(0xFF2196F3)
                                                    : (isDark ? Colors.grey.shade600 : Colors.grey.shade300), 
                                                width: 3
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: _isHovering
                                                      ? const Color(0xFF2196F3).withOpacity(0.3)
                                                      : Colors.black.withOpacity(0.1),
                                                  blurRadius: 15,
                                                  offset: const Offset(0, 5),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              avatars[_currentProfilePicIndex]['icon'],
                                              size: 50,
                                              color: avatars[_currentProfilePicIndex]['color'],
                                            ),
                                          ),
                                          if (_isHovering)
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.6),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 28,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    "Change",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.userData['username'],
                                          style: TextStyle(
                                            color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2196F3).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            "Patient Account",
                                            style: TextStyle(
                                              color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Divider(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                              const SizedBox(height: 16),
                              
                              _buildInfoRow(
                                icon: Icons.person_outline,
                                label: "Username",
                                value: widget.userData['username'],
                                color: Colors.blue,
                                isDark: isDark,
                              ),
                              Divider(height: 32, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                              _buildInfoRow(
                                icon: Icons.badge_outlined,
                                label: "Patient ID",
                                value: "PT-${patientId.toString().padLeft(6, '0')}",
                                color: Colors.purple,
                                isDark: isDark,
                              ),
                              Divider(height: 32, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                              _buildInfoRow(
                                icon: Icons.phone_outlined,
                                label: "Phone Number",
                                value: widget.userData['phone'],
                                color: Colors.green,
                                isDark: isDark,
                              ),
                              Divider(height: 32, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                              _buildInfoRow(
                                icon: Icons.email_outlined,
                                label: "Email Address",
                                value: widget.userData['email'],
                                color: Colors.blue,
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      Text(
                        "Medical Reports",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2196F3).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.description_outlined,
                                      color: Color(0xFF2196F3),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Your Medical History",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? Colors.white : Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "View all your X-Ray reports and medical records",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.folder_open),
                                  label: const Text("View Reports"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const WelcomePage()),
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildFooter(),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.grey.shade100,
        border: Border(
          top: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.health_and_safety,
            color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            "XRBone",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "© 2024",
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey[600] : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

class ApplyXrayPage extends StatefulWidget {
  const ApplyXrayPage({super.key});

  @override
  State<ApplyXrayPage> createState() => _ApplyXrayPageState();
}

class _ApplyXrayPageState extends State<ApplyXrayPage> {
  File? _selectedImage;
  String? _analysisResult;
  bool _isAnalyzing = false;
  Uint8List? _resultImageBytes;
  String? _annotatedImageB64;

  Future<void> _saveReportToHistory() async {
    if (_analysisResult == null) return;

    try {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);

      await DatabaseHelper.instance.insertRequest({
        'patient_name': 'Patient',      // later you can use real username
        'body_part': 'Unknown',         // later: dropdown / text field
        'date': formattedDate,
        'status': 'Completed',
        'result_summary': _analysisResult!,   
        'annotated_image_b64': _annotatedImageB64, 
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report saved to history'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save history: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedImage = File(result.files.single.path!);
          _analysisResult = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 12),
              Text("Error picking image: $e"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

Future<void> _analyzeImage() async {
  if (_selectedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.warning, color: Colors.white),
            SizedBox(width: 12),
            Text("Please select an image first"),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
    return;
  }

  setState(() {
    _isAnalyzing = true;
    _analysisResult = null;
    _resultImageBytes = null;
  });

  try {
    final uri = Uri.parse('http://127.0.0.1:8000/predict');

    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath('file', _selectedImage!.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['error'] != null) {
        setState(() {
          _analysisResult = "AI server error: ${data['error']}";
        });
      } else {
        final bool hasFracture = data['has_fracture'] ?? false;
        final double bestConf =
            (data['best_confidence'] ?? 0.0).toDouble();
        final int numBoxes = data['num_boxes'] ?? 0;

        final String? imgB64 = data['annotated_image_b64'];

        Uint8List? bytes;
        if (imgB64 != null) {
          bytes = base64Decode(imgB64);
        }

        setState(() {
          _resultImageBytes = bytes;
          _annotatedImageB64 = imgB64;
          _analysisResult = [
            "AI Result:",
            hasFracture
                ? "⚠ Fracture DETECTED"
                : "✅ No fracture detected",
            "Best confidence: ${(bestConf * 100).toStringAsFixed(1)}%",
            "Detected boxes: $numBoxes",
          ].join("\n");
        });
      }
    } else {
      setState(() {
        _analysisResult =
            "Error from AI server (status ${response.statusCode}):\n${response.body}";
      });
    }
  } catch (e) {
    setState(() {
      _analysisResult = "Error contacting AI server:\n$e";
    });
  } finally {
    if (mounted) {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }
}



void _clearImage() {
  setState(() {
    _selectedImage = null;
    _analysisResult = null;
    _resultImageBytes = null; // NEW
  });
}



  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2196F3).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.upload_file,
                                    color: Color(0xFF2196F3),
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  "Upload X-Ray Image",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: _selectedImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.file(
                                              _selectedImage!,
                                              fit: BoxFit.contain,
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                onPressed: _clearImage,
                                                icon: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload_outlined,
                                            size: 64,
                                            color: isDark ? Colors.grey[500] : Colors.grey[400],
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            "Click to upload X-Ray image",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Supports PNG, JPG, JPEG",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark ? Colors.grey[600] : Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            ElevatedButton.icon(
                              onPressed: _isAnalyzing ? null : _analyzeImage,
                              icon: _isAnalyzing
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.analytics),
                              label: Text(_isAnalyzing ? "Analyzing..." : "Analyze X-Ray"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),

                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.assessment,
                                    color: Colors.green,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  "Analysis Results",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            Container(
                              height: 250,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                                ),
                              ),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    if (_isAnalyzing) ...[
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Analyzing X-ray, please wait..."),
          ],
        ),
      ),
    ] else ...[
      if (_analysisResult != null)
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              _analysisResult!,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        )
      else
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pending_actions,
                  size: 48,
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  "Results will appear here",
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      const SizedBox(height: 12),
      if (_resultImageBytes != null) ...[
        const Text(
          "Annotated X-ray:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GestureDetector(
  onTap: () {
    if (_resultImageBytes != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FullScreenXrayPage(
            imageBytes: _resultImageBytes!,
            isDark: isDark,
          ),
        ),
      );
    }
  },
  child: Container(
    height: 200, // you can increase to 250/300 if you want bigger preview
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
        color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        _resultImageBytes!,
        fit: BoxFit.contain,
      ),
    ),
  ),
),

        ),
      ],
    ],
  ],
),

                            ),
                            const SizedBox(height: 24),

                            OutlinedButton.icon(
                                onPressed: _analysisResult != null
                                      ? () async {
                                      await _saveReportToHistory();
                                     }
                                : null,
                              icon: const Icon(Icons.save_alt),
                              label: const Text("Save Report"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    _requestsFuture = DatabaseHelper.instance.fetchRequests();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending Review':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending Review':
        return Icons.hourglass_empty;
      case 'Completed':
        return Icons.check_circle;
      case 'In Progress':
        return Icons.sync;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Correct way to check theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return FutureBuilder(
      future: _requestsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        final requests = snapshot.data as List<Map<String, dynamic>>? ?? [];
        
        if (requests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.history_rounded,
                    size: 80,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "No Requests Yet",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your request history will appear here",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final r = requests[index];
            final statusColor = _getStatusColor(r['status']);
            final statusIcon = _getStatusIcon(r['status']);
            
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 3,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ReportDetailPage(request: r),
    ),
  );
},
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            statusIcon,
                            color: statusColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${r['body_part']} X-Ray",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.person_outline, 
                                      size: 16, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    r['patient_name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDark ? Colors.grey[400] : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, 
                                      size: 16, color: isDark ? Colors.grey[500] : Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    r['date'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDark ? Colors.grey[500] : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: statusColor.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            r['status'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ReportDetailPage extends StatelessWidget {
  final Map<String, dynamic> request;

  const ReportDetailPage({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Decode annotated image if available
    Uint8List? imageBytes;
    final String? imgB64 = request['annotated_image_b64'];
    if (imgB64 != null && imgB64.isNotEmpty) {
      try {
        imageBytes = base64Decode(imgB64);
      } catch (_) {}
    }

    final String resultSummary =
        request['result_summary'] ?? 'No analysis summary stored.';

    return Scaffold(
      appBar: AppBar(
        title: Text("${request['body_part']} X-Ray Report"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header (patient + date + status)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['patient_name'] ?? 'Patient',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request['date'] ?? '',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: Text(request['status'] ?? 'Unknown'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // SAME CARD STYLE AS ANALYSIS
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.assessment,
                                color: Colors.green,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Analysis Results",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Text summary
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2A2A2A)
                                : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            resultSummary,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color:
                                  isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        if (imageBytes != null) ...[
                          const Text(
                            "Annotated X-ray:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => FullScreenXrayPage(
                                    imageBytes: imageBytes!,
                                    isDark: isDark,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isDark
                                      ? Colors.grey.shade700
                                      : Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  imageBytes!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class FullScreenXrayPage extends StatelessWidget {
  final Uint8List imageBytes;
  final bool isDark;

  const FullScreenXrayPage({
    Key? key,
    required this.imageBytes,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Text(
          'Annotated X-ray',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.memory(
            imageBytes,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
