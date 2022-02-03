import 'package:flutter/material.dart';

class NoPhotoFound extends StatelessWidget {
  const NoPhotoFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('No Photos'),
      );
  }
}