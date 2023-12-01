import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key, required this.imageUrl, required this.index});
  final String imageUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Viewer"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: "$imageUrl$index",
          child: FadeInImage.memoryNetwork(
            image: imageUrl,
            placeholder: kTransparentImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
