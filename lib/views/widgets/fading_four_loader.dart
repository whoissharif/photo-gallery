import 'package:flutter/material.dart';
import 'package:photo_gallery/constants.dart';
import '/utils/fading_four.dart';

class FadingFourLoader extends StatelessWidget {
  const FadingFourLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadingFour(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: index.isEven ? kLoaderColor1 : kLoaderColor2,
          ),
        );
      },
    );
  }
}
