import 'package:flutter/material.dart';
import 'package:salonguru_shop/core/constants/dimens.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.medium),
      child: Image.network(
        url,
        fit: BoxFit.fitWidth,
        width: 60,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, size: 60, color: Colors.red);
        },
      ),
    );
  }
}
