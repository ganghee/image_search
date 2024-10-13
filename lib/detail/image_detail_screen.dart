import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search/icon_message_view.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  const ImageDetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: _ImageDetailBodyView(imageUrl: imageUrl),
    );
  }
}

class _ImageDetailBodyView extends StatefulWidget {
  final String imageUrl;

  const _ImageDetailBodyView({required this.imageUrl});

  @override
  State<_ImageDetailBodyView> createState() => _ImageDetailBodyViewState();
}

class _ImageDetailBodyViewState extends State<_ImageDetailBodyView> {
  final TransformationController transformationController =
      TransformationController();
  late TapDownDetails _doubleTapDetails;

  @override
  void dispose() {
    transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: transformationController,
      maxScale: 3,
      child: GestureDetector(
        onDoubleTapDown: (d) => _doubleTapDetails = d,
        onDoubleTap: _changeImageSize,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            widget.imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return iconMessageView(
                icon: Icons.error,
                message: '이미지를 불러오지 못했습니다',
                iconSize: 40,
                textColor: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }

  _changeImageSize() {
    if (transformationController.value != Matrix4.identity()) {
      transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }
}
