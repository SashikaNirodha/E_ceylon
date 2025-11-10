import 'package:e_ceylon_unified_app/main_copy.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:async';
import '../firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// In main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  runApp(ECeylonUnifiedApp());
}

class ECeylonUnifiedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Ceylon Unified System',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFF4DA1A9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4DA1A9),
          foregroundColor: Colors.white,
        ),
      ),
      home: RoleSelectionScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/role_selection': (context) => RoleSelectionScreen(),
        // User routes
        '/user_signin': (context) => UserSigninScreen(),
        '/user_login': (context) => UserLoginScreen(),
        '/user_dashboard': (context) => UserDashboardScreen(),
        '/user_wallet': (context) => UserWalletScreen(),
        '/user_scan': (context) => UserScanScreen(),
        '/payment_confirmation': (context) => PaymentConfirmationScreen(),
        '/payment_complete': (context) => PaymentCompleteScreen(),
        // Conductor routes
        '/conductor_login': (context) => ConductorLoginScreen(),
        '/conductor_dashboard': (context) => ConductorDashboardScreen(),
        '/qr_generator': (context) => QRGeneratorScreen(),
        '/conductor_wallet': (context) => ConductorWalletScreen(),
        // Owner routes
        '/owner_signin': (context) => OwnerSigninScreen(),
        '/owner_login': (context) => OwnerLoginScreen(),
        '/owner_dashboard': (context) => OwnerDashboardScreen(),
        // Money Agent routes
        '/agent_register': (context) => MoneyAgentRegisterScreen(),
        '/agent_login': (context) => MoneyAgentLoginScreen(),
        '/agent_dashboard': (context) => MoneyAgentDashboardScreen(),
        '/agent_transfer': (context) => MoneyAgentTransferScreen(),
        '/agent_confirm': (context) => MoneyAgentConfirmScreen(),
        '/agent_success': (context) => MoneyAgentSuccessScreen(),
      },
    );
  }
}

// ============== ROLE SELECTION SCREEN ==============
class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4DA1A9), //backfround color
      appBar: AppBar(
        /*title: const Text(
          "E CEYLON",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,*/
        backgroundColor: const Color(0xFF4DA1A9),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Center(
              child: Image(
                image: AssetImage('images/logo.png'),
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
                height: 300,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFF92BCC0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRoleButton(context, "User", '/user_signin'),
                    const SizedBox(height: 10),
                    _buildRoleButton(context, "Owner", '/owner_signin'),
                    const SizedBox(height: 10),
                    _buildRoleButton(context, "Conductor", '/conductor_login'),
                    const SizedBox(height: 10),
                    _buildRoleButton(context, "Money Agent", '/agent_register'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String role, String route) {
    return Container(
      height: 50,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFF2E5077),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2E5077),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          role,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

// ============== USER SCREENS ==============

//select user sign in or login
/*class SigninOrLogin extends StatelessWidget {
  const SigninOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.home_filled),
        title: const Text(
          "E-CEYLON",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        /* actions: [
          Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.menu)),
        ],*/
        backgroundColor: const Color(0xff4DA1A9),
      ),
      backgroundColor: const Color(0xff4DA1A9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle_rounded,
                size: 100), //user icon REPLACE HERE IMAGE
            const SizedBox(height: 20),
            Container(
              height: 200,
              width: 311,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff92BCC0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                              color: Color(0xff2E5077),
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the login page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserLoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            backgroundColor:
                                const Color(0xff2E5077), // Background color
                            foregroundColor:
                                Colors.white, // Text (and icon) color
                          ),
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ), //need to convert as a button
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the sign-in page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserSigninScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            backgroundColor:
                                const Color(0xff2E5077), // Background color
                            foregroundColor:
                                Colors.white, // Text (and icon) color
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ), //need to convert as a button
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

class UserSigninScreen extends StatefulWidget {
  @override
  _UserSigninScreenState createState() => _UserSigninScreenState();
}

class _UserSigninScreenState extends State<UserSigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final cardWidth = mq.width * 0.86;
    final cardMaxWidth = 380.0;

    return Scaffold(
      backgroundColor: const Color(0xFF4DA1A9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_filled),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/role_selection'),
        ),
        title: const Text("User Registration"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              const Icon(Icons.account_circle_rounded, size: 100),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: cardMaxWidth),
                  height: 500,
                  width: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFF92BCC0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF2E5077),
                                fontSize: 26,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _buildTextField(
                              "Email", _emailController, Icons.email),
                          const SizedBox(height: 10),
                          _buildTextField(
                              "Username", _usernameController, Icons.person),
                          const SizedBox(height: 10),
                          _buildTextField(
                              "Password", _passwordController, Icons.lock,
                              obscure: true),
                          const SizedBox(height: 40),
                          Center(
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(     //button size
                                  height: 53,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() => _isLoading = true);
                                          try {
                                            final user =
                                                await FirebaseService.signUp(
                                              _emailController.text.trim(),
                                              _passwordController.text.trim(),
                                            );
                                            if (user != null) {
                                              await FirebaseService.createData(
                                                'users',
                                                user.uid,
                                                {
                                                  'email': _emailController.text
                                                      .trim(),
                                                  'username': _usernameController
                                                      .text
                                                      .trim(),
                                                  'role': 'user',
                                                  'balance': 1000.0,
                                                  'createdAt': DateTime.now()
                                                      .toIso8601String(),
                                                },
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Registration Successful!')),
                                              );
                                              Navigator.pushNamed(
                                                  context, '/user_login');
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Registration failed: ${e.toString()}')),
                                            );
                                          } finally {
                                            setState(() => _isLoading = false);
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2E5077),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 18),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      ),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ),
                          ),
                          const SizedBox(height: 20),
                          // 👇 Added Login Button Below Sign Up
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/user_login');
                              },
                              child: const Text(
                                "Already have an account? Login",
                                style: TextStyle(
                                  color: Color(0xFF2E5077),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF2E5077), fontSize: 16)),
        const SizedBox(height: 5),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF2E5077)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter $label' : null,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

