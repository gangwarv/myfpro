import 'package:flutter/material.dart';
import 'package:myfpro/presentation/widgets/download.dart';

class StaggeredImageViewer extends StatelessWidget {
  const StaggeredImageViewer({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.blue[600],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: DownloadIcon(
              imageUrl: imageUrl,
            ),
          ),
        ],
      ),
    );
  }
}
