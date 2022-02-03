import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/model/photo.dart';
import 'package:photo_gallery/resources/string_resources.dart';
import 'package:photo_gallery/resources/urls.dart';

import '../../constants.dart';

class ViewPhotoScreen extends StatefulWidget {
  final Photo photo;
  const ViewPhotoScreen({Key? key, required this.photo}) : super(key: key);

  @override
  _ViewPhotoScreenState createState() => _ViewPhotoScreenState();
}

class _ViewPhotoScreenState extends State<ViewPhotoScreen> {
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
                  StringResources.photoResolution,
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
            child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