/*class UserSigninScreen extends StatefulWidget {
  @override
  _UserSigninScreenState createState() => _UserSigninScreenState();
}

class _UserSigninScreenState extends State<UserSigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final cardWidth = mq.width * 0.86; // responsive width
    final cardMaxWidth = 380.0;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 224, 224),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_filled),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/role_selection'),
        ),
        title: Text("User Registration"),
        centerTitle: true,
        actions: [Icon(Icons.menu)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              const Icon(Icons.account_circle_rounded, size: 100),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: cardMaxWidth),
                  width: cardWidth > cardMaxWidth ? cardMaxWidth : cardWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF92BCC0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text("Sign Up",
                                style: TextStyle(
                                    color: Color(0xFF2E5077), fontSize: 26)),
                          ),
                          const SizedBox(height: 14),
                          _buildTextField(
                              "Email", _emailController, Icons.email),
                          const SizedBox(height: 10),
                          _buildTextField(
                              "Username", _usernameController, Icons.person),
                          const SizedBox(height: 10),
                          _buildTextField(
                              "Password", _passwordController, Icons.lock,
                              obscure: true),
                          const SizedBox(height: 16),
                          Center(
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => _isLoading = true);
                                        try {
                                          final user =
                                              await FirebaseService.signUp(
                                            _emailController.text.trim(),
                                            _passwordController.text.trim(),
                                          );
                                          if (user != null) {
                                            await FirebaseService.createData(
                                              'users',
                                              user.uid,
                                              {
                                                'email': _emailController.text
                                                    .trim(),
                                                'username': _usernameController
                                                    .text
                                                    .trim(),
                                                'role': 'user',
                                                'balance': 1000.0,
                                                'createdAt': DateTime.now()
                                                    .toIso8601String(),
                                              },
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Registration Successful!')),
                                            );
                                            Navigator.pushNamed(
                                                context, '/user_login');
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Registration failed: ${e.toString()}')),
                                          );
                                        } finally {
                                          setState(() => _isLoading = false);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF2E5077)),
                                    child: Text("Sign Up",
                                        style: TextStyle(color: Colors.white)),
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
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color(0xFF2E5077), fontSize: 16)),
        SizedBox(height: 5),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Color(0xFF2E5077)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter $label' : null,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}*/

