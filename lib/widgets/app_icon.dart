import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.image,
    required this.width,
    required this.height,
  });
  final Image image;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      width: width,
      height: height,
      child: Center(
        child: image,
      ),
    );
  }
}
