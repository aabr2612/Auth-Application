import 'package:flutter/material.dart';
import 'user_manager.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserManager userManager = UserManager();
  bool _passwordVisible = false;
  bool isUppercase = false;
  bool isLowercase = false;
  bool isNumber = false;
  bool isSpecialChar = false;
  bool isMinLength = false;

  void _signUp() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username and password cannot be empty!')),
      );
      return;
    }

    if (!isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Password must be 8+ characters, include uppercase, lowercase, number, and special character!')),
      );
      return;
    }

    if (userManager.userExists(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username already taken!')),
      );
      return;
    }

    userManager.addUser(username, password);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign Up Successful!')),
    );

    usernameController.clear();
    passwordController.clear();

    Navigator.pop(context);
  }

  bool isValidPassword(String password) {
    setState(() {
      isUppercase = password.contains(RegExp(r'[A-Z]'));
      isLowercase = password.contains(RegExp(r'[a-z]'));
      isNumber = password.contains(RegExp(r'\d'));
      isSpecialChar = password.contains(RegExp(r'[@$!%*?&]'));
      isMinLength = password.length >= 8;
    });

    return isUppercase &&
        isLowercase &&
        isNumber &&
        isSpecialChar &&
        isMinLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create an Account',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.red),
                      filled: true,
                      fillColor: Colors.red.shade50,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    onChanged: (password) {
                      isValidPassword(password);
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter a strong password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.red),
                      filled: true,
                      fillColor: Colors.red.shade50,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMinLength == false)
                        _buildPasswordValidationText(
                            'Min 8 characters', isMinLength),
                      if (isUppercase == false)
                        _buildPasswordValidationText(
                            'Uppercase letter', isUppercase),
                      if (isLowercase == false)
                        _buildPasswordValidationText(
                            'Lowercase letter', isLowercase),
                      if (isNumber == false)
                        _buildPasswordValidationText('Number', isNumber),
                      if (isSpecialChar == false)
                        _buildPasswordValidationText(
                            'Special character', isSpecialChar),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Have an account? Sign in now!",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          decoration: TextDecoration.underline),
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

  Widget _buildPasswordValidationText(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