//user login screen
class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4DA1A9),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home_filled),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/role_selection'),
        ),
        title: Text("User Login"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle_rounded, size: 100),
              SizedBox(height: 20),
              Container(
                height: 400,
                width: 311,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF92BCC0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("Log in",
                            style: TextStyle(
                                color: Color(0xFF2E5077), fontSize: 30)),
                        SizedBox(height: 30),
                        _buildTextField(
                            "Username", _usernameController, Icons.person),
                        SizedBox(height: 20),
                        _buildTextField(
                            "Password", _passwordController, Icons.lock,
                            obscure: true),
                        SizedBox(height: 40),
                        _isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _isLoading = true);
                                    try {
                                      // Find user by username in Firestore
                                      final users =
                                          await FirebaseService.getAll('users');
                                      QueryDocumentSnapshot? userDoc;
                                      for (var doc in users) {
                                        if (doc['username'] ==
                                            _usernameController.text.trim()) {
                                          userDoc = doc;
                                          break;
                                        }
                                      }
                                      if (userDoc == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text('User not found')),
                                        );
                                        return;
                                      }
                                      final email = userDoc['email'];
                                      final user = await FirebaseService.signIn(
                                        email,
                                        _passwordController.text.trim(),
                                      );
                                      if (user != null) {
                                        Navigator.pushReplacementNamed(
                                            context, '/user_dashboard');
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Login failed: ${e.toString()}')),
                                      );
                                    } finally {
                                      setState(() => _isLoading = false);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF2E5077)),
                                child: const Text("Login",
                                    style: TextStyle(color: Colors.white)),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Color(0xFF2E5077), fontSize: 20)),
        SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Color(0xFF2E5077)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter $label' : null,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class UserDashboardScreen extends StatelessWidget {
  Future<Map<String, dynamic>?> _getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      final doc = await FirebaseService.readData('users', user.uid);
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  Widget _buildDashboardButton(
      BuildContext context, String title, String route) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Color(0xFF2E5077),
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.home_filled),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/role_selection'),
              ),
              title: Text("E-CEYLON"),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.menu),
                )
              ],
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.home_filled),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/role_selection'),
              ),
              title: Text("E-CEYLON"),
              centerTitle: true,
              actions: [Icon(Icons.menu)],
            ),
            body: Center(child: Text('Error loading user data')),
          );
        }
        final userData = snapshot.data!;
        final username = userData['username'] ?? 'Username';

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.home_filled),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/role_selection'),
            ),
            title: Text("E CEYLON"),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.menu),
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome, $username',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  width: 290,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFF92BCC0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDashboardButton(context, "Wallet", '/user_wallet'),
                      SizedBox(height: 30),
                      _buildDashboardButton(context, "Scan", '/user_scan'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserWalletScreen extends StatelessWidget {
  Future<Map<String, dynamic>?> _getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      final doc = await FirebaseService.readData('users', user.uid);
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text("E-CEYLON"),
              centerTitle: true,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text("E-CEYLON"),
              centerTitle: true,
            ),
            body: Center(child: Text('Error loading wallet data')),
          );
        }
        final userData = snapshot.data!;
        final username = userData['username'] ?? 'Username';
        final balance = (userData['balance'] ?? 0.0).toDouble();

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text("E CEYLON"),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      color: Color.fromARGB(255, 188, 207, 229),
                    ),
                    child: Icon(Icons.person, size: 60, color: Colors.black),
                  ),
                  Text("$username",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                  SizedBox(height: 80),
                  Text("Wallet",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  SizedBox(height: 10),
                  Container(
                    width: 348,
                    height: 248,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF2E5077),
                    ),
                    child: Center(
                      child: Container(
                        height: 116,
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 206, 210, 215),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Total Balance",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            SizedBox(height: 10),
                            Text("LKR ${balance.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//scan screen

class UserScanScreen extends StatefulWidget {
  @override
  _UserScanScreenState createState() => _UserScanScreenState();
}

class _UserScanScreenState extends State<UserScanScreen>
    with WidgetsBindingObserver {
  MobileScannerController? controller;
  String? scannedData;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController();
    _initializeScanner();
  }

  Future<void> _initializeScanner() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      await controller?.start();
      setState(() {});
    } else {
      _showPermissionDialog();
    }
  }

  void _handleBarcode(BarcodeCapture capture) {
    if (!isScanning) return;
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      setState(() {
        scannedData = barcodes.first.rawValue;
        isScanning = false;
      });
      controller?.stop();
      _processPayment(scannedData!);
    }
  }

  void _processPayment(String qrData) {
    try {
      final paymentData = jsonDecode(qrData);
      if (paymentData['type'] == 'bus_payment') {
        Navigator.pushNamed(context, '/payment_confirmation',
            arguments: paymentData);
      } else {
        _showErrorDialog('Invalid QR Code');
      }
    } catch (e) {
      _showErrorDialog('Invalid QR Code format');
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Camera Permission Required'),
        content: Text('This app needs camera access to scan QR codes.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetScanner();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetScanner() {
    setState(() {
      scannedData = null;
      isScanning = true;
    });
    controller?.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("E-CEYLON"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    if (controller != null)
                      MobileScanner(
                        controller: controller!,
                        onDetect: _handleBarcode,
                      )
                    else
                      Container(
                        color: Colors.black,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                'Place QR code here',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF92BCC0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Point camera at QR code to scan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }
}

class PaymentConfirmationScreen extends StatelessWidget {
  Widget _buildInfoContainer(String text) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF2E5077),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> paymentData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Payment Confirmation"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 600,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFF92BCC0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Text("Sender",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                _buildInfoContainer("Username"),
                SizedBox(height: 40),
                Text("Receiver",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                _buildInfoContainer(
                    "Bus ${paymentData['busNumber'] ?? 'Unknown'}"),
                SizedBox(height: 40),
                Text("Amount",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                _buildInfoContainer(
                    "Rs. ${paymentData['amount']?.toString() ?? '0.00'}"),
                SizedBox(height: 80),
                SizedBox(
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    /*onPressed: () async {
                      try {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User not logged in')));
                          return;
                        }

                        final amount = (paymentData['amount'] ?? 0).toDouble();
                        final busNumber = paymentData['busNumber'] ?? 'BUS001';

                        // Check user balance first
                        final userDoc =
                            await FirebaseService.readData('users', user.uid);
                        final userData =
                            userDoc.data() as Map<String, dynamic>? ?? {};
                        final currentBalance =
                            (userData['balance'] ?? 0).toDouble();

                        if (currentBalance < amount) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Insufficient balance')));
                          return;
                        }

                        // Create transaction
                        final tx = {
                          'type': 'bus_payment',
                          'amount': amount,
                          'from': user.uid,
                          'to': busNumber,
                          'timestamp': DateTime.now().toIso8601String(),
                        };

                        await FirebaseService.createData(
                            'transactions',
                            DateTime.now().millisecondsSinceEpoch.toString(),
                            tx);

                        // Update user balance
                        await FirebaseService.updateData('users', user.uid,
                            {'balance': currentBalance - amount});

                        // Update conductor wallet
                        try {
                          final walletDoc = await FirebaseService.readData(
                              'conductors_wallets', busNumber);
                          final walletData =
                              walletDoc.data() as Map<String, dynamic>? ?? {};
                          final walletBalance =
                              (walletData['balance'] ?? 0).toDouble();
                          await FirebaseService.createData('conductors_wallets',
                              busNumber, {'balance': walletBalance + amount});
                        } catch (_) {
                          await FirebaseService.createData('conductors_wallets',
                              busNumber, {'balance': amount});
                        }

                        Navigator.pushNamed(context, '/payment_complete');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Payment failed: ${e.toString()}')));
                      }
                    },*/
                    onPressed: () async {
                    // Show a loading dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => Center(child: CircularProgressIndicator()),
                          );

                          try {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user == null) {
                              throw Exception('User not logged in');
                            }

                            final amount = (paymentData['amount'] ?? 0).toDouble();
                            final busNumber = paymentData['busNumber'] ?? 'BUS001';

                            // Check user balance (this part is fine)
                            final userDoc = await FirebaseService.readData('users', user.uid);
                            final userData = userDoc.data() as Map<String, dynamic>? ?? {};
                            final currentBalance = (userData['balance'] ?? 0).toDouble();

                            if (currentBalance < amount) {
                              throw Exception('Insufficient balance');
                            }

                            // --- START OF CORRECTED LOGIC ---

                            // 1. Create the transaction document
                            final tx = {
                              'type': 'bus_payment',
                              'amount': amount,
                              'from': user.uid,
                              'from_username': userData['username'] ?? 'Unknown User', // Added for clarity
                              'to': busNumber,
                              'timestamp': FieldValue.serverTimestamp(), // Use server timestamp
                            };
                            // Use .add() to get an automatic ID for the transaction
                            // Note: If you don't have a direct Firestore instance here, you must use FirebaseService.addData
                            // We will assume FirebaseService.addData is used based on the previous context, or use the direct instance:
                            await FirebaseFirestore.instance.collection('transactions').add(tx);

                            // 2. Atomically update user's balance
                            await FirebaseService.updateData('users', user.uid, {
                              'balance': FieldValue.increment(-amount) // Atomically subtracts
                            });

                            // 3. Atomically update conductor's wallet
                            await FirebaseService.updateData('conductors_wallets', busNumber, {
                              'balance': FieldValue.increment(amount), // Atomically adds
                              'last_updated': FieldValue.serverTimestamp()
                            });

                            // --- END OF CORRECTED LOGIC ---

                            Navigator.pop(context); // Close loading dialog
                            Navigator.pushNamed(context, '/payment_complete');

                          } catch (e) {
                            Navigator.pop(context); // Close loading dialog on error
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Payment failed: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Color(0xFF2E5077),
                    ),
                    child: const Text(
                      "Pay",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
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


class PaymentCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/user_dashboard'),
        ),
        title: Text("Payment Complete"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFF92BCC0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Payment Successful!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Icon(Icons.check_circle, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Thank you for your payment.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 70),
              SizedBox(
                width: 170,
                height: 60,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/user_wallet'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E5077),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Back to Wallet',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============== CONDUCTOR SCREENS ==============

class ConductorLoginScreen extends StatefulWidget {
  @override
  _ConductorLoginScreenState createState() => _ConductorLoginScreenState();
}

class _ConductorLoginScreenState extends State<ConductorLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  /// ✅ LOGIN FUNCTION (using Firestore 'conductors' collection)
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final username = _usernameController.text.trim();
        final password = _passwordController.text.trim();

        // 🔥 Fetch matching conductor document from Firestore
        final query = await FirebaseFirestore.instance
            .collection('conductors')
            .where('username', isEqualTo: username)
            .get();

        if (query.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Conductor not found')),
          );
          return;
        }

        final conductorData = query.docs.first.data();
        final storedPassword = conductorData['password'] ?? '';

        if (storedPassword == password) {
          // ✅ Successful login
          Navigator.pushReplacementNamed(
            context,
            '/conductor_dashboard',
            arguments: {'busNumber': username},
          );
        } else {
          // ❌ Invalid password
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid password')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      appBar: AppBar(
        backgroundColor: Color(0xFF4DA1A9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/role_selection'),
        ),
        title: Text("Conductor Login"),
        centerTitle: true,
        actions: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 311,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xFF92BCC0),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, size: 40, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 16),
                Text(
                  'Conductor Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3E4E),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Bus Number',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter bus number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                _isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        width: 130,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2E5077),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class QRGeneratorScreen extends StatefulWidget {
  @override
  _QRGeneratorScreenState createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _qrData;
  bool _isQRGenerated = false;
  bool _isGenerating = false;

  void _generateQR() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isGenerating = true;
      });

      await Future.delayed(Duration(seconds: 2));

      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
              {};
      final String busNumber = args['busNumber'] ?? 'BUS001';
      double amount = double.parse(_amountController.text);

      Map<String, dynamic> qrPayload = {
        'busNumber': busNumber,
        'amount': amount,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'type': 'bus_payment',
        'conductorId': busNumber,
      };

      setState(() {
        _qrData = jsonEncode(qrPayload);
        _isQRGenerated = true;
        _isGenerating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'QR Code generated for Bus $busNumber - Amount: Rs.${amount.toStringAsFixed(2)}',
          ),
          backgroundColor: Color(0xFF4ECDC4),
        ),
      );
    }
  }

  void _resetGeneration() {
    setState(() {
      _qrData = null;
      _isQRGenerated = false;
      _isGenerating = false;
      _amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    final String busNumber = args['busNumber'] ?? 'BUS001';

    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      appBar: AppBar(
        backgroundColor: Color(0xFF4DA1A9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'QR GENERATOR',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Container(
          width: 400,
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isGenerating) ...[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFF2D3E4E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Rs.${double.parse(_amountController.text).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Icon(Icons.qr_code_2, size: 60, color: Color(0xFF4ECDC4)),
                      SizedBox(height: 20),
                      Text(
                        'YOUR QR IS GENERATING...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3E4E),
                        ),
                      ),
                      SizedBox(height: 20),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Color(0xFF4ECDC4)),
                      ),
                    ],
                  ),
                ),
              ] else if (!_isQRGenerated) ...[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF92BCC0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Enter Amount',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3E4E),
                          ),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: _amountController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Amount (Rs)',
                            prefixIcon: Icon(Icons.currency_exchange),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              //borderSide: BorderSide(color: Color.fromARGB(255, 223, 227, 226)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount';
                            }
                            double? amount = double.tryParse(value);
                            if (amount == null || amount <= 0) {
                              return 'Please enter valid amount';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 180,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _generateQR,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2E5077),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              'Generate QR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFF2D3E4E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Rs.${double.parse(_amountController.text).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QrImageView(
                          data: _qrData!,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF4ECDC4).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bus Number:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  busNumber,
                                  style: TextStyle(
                                    color: Color(0xFF4ECDC4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Amount:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  'Rs.${_amountController.text}',
                                  style: TextStyle(
                                    color: Color(0xFF4ECDC4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _resetGeneration,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[600],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'NEW QR',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('QR Data: $_qrData'),
                                    backgroundColor: Color(0xFF4ECDC4),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4ECDC4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'SHOW DATA',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}

//conductor wallet screen

class ConductorWalletScreen extends StatefulWidget {
  @override
  _ConductorWalletScreenState createState() => _ConductorWalletScreenState();
}

class _ConductorWalletScreenState extends State<ConductorWalletScreen> {
  String busNumber = 'BUS001'; // Default value

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get arguments only once
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    busNumber = args['busNumber'] ?? 'BUS001';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4ECDC4),
      appBar: AppBar(
        backgroundColor: Color(0xFF4ECDC4),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CONDUCTOR WALLET',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      // Use StreamBuilder to get LIVE updates
      body: StreamBuilder<DocumentSnapshot>(
        // Stream the data from the 'conductors_wallets' document
        stream: FirebaseService.streamData('conductors_wallets', busNumber),
        builder: (context, snapshot) {

          // Handle loading and error states
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.white));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            // Initialize wallet if it doesn't exist yet (good practice)
            // You might add logic here to create the document with a starting balance of 0.0
            // but for now, we just show "not found".
            return Center(child: Text('Wallet not found for $busNumber', style: TextStyle(color: Colors.white)));
          }

          // Get data from the snapshot
          final walletData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
          // Ensure balance is retrieved as a double, defaulting to 0.0
          final double balance = (walletData['balance'] is num ? walletData['balance'].toDouble() : 0.0);

          // This is your original UI, now with LIVE data
          return Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CURRENT BALANCE', // Changed text
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF2D3E4E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Rs.${balance.toStringAsFixed(2)}', // <-- LIVE BALANCE
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Icon(Icons.account_balance_wallet,
                      size: 80, color: Color(0xFF4ECDC4)),
                  SizedBox(height: 20),
                  Text(
                    'Live Wallet Balance', // Changed text
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3E4E),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bus: $busNumber',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to a real transaction history screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Transaction history coming soon'),
                            backgroundColor: Color(0xFF4ECDC4),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4ECDC4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'VIEW TRANSACTIONS',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
class ConductorWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    final String busNumber = args['busNumber'] ?? 'BUS001';
    final double balance = args['balance'] ?? 0.0;

    return Scaffold(
      backgroundColor: Color(0xFF4ECDC4),
      appBar: AppBar(
        backgroundColor: Color(0xFF4ECDC4),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CONDUCTOR WALLET',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'BALANCE FOR THIS DAY',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0xFF2D3E4E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Rs.${balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Icon(Icons.account_balance_wallet,
                  size: 80, color: Color(0xFF4ECDC4)),
              SizedBox(height: 20),
              Text(
                'Current Wallet Balance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3E4E),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Bus: $busNumber',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Transaction history coming soon'),
                        backgroundColor: Color(0xFF4ECDC4),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4ECDC4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'VIEW TRANSACTIONS',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

// ============== OWNER SCREENS ==============

class OwnerSigninScreen extends StatefulWidget {
  @override
  _OwnerSigninScreenState createState() => _OwnerSigninScreenState();
}

class _OwnerSigninScreenState extends State<OwnerSigninScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4DA1A9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_filled),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/role_selection'),
        ),
        centerTitle: true,
        title: const Text("Owner Registration"),
        actions: const [Icon(Icons.menu)],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle_rounded, size: 100),
              SizedBox(height: 20),
              Container(
                height: 500,
                width: 311,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFF92BCC0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFF2E5077),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                          "E-mail address", "abc@gmail.com", _emailController),
                      const SizedBox(height: 20),
                      _buildInputField(
                          "Username", "Owner2025", _usernameController),
                      const SizedBox(height: 20),
                      _buildInputField(
                          "Password", "xxxxxxx", _passwordController,
                          obscure: true),
                      const SizedBox(height: 35),
                      Center(
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() => _isLoading = true);
                                    try {
                                      final user = await FirebaseService.signUp(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      );
                                      if (user != null) {
                                        await FirebaseService.createData(
                                          'owners',
                                          user.uid,
                                          {
                                            'email': _emailController.text.trim(),
                                            'username':
                                                _usernameController.text.trim(),
                                            'role': 'owner',
                                            'balance': 0.0,
                                            'createdAt':
                                                DateTime.now().toIso8601String(),
                                          },
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Owner Registration Successful!')),
                                        );
                                        Navigator.pushNamed(
                                            context, '/owner_login');
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Registration failed: ${e.toString()}')),
                                      );
                                    } finally {
                                      setState(() => _isLoading = false);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2E5077),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)),
                                  ),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ),
                      ),
                      const SizedBox(height: 16),
                      //login button
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/owner_login');
                          },
                          child: const Text(
                            "Already have an account? Login",
                            style: TextStyle(
                              color: Color(0xFF2E5077),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }

  Widget _buildInputField(
      String label, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF2E5077), fontSize: 18)),
        const SizedBox(height: 5),
        Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintStyle:
                  const TextStyle(color: Color(0xFF3B3636), fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

/*class OwnerSigninScreen extends StatefulWidget {
  @override
  _OwnerSigninScreenState createState() => _OwnerSigninScreenState();
}

class _OwnerSigninScreenState extends State<OwnerSigninScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home_filled),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/role_selection'),
        ),
        title: Text("Owner Registration"),
        actions: [Icon(Icons.menu)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle_rounded, size: 100),
            Container(
              height: 421,
              width: 311,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFF92BCC0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: Color(0xFF2E5077), fontSize: 30)),
                    ),
                    SizedBox(height: 20),
                    _buildInputField(
                        "e-mail address", "abc@gmail.com", _emailController),
                    SizedBox(height: 20),
                    _buildInputField(
                        "Username", "Owner2025", _usernameController),
                    SizedBox(height: 20),
                    _buildInputField(
                        "Password", "xxxxxxxxx", _passwordController,
                        obscure: true),
                    SizedBox(height: 20),
                    Center(
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                setState(() => _isLoading = true);
                                try {
                                  final user = await FirebaseService.signUp(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                  if (user != null) {
                                    await FirebaseService.createData(
                                      'owners',
                                      user.uid,
                                      {
                                        'email': _emailController.text.trim(),
                                        'username':
                                            _usernameController.text.trim(),
                                        'role': 'owner',
                                        'balance': 0.0,
                                        'createdAt':
                                            DateTime.now().toIso8601String(),
                                      },
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Owner Registration Successful!')),
                                    );
                                    Navigator.pushNamed(
                                        context, '/owner_login');
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Registration failed: ${e.toString()}')),
                                  );
                                } finally {
                                  setState(() => _isLoading = false);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF2E5077)),
                              child: Text("Sign Up",
                                  style: TextStyle(color: Colors.white)),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color(0xFF2E5077), fontSize: 18)),
        SizedBox(height: 5),
        Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintStyle: TextStyle(color: Color(0xFF3B3636), fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
*/
class OwnerLoginScreen extends StatefulWidget {
  @override
  _OwnerLoginScreenState createState() => _OwnerLoginScreenState();
}

class _OwnerLoginScreenState extends State<OwnerLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home_filled),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/role_selection'),
        ),
        centerTitle: true,
        title: Text("Owner Login"),
        actions: [Icon(Icons.menu)],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle_rounded, size: 100),
              SizedBox(height: 20),
              Container(
                height: 400,
                width: 311,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF92BCC0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text("Log in",
                            style: TextStyle(
                                color: Color(0xFF2E5077), fontSize: 30)),
                      ),
                      SizedBox(height: 20),
                      _buildInputField(
                          "Username", "Owner2025", _usernameController),
                      SizedBox(height: 20),
                      _buildInputField(
                          "Password", "xxxxxx", _passwordController,
                          obscure: true),
                      SizedBox(height: 40),
                      Center(
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : SizedBox(
                              height: 40,
                              width: 130,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() => _isLoading = true);
                                    try {
                                      final owners =
                                          await FirebaseService.getAll('owners');
                                      QueryDocumentSnapshot? ownerDoc;
                                      for (var doc in owners) {
                                        if (doc['username'] ==
                                            _usernameController.text.trim()) {
                                          ownerDoc = doc;
                                          break;
                                        }
                                      }
                                      if (ownerDoc == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('Owner not found')),
                                        );
                                        return;
                                      }
                                      final email = ownerDoc['email'];
                                      final user = await FirebaseService.signIn(
                                        email,
                                        _passwordController.text.trim(),
                                      );
                                      if (user != null) {
                                        Navigator.pushReplacementNamed(
                                            context, '/owner_dashboard');
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Login failed: ${e.toString()}')),
                                      );
                                    } finally {
                                      setState(() => _isLoading = false);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2E5077)),
                                  child: Text("Login",
                                      style: TextStyle(color: Colors.white)),
                                ),
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
    );
  }

  Widget _buildInputField(
      String label, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color(0xFF2E5077), fontSize: 20)),
        SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintStyle: TextStyle(color: Color(0xFF3B3636), fontSize: 17),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

