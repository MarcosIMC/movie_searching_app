import 'package:flutter/material.dart';
import 'package:movie_searching/models/user.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/user_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;
  late UserProvider provider;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      //Hacemos alguna acción
      provider.signup(User(_nameController.text, _surnameController.text, id: Uuid().v4(), email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert a name';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert a surname';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert a valid Email';
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
              SizedBox(height: 25,),
              ElevatedButton(onPressed: () {
                _submit();
              }, child: Text('Sign Up'))
            ],
          ),
        ),
      )
    );
  }
}
