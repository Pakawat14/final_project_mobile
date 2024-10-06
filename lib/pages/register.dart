import 'package:flutter/material.dart';
// Import your authentication service here
import '../database/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email = '';
  String _passwd = '';
  String _confirmPasswd = '';

  // To show any error messages or feedback to the user
  Future _showAlert(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  // Validate password and confirm password
  bool _validatePasswords() {
    if (_passwd != _confirmPasswd) {
      _showAlert(context, 'Passwords do not match');
      return false;
    }
    if (_passwd.length < 6) {
      _showAlert(context, 'Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  // Register logic
  void _register() async {
    if (_validatePasswords()) {
      await UserAuthentication()
          .registerWithEmailAndPassword(_email, _passwd)
          .then((res) {
        if (res == true) {
          Navigator.of(context).pop(); // Go back to login screen
          _showAlert(context, 'Registration successful');
        } else {
          _showAlert(context, 'Registration failed');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        backgroundColor: Colors.orange, // AppBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.orange.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9), // Semi-transparent background
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0, 4), // Shadow effect
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 12,
                        color: Colors.orangeAccent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                // Email Input
                TextFormField(
                  onChanged: (value) => _email = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.orange.shade700),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.orange.shade300),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Password Input
                TextFormField(
                  obscureText: true,
                  onChanged: (value) => _passwd = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.orange.shade700),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.orange.shade300),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Confirm Password Input
                TextFormField(
                  obscureText: true,
                  onChanged: (value) => _confirmPasswd = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.orange.shade700),
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.orange.shade300),
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(height: 35.0),
                // Register Button
                Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orangeAccent, Colors.orange.shade500],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      onTap: _register,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