//owner dashboard screen

class OwnerDashboardScreen extends StatelessWidget {
  Future<Map<String, dynamic>> _loadOwnerData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return {'balance': 0.0, 'transactions': []};
      final doc = await FirebaseService.readData('owners', user.uid);
      final odata = doc.data() as Map<String, dynamic>? ?? {};
      final balance = (odata['balance'] ?? 0).toDouble();

      final allTx = await FirebaseService.getAll('transactions');
      final txs = allTx
          .where((d) => d['to_owner'] == user.uid)
          .map((d) => d.data())
          .toList();
      return {'balance': balance, 'transactions': txs};
    } catch (e) {
      return {'balance': 0.0, 'transactions': []};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadOwnerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.home_filled),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/role_selection'),
              ),
              title: Text(
                "Owner's Wallet",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
              actions: [Icon(Icons.menu)],
              backgroundColor: Color(0xFF4DA1A9),
            ),
            backgroundColor: Color(0xFF4DA1A9),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final data = snapshot.data ?? {};
        final balance = data['balance'] ?? 0.0;
        final transactions = (data['transactions'] ?? []) as List<dynamic>;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/role_selection'),
            ),
            title: Text(
              "Owner's Wallet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            actions: [Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.menu),
            )],
            backgroundColor: Color(0xFF4DA1A9),
          ),
          backgroundColor: Color(0xFF4DA1A9),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Color.fromARGB(255, 188, 207, 229),
                      ),
                      child: Icon(Icons.person, size: 60, color: Colors.black),
                    ),
                    Text(
                      "Owner Username",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Wallet",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 348,
                      height: 248,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF2E5077),
                      ),
                      child: Center(
                        child: Container(
                          height: 116,
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 206, 210, 215),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Balance",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "LKR ${(balance as num).toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 45,
                      width: 168,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF2E5077),
                      ),
                      child: SizedBox(
                        height: 48,
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Accunt added successfully!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2E5077),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          child: Text(
                            "Add bus +",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 220,
                      width: 340,
                      decoration: BoxDecoration(
                          color: Color(0xFF4DA1A9),
                          borderRadius: BorderRadius.circular(12)),
                      child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final t = transactions[index] as Map<String, dynamic>;
                          return ListTile(
                            title: Text('Rs.${(t['amount'] ?? 0).toString()}'),
                            subtitle: Text(t['type'] ?? ''),
                          );
                        },
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
  }
}

