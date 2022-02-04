import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../constants.dart';
import '/model/photo.dart';
import '/resources/string_resources.dart';
import '/resources/urls.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class WallpaperOpitons extends StatelessWidget {
  final BuildContext context;
  final Photo photo;

  const WallpaperOpitons({Key? key, required this.context, required this.photo})
      : super(key: key);

  Future<void> _setwallpaper(location) async {
    var file = await DefaultCacheManager().getSingleFile(Urls.baseUrl +
        "/id/${photo.id}/" +
        StringResources.fullViewPhotoResolution);
    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 5,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          behavior: SnackBarBehavior.floating,
          content: Text(StringResources.wallpaperUpdateSuccessMessage),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 5,
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          behavior: SnackBarBehavior.floating,
          content: Text(StringResources.wallpaperUpdateFailureMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            StringResources.setAsHomescreen,
            style: kWallpaperOptionTextStyle,
          ),
          onTap: () {
            Navigator.pop(context);
            _setwallpaper(WallpaperManagerFlutter.HOME_SCREEN);
          },
        ),
        ListTile(
          title: Text(
            StringResources.setAsLockcreen,
            style: kWallpaperOptionTextStyle,
          ),
          onTap: () {
            Navigator.pop(context);
            _setwallpaper(WallpaperManagerFlutter.LOCK_SCREEN);
          },
        ),
        ListTile(
          title: Text(
            StringResources.setBoth,
            style: kWallpaperOptionTextStyle,
          ),
          onTap: () {
            Navigator.pop(context);
            _setwallpaper(WallpaperManagerFlutter.BOTH_SCREENS);
          },
        ),
      ],
    );
  }
}
