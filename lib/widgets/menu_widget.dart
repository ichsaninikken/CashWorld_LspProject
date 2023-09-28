import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final ImageProvider<Object> image;

  const MenuItem({super.key, 
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: image,
          height: MediaQuery.sizeOf(context).height /
              6, 
          width: MediaQuery.sizeOf(context).height /
              6, 
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
