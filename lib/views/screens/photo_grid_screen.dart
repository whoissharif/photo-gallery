import 'package:flutter/material.dart';
import '/resources/string_resources.dart';
import '/views/widgets/no_photo_found.dart';
import '/constants.dart';
import '/controllers/photo_controller.dart';
import '/model/photo.dart';
import '/resources/urls.dart';
import '/utils/api_manager.dart';
import 'package:provider/provider.dart';

class PhotoGridScreen extends StatefulWidget {
  const PhotoGridScreen({Key? key}) : super(key: key);

  @override
  _PhotoGridScreenState createState() => _PhotoGridScreenState();
}

class _PhotoGridScreenState extends State<PhotoGridScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  _showSnackbar(String message) {
    (ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 5,
        margin: const EdgeInsets.all(5),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: kSnackBarTextStyle,
        ),
        backgroundColor: kSnackBarBgColor,
      ),
    ));
  }

  _getPhotos({bool refresh = true}) async {
    var photoProvider = Provider.of<PhotoController>(context, listen: false);
    if (!photoProvider.shouldRefresh) {
      return;
    }
    if (refresh) {
      _showSnackbar(
        StringResources.snackBarLoadingText,
      );
    }

    var photosResponse = await APIManager.getPhotos(
      limit: 20,
      page: photoProvider.currentPage,
    );
    if (photosResponse.isSuccessful) {
      if (photosResponse.data!.isNotEmpty) {
        if (refresh) {
          photoProvider.mergePhotoList(photosResponse.data!, notify: false);
        } else {
          photoProvider.setPhotoList(photosResponse.data!, notify: false);
        }
        photoProvider.setCurrentPage(photoProvider.currentPage + 1);
      } else {
        photoProvider.setShouldRefresh(false);
      }
    } else {
      _showSnackbar(photosResponse.message!);
    }
    photoProvider.setIsLoading(false);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _getPhotos();
        }
      }
    });
    _getPhotos(refresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(StringResources.appName),
      ),
      body: Consumer<PhotoController>(
        builder: (_, provider, __) => provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.photoListLength > 0
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: provider.photoListLength,
                    itemBuilder: (_, index) {
                      Photo photo = provider.getPhotoByIndex(index);
                      return Image.network(
                        Urls.baseUrl + "/id/${photo.id}/1280/720",
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : const NoPhotoFound(),
      ),
    );
  }
}


