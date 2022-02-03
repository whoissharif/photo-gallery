import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/model/photo.dart';
import 'package:photo_gallery/resources/string_resources.dart';
import '../../constants.dart';
import '/resources/urls.dart';

class PhotoGridItem extends StatelessWidget {
  const PhotoGridItem({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: Urls.baseUrl +
                  "/id/${photo.id}/" +
                  StringResources.photoResolution,
              placeholder: (context, _) =>
                  Image.asset(Urls.placeholderImageUrl),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              photo.author.toString(),
              style: kPhotoGridTileTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
