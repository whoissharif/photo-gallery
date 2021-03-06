import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import '/views/widgets/fading_four_loader.dart';
import '/views/widgets/set_wallpaper_button.dart';
import '/views/widgets/wallpaper_options.dart';
import 'package:share_plus/share_plus.dart';
import '/model/photo.dart';
import '/resources/string_resources.dart';
import '/resources/urls.dart';

class ViewPhotoScreen extends StatefulWidget {
  final Photo photo;
  const ViewPhotoScreen({Key? key, required this.photo}) : super(key: key);

  @override
  _ViewPhotoScreenState createState() => _ViewPhotoScreenState();
}

class _ViewPhotoScreenState extends State<ViewPhotoScreen> {
  Future<void> _share() async {
    final imageurl = Urls.baseUrl +
        "/id/${widget.photo.id}/" +
        StringResources.fullViewPhotoResolution;
    final uri = Uri.parse(imageurl);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path =
        '${temp.path}/image-${widget.photo.author}-${widget.photo.id}.jpg';
    File(path).writeAsBytesSync(bytes);
    await Share.shareFiles([path], text: 'Image Shared');
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
            onPressed: () {
              _share();
            },
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
                  const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: FadingFourLoader(),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    builder: (c) {
                      return WallpaperOpitons(
                        context: c,
                        photo: widget.photo,
                      );
                    });
              },
              child: const SetWallpaperButton(),
            ),
          ),
        ],
      ),
    );
  }
}
