import 'package:flutter/material.dart';
import 'package:myfpro/presentation/screens/image.dart';
import 'package:myfpro/presentation/widgets/download.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({
    super.key,
    required this.index,
    required this.imageUrl,
    this.onImageDismiss,
    required this.cardWidth,
    required this.cardHeight,
    required this.color,
    required this.bottom,
    required this.left,
    required this.description,
  });
  final int index;
  final String imageUrl;
  final Color color;
  final double cardWidth, cardHeight, bottom, left;
  final VoidCallback? onImageDismiss;
  final String description;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> positionAnimation;
  bool dismissed = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() async {
        if (animationController.isCompleted) {
          if (widget.onImageDismiss != null) {
            widget.onImageDismiss!();
          }
        }
        setState(() {});
      });
    positionAnimation =
        Tween<double>(begin: 0, end: 100).animate(animationController);
    super.initState();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: widget.bottom,
      left: widget.left + positionAnimation.value,
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageScreen(
                    imageUrl: widget.imageUrl,
                    index: widget.index,
                  )));
        },
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            if (details.delta.dx > 40) {
              dismissed = true;
              setState(() {});
              animationController.forward();
            } else {}
          }
        },
        child: AnimatedOpacity(
          opacity: dismissed ? 0 : 1,
          duration: const Duration(milliseconds: 700),
          child: Container(
            width: widget.cardWidth,
            height: widget.cardHeight,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Hero(
                  tag: "${widget.imageUrl}${widget.index}",
                  child: SizedBox(
                    width: widget.cardWidth,
                    height: widget.cardHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.memoryNetwork(
                        image: widget.imageUrl,
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: DownloadIcon(
                    imageUrl: widget.imageUrl,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Text(
                        widget.description,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
