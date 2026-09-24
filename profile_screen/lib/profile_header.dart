import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String university;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/me.jpg', width: 100, height: 100),
        Text(name, style: const TextStyle(fontFamily: 'MyFont', fontSize: 20)),
        Text(university, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
