import 'package:flutter/material.dart';

class ProfileImageCard extends StatelessWidget {
  final String? image;
  final double radius;
  const ProfileImageCard({super.key, required this.image, this.radius = 38.5});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[300],
      child: ClipOval(
        child: Image.network(
          image ?? 'https://avatars.pfptown.com/231/thumb-512-alien-6316.webp',
          fit: BoxFit.cover,
          width: 77,
          height: 77,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/default-profile.png',
              fit: BoxFit.cover,
              width: 77,
              height: 77,
            );
          },
        ),
      ),
    );
  }
}
