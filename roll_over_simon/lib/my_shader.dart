import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart' as widgets;
import 'dart:async';

class MyShader extends StatelessWidget {
  const MyShader({super.key, required this.path, required this.child});

  final String path;
  final Widget child;

  Future<ui.Image> loadUiImage(String imageAssetPath) async {
    widgets.Image widgetsImage = widgets.Image.asset(imageAssetPath);
    Completer<ui.Image> completer = Completer<ui.Image>();
    widgetsImage.image.resolve(const widgets.ImageConfiguration()).addListener(
        widgets.ImageStreamListener((widgets.ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
        future: loadUiImage(path),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ShaderMask(
                  blendMode: BlendMode.modulate,
                  shaderCallback: (bounds) => ImageShader(
                      snapshot.data!,
                      TileMode.clamp,
                      TileMode.clamp,
                      Matrix4.identity().storage),
                  child: child)
              : const SizedBox(
                  height: 1,
                  width: 1,
                );
        });
  }
}
