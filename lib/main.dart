import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Auth Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class User {
  String username;
  String password;

  User(this.username, this.password);
}

class _MyHomePageState extends State<MyHomePage> {
  final List<User> users = [];
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false; // Track whether the user is logged in

  void _signUp(String username, String password) {
    if (_isValidPassword(password) && _isValidUsername(username)) {
      setState(() {
        users.add(User(username, password));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  bool _signIn(String username, String password) {
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }

  bool _isValidPassword(String password) {
    if (password.length < 8) return false;
    RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  bool _isValidUsername(String username) {
    for (var user in users) {
      if (user.username == username) return false;
    }
    return true;
  }

  void _handleLogin() {
    String username = usernameController.text;
    String password = passwordController.text;
    if (_signIn(username, password)) {
      setState(() {
        isLoggedIn = true; // Set logged-in state to true
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  void _handleLogout() {
    setState(() {
      isLoggedIn = false; // Set logged-out state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isLoggedIn
                    ? Column(
                        children: [
                          const Text(
                            'You are logged in!',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _handleLogout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Logout',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const Text(
                            'Welcome! Please Sign In or Sign Up',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                              ),
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.red),
                              filled: true,
                              fillColor: Colors.red.shade50,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                              ),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.red),
                              filled: true,
                              fillColor: Colors.red.shade50,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 30),
                          // Smaller button
                          ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent, // Corrected
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 12), // Smaller padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Smaller button
                          ElevatedButton(
                            onPressed: () {
                              String username = usernameController.text;
                              String password = passwordController.text;
                              _signUp(username, password);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Corrected
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 12), // Smaller padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