// ============== MONEY AGENT SCREENS ==============
class MoneyAgentRegisterScreen extends StatefulWidget {
  @override
  _MoneyAgentRegisterScreenState createState() =>
      _MoneyAgentRegisterScreenState();
}

class _MoneyAgentRegisterScreenState extends State<MoneyAgentRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _serviceLocationController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, '/role_selection'),
                  ),
                  Spacer(),
                  // Icon(Icons.home, color: Colors.white, size: 24),
                  Spacer(),
                  Icon(Icons.menu, color: Colors.white, size: 24),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.account_balance,
                        color: Color(0xFF4DA1A9), size: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'MONEY AGENT REGISTER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        _buildTextField(
                            'Full Name', _fullNameController, Icons.person),
                        _buildTextField('Service Location',
                            _serviceLocationController, Icons.location_on),
                        _buildTextField(
                            'Mobile', _mobileController, Icons.phone),
                        _buildTextField(
                            'E-mail', _emailController, Icons.email),
                        _buildTextField('Username', _userNameController,
                            Icons.account_circle),
                        _buildTextField(
                            'Password', _passwordController, Icons.lock,
                            obscure: true),
                        SizedBox(height: 30),
                        Container(
                          width: 140,
                          child: _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => _isLoading = true);
                                      try {
                                        final user =
                                            await FirebaseService.signUp(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        );
                                        if (user != null) {
                                          await FirebaseService.createData(
                                            'agents',
                                            user.uid,
                                            {
                                              'fullName': _fullNameController
                                                  .text
                                                  .trim(),
                                              'serviceLocation':
                                                  _serviceLocationController
                                                      .text
                                                      .trim(),
                                              'mobile':
                                                  _mobileController.text.trim(),
                                              'email':
                                                  _emailController.text.trim(),
                                              'username': _userNameController
                                                  .text
                                                  .trim(),
                                              'role': 'agent',
                                              'balance': 10000.0,
                                              'createdAt': DateTime.now()
                                                  .toIso8601String(),
                                            },
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Money Agent registration successful!'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          Navigator.pushReplacementNamed(
                                              context, '/agent_login');
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Registration failed: ${e.toString()}')),
                                        );
                                      } finally {
                                        setState(() => _isLoading = false);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF2E5077),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),
                        Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/agent_login');
                              },
                              child: const Text(
                                "Already have an account? Login",
                                style: TextStyle(
                                  color: Color(0xFF2E5077),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF4DA1A9)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF4DA1A9).withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF4DA1A9), width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _serviceLocationController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class MoneyAgentLoginScreen extends StatefulWidget {
  @override
  _MoneyAgentLoginScreenState createState() => _MoneyAgentLoginScreenState();
}

