import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void login(BuildContext context) async {
    setState(() => isLoading = true);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    String? result = await auth.login(emailController.text, passwordController.text);
    setState(() => isLoading = false);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height: 32),
                TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
                SizedBox(height: 16),
                TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
                SizedBox(height: 32),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(onPressed: () => login(context), child: Text("Login")),
                SizedBox(height: 16),
                TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen())),
                    child: Text("Don't have an account? Register"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}