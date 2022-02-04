import 'package:flutter/foundation.dart';
import '/model/photo.dart';

class PhotoController extends ChangeNotifier {
  bool _isLoading = true;
  int _currentPage = 0;
  List<Photo> _photoList = [];
  bool _shouldRefresh = true;
  bool _isCountTwo = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  int get currentPage => _currentPage;

  bool get isCountTow => _isCountTwo;

   setIsCountTwo(val) {
    _isCountTwo = val;
    notifyListeners();
  }

  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Photo> get postsList => _photoList;

  setPhotoList(List<Photo> list, {bool notify = true}) {
    _photoList = list;
    if (notify) notifyListeners();
  }

  mergePhotoList(List<Photo> list, {bool notify = true}) {
    _photoList.addAll(list);
    if (notify) notifyListeners();
  }

  Photo getPhotoByIndex(int index) => _photoList[index];

  int get photoListLength => _photoList.length;
}