class _MoneyAgentLoginScreenState extends State<MoneyAgentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, '/role_selection'),
                  ),
                 // Spacer(),
                  //Icon(Icons.home, color: Colors.white, size: 24),
                  Spacer(),
                  Icon(Icons.menu, color: Colors.white, size: 24),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.account_balance,
                        color: Color(0xFF4DA1A9), size: 40),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Money Agent Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField('Agent Username', _userNameController,
                              Icons.account_circle),
                          SizedBox(height: 20),
                          _buildTextField(
                              'Password', _passwordController, Icons.lock,
                              obscure: true),
                          SizedBox(height: 40),
                          Container(
                            width: 140,
                            child: _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => _isLoading = true);
                                        try {
                                          final agents =
                                              await FirebaseService.getAll(
                                                  'agents');
                                          QueryDocumentSnapshot? agentDoc;
                                          for (var doc in agents) {
                                            if (doc['username'] ==
                                                _userNameController.text
                                                    .trim()) {
                                              agentDoc = doc;
                                              break;
                                            }
                                          }
                                          if (agentDoc == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text('Agent not found')),
                                            );
                                            return;
                                          }
                                          final email = agentDoc['email'];
                                          final user =
                                              await FirebaseService.signIn(
                                            email,
                                            _passwordController.text.trim(),
                                          );
                                          if (user != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Money Agent login successful!'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            Navigator.pushReplacementNamed(
                                                context, '/agent_dashboard');
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Login failed: ${e.toString()}')),
                                          );
                                        } finally {
                                          setState(() => _isLoading = false);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2E5077),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool obscure = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF4DA1A9)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF4DA1A9).withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF4DA1A9), width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class MoneyAgentDashboardScreen extends StatelessWidget {
  Widget _buildDetailField(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Color(0xFF4DA1A9).withOpacity(0.3)),
            ),
            child: Text(
              value,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 80,
              color: Color(0xFF4DA1A9),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  IconButton(
                    icon: Icon(Icons.home, color: Colors.white, size: 24),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, '/role_selection'),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Transaction history coming soon')),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Icon(Icons.history,
                              color: Colors.white.withOpacity(0.8), size: 20),
                          SizedBox(height: 5),
                          Text(
                            'Transaction\nHistory',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, '/role_selection'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Icon(Icons.logout,
                              color: Colors.white.withOpacity(0.8), size: 20),
                          SizedBox(height: 5),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(Icons.menu, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.account_balance,
                              color: Color(0xFF4DA1A9), size: 30),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Money Agent Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          _buildDetailField('Agent Name', 'Sarah Johnson'),
                          _buildDetailField('Agent ID', 'MAGENT001234'),
                          _buildDetailField('User Name', 'sarahagent'),
                          _buildDetailField('Service Location',
                              '456 Financial District, Colombo'),
                          _buildDetailField('E-mail', 'sarah.agent@email.com'),
                          Spacer(),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, '/agent_transfer'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4DA1A9),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                'MONEY TRANSFER',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'CEYLON',
                            style: TextStyle(
                              color: Color(0xFF4DA1A9),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoneyAgentTransferScreen extends StatefulWidget {
  @override
  _MoneyAgentTransferScreenState createState() =>
      _MoneyAgentTransferScreenState();
}

class _MoneyAgentTransferScreenState extends State<MoneyAgentTransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _walletCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  Icon(Icons.home, color: Colors.white, size: 24),
                  Spacer(),
                  Icon(Icons.menu, color: Colors.white, size: 24),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.attach_money,
                        color: Color(0xFF4DA1A9), size: 40),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Money Transfer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField('Transfer Amount', _amountController,
                              Icons.attach_money),
                          SizedBox(height: 20),
                          _buildTextField(
                              'Customer Wallet Code',
                              _walletCodeController,
                              Icons.account_balance_wallet),
                          SizedBox(height: 40),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushNamed(
                                    context,
                                    '/agent_confirm',
                                    arguments: {
                                      'amount': _amountController.text,
                                      'walletCode': _walletCodeController.text,
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4DA1A9),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                'PROCESS TRANSFER',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: label.contains('Amount')
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF4DA1A9)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF4DA1A9).withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color(0xFF4DA1A9), width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${label.toLowerCase()}';
          }
          if (label.contains('Amount')) {
            double? amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Please enter a valid amount';
            }
          } else if (label.contains('Wallet')) {
            if (value.length < 6) {
              return 'Wallet code must be at least 6 characters';
            }
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _walletCodeController.dispose();
    super.dispose();
  }
}

class MoneyAgentConfirmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String amount = args?['amount'] ?? '';
    final String walletCode = args?['walletCode'] ?? '';

    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  Icon(Icons.home, color: Colors.white, size: 24),
                  Spacer(),
                  Icon(Icons.menu, color: Colors.white, size: 24),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CONFIRM MONEY TRANSFER',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Transfer Amount:',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]),
                              ),
                              Text(
                                'Rs.$amount',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'To Customer:',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]),
                              ),
                              Text(
                                walletCode,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final user = FirebaseAuth.instance.currentUser;
                                final amt = double.tryParse(amount) ?? 0.0;
                                final tx = {
                                  'type': 'agent_transfer',
                                  'amount': amt,
                                  'from': user?.uid ?? 'agent_unknown',
                                  'to_wallet': walletCode,
                                  'timestamp': DateTime.now().toIso8601String(),
                                };
                                await FirebaseService.createData(
                                    'transactions',
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(),
                                    tx);

                                // deduct from agent balance stored in 'agents_wallets'
                                final agentDoc = await FirebaseService.readData(
                                    'agents_wallets', user?.uid ?? 'unknown');
                                final aData =
                                    agentDoc.data() as Map<String, dynamic>? ??
                                        {};
                                final aBal = (aData['balance'] ?? 0).toDouble();
                                await FirebaseService.createData(
                                    'agents_wallets',
                                    user?.uid ?? 'unknown',
                                    {'balance': aBal - amt});

                                // credit customer's wallet (mock)
                                final custDoc = await FirebaseService.readData(
                                    'customer_wallets', walletCode);
                                final cData =
                                    custDoc.data() as Map<String, dynamic>? ??
                                        {};
                                final cBal = (cData['balance'] ?? 0).toDouble();
                                await FirebaseService.createData(
                                    'customer_wallets',
                                    walletCode,
                                    {'balance': cBal + amt});

                                Navigator.pushNamed(context, '/agent_success');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Transfer failed: ${e.toString()}')));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4DA1A9),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              'CONFIRM',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[600],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoneyAgentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4DA1A9),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.home, color: Colors.white, size: 24),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, '/role_selection'),
                    ),
                    Spacer(),
                    Icon(Icons.menu, color: Colors.white, size: 24),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 60),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Money Transfer',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Successful',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/agent_dashboard',
                            (route) => false,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
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
    );
  }
}
