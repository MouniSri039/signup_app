
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoadingTip = false;
  bool _simulateTipError = false;

  String? _signupTip;
  String? _tipError;

  // Local preset content only. No AI service or network request.
  final Map<String, List<String>> _presetTips = {
    'password_help': [
      'Use a long, unique password that is difficult to guess.',
      'Avoid reusing passwords across different accounts.',
      'Consider using a password manager to create strong passwords.',
    ],
  };

  Future<void> _getSignupTip() async {
    setState(() {
      _isLoadingTip = true;
      _signupTip = null;
      _tipError = null;
    });

    // Simulate a short local loading state.
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    final tips = _simulateTipError
        ? null
        : _presetTips['password_help'];

    setState(() {
      _isLoadingTip = false;

      if (tips == null || tips.isEmpty) {
        _tipError = 'Preset tip unavailable. Please retry.';
      } else {
        _signupTip = tips.first;
      }
    });
  }

  
void _toggleTipErrorTest() {
  final enableError = !_simulateTipError;

  setState(() {
    _simulateTipError = enableError;
    _signupTip = null;

    if (enableError) {
      _tipError = null;
    }
  });

  // Enabling the test immediately runs the tip request.
  if (enableError) {
    _getSignupTip();
  }
}


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome, ${_nameController.text.trim()}! '
            'Your demo signup was successful.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Account'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_add_alt_1,
                  size: 70,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Join Our Community!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 28),

                // Full name
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Task C: Confirm password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Task A: Local Signup Coach
                const Text(
                  'Signup Coach',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Preset demo tips — not live AI output.',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 12),

                OutlinedButton.icon(
                  onPressed: _isLoadingTip ? null : _getSignupTip,
                  icon: const Icon(Icons.lightbulb_outline),
                  label: const Text('Get a signup tip'),
                ),
                const SizedBox(height: 8),

                // Repeatable error test control
                TextButton(
                  onPressed: _toggleTipErrorTest,
                  child: Text(
                    _simulateTipError
                        ? 'Disable tip error test'
                        : 'Test local tip error',
                  ),
                ),

                if (_isLoadingTip)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text('Loading preset tip...'),
                      ],
                    ),
                  ),

                if (_signupTip != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.tips_and_updates,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Text(_signupTip!)),
                        ],
                      ),
                    ),
                  ),

                if (_tipError != null)
                  Card(
                    color: Theme.of(context)
                        .colorScheme
                        .errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_tipError!),
                          TextButton(
                            onPressed: _getSignupTip,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Signup only succeeds when every validator passes.
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Demo only: no account is created and no personal '
                  'form information is sent to the Signup Coach.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
