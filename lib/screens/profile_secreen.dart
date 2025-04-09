import 'package:flutter/material.dart';
import 'package:movie_searching/providers/user_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
        actions: [
          IconButton(onPressed: () {
            provider.logout();
            Navigator.pop(context);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'), maxRadius: 100,),
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
          ],
        ),
      ),
    );
  }
}
