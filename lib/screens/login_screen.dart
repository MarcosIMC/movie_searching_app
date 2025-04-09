import 'package:flutter/material.dart';
import 'package:movie_searching/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      //hacemos alguna acción ya que es válido
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  suffixIcon: Icon(Icons.alternate_email)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert a valid email';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    }, icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off))
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert a valid password';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                _submitForm();
              },
                  child: const Text('Login')
              ),
              TextButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
              }, child: Text('Sign up'))
            ],
          ),
        ),
      ),
    );
  }
}
