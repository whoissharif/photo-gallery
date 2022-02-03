import 'dart:convert';

Photo photoFromJson(String str) => Photo.fromJson(json.decode(str));

String photoToJson(Photo data) => json.encode(data.toJson());

class Photo {
  Photo({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] == null ? null : json["id"],
        author: json["author"] == null ? null : json["author"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        url: json["url"] == null ? null : json["url"],
        downloadUrl: json["download_url"] == null ? null : json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "author": author == null ? null : author,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "url": url == null ? null : url,
        "download_url": downloadUrl == null ? null : downloadUrl,
      };
}
