import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '/model/photo.dart';
import '/resources/string_resources.dart';
import '/resources/urls.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

import '../../constants.dart';

class ViewPhotoScreen extends StatefulWidget {
  final Photo photo;
  const ViewPhotoScreen({Key? key, required this.photo}) : super(key: key);

  @override
  _ViewPhotoScreenState createState() => _ViewPhotoScreenState();
}

class _ViewPhotoScreenState extends State<ViewPhotoScreen> {
  Future<void> _setwallpaper(location) async {
    var file = await DefaultCacheManager().getSingleFile(Urls.baseUrl +
        "/id/${widget.photo.id}/" +
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Stack(
        children: [
          InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: Urls.baseUrl +
                  "/id/${widget.photo.id}/" +
                  StringResources.fullViewPhotoResolution,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: double.infinity,
              // width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: InkWell(
              onTap: () {
                _setwallpaper(WallpaperManagerFlutter.HOME_SCREEN);
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
