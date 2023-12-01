import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:myfpro/presentation/widgets/toast.dart';

class DownloadIcon extends StatefulWidget {
  final String imageUrl;
  const DownloadIcon({
    super.key,
    required this.imageUrl,
  });

  @override
  State<DownloadIcon> createState() => _DownloadIconState();
}

class _DownloadIconState extends State<DownloadIcon> {
  int currentIndex = 0;

  Future<bool> _downloadImage() async {
    try {
      final status = await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        if (context.mounted) {
          AppToastMessenger.showErrorMessage(
            context,
            message: "Please provide storage permission",
          );
        }
        return false;
      }
      var response = await get(Uri.parse(widget.imageUrl));

      final result = await ImageGallerySaver.saveImage(response.bodyBytes);
      print(result);
      if (result is Map) {
        final success = result["isSuccess"] as bool;
        final filePath = result["filePath"] as String;
        if (success) {
          if (context.mounted) {
            AppToastMessenger.showSuccessMessage(
              context,
              "Image downloaded successfully in gallery $filePath",
            );
          }
          return true;
        }
      }
      if (context.mounted) {
        AppToastMessenger.showErrorMessage(
          context,
          message: "Something went wrong",
        );
      }
      return false;
    } catch (e) {
      AppToastMessenger.showErrorMessage(
        context,
        message: "$e",
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final status = await _downloadImage();
        if (status) {
          currentIndex = currentIndex == 0 ? 1 : 0;
          setState(() {});
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black.withOpacity(0.4),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: child.key == const ValueKey('icon1')
                ? Tween<double>(begin: 1, end: 0).animate(anim)
                : Tween<double>(begin: 0.75, end: 1).animate(anim),
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: currentIndex == 0
              ? const Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  key: ValueKey('icon1'),
                  size: 18,
                )
              : const Icon(
                  Icons.download_done_rounded,
                  key: ValueKey('icon2'),
                  size: 18,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
