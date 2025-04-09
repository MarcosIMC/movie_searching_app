import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileSecreen extends StatefulWidget {
  final User user;

  const ProfileSecreen({super.key, required this.user});

  @override
  State<ProfileSecreen> createState() => _ProfileSecreenState();
}

class _ProfileSecreenState extends State<ProfileSecreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Image.network(''),
          SizedBox(height: 40,),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              labelText: widget.user.name,
              enabled: false
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
                labelText: widget.user.surname,
                enabled: false
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
                labelText: widget.user.email,
                enabled: false
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
                labelText: widget.user.password,
                enabled: false
            ),
          ),
        ],
      ),
    );
  }
}
