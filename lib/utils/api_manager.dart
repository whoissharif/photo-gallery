import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import '/model/http_response.dart';
import '/model/photo.dart';
import '/resources/urls.dart';

class APIManager {
  static Future<HTTPResponse<List<Photo>>> getPhotos(
      {int page = 1, int limit = 20}) async {
    try {
      var response = await http.get(
        Uri.parse(
          Urls.baseUrl + Urls.photoList + '?page=$page&limit=$limit',
        ),
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Photo> photos = [];
        body.forEach((e) {
          Photo photo = Photo.fromJson(e);
          photos.add(photo);
        });
        log(photos[0].toJson().toString());
        return HTTPResponse<List<Photo>>(
          true,
          photos,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<Photo>>(
          false,
          null,
          message:
              'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      return HTTPResponse<List<Photo>>(
        false,
        null,
        message: 'Unable to reach the internet! Please try again in a moment.',
      );
    } on FormatException {
      return HTTPResponse<List<Photo>>(
        false,
        null,
        message:
            'Invalid data received from the server! Please try again in a moment.',
      );
    } catch (e) {
      return HTTPResponse<List<Photo>>(
        false,
        null,
        message: 'Something went wrong! Please try again in a moment!',
      );
    }
  }
}
