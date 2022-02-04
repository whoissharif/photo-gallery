import 'package:flutter/material.dart';
import '/resources/string_resources.dart';
import '../../constants.dart';

class SetWallpaperButton extends StatelessWidget {
  const SetWallpaperButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Center(
        child: Text(
          StringResources.setAsWallpaperText,
          style: kSetAsWallpaperTextStyle,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
