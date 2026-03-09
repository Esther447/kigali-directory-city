import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void register(BuildContext context) async {
    setState(() => isLoading = true);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    String? result = await auth.register(emailController.text, passwordController.text, nameController.text);
    setState(() => isLoading = false);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful. Please verify your email.')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
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
                Text("Register", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height: 32),
                TextField(controller: nameController, decoration: InputDecoration(labelText: 'Full Name')),
                SizedBox(height: 16),
                TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
                SizedBox(height: 16),
                TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
                SizedBox(height: 32),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(onPressed: () => register(context), child: Text("Register")),
                SizedBox(height: 16),
                TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
                    child: Text("Already have an account? Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}