class RedditModel {
  String? kind;
  Data? data;

  RedditModel({this.kind, this.data});

  RedditModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? title;
  int? thumbnailHeight;
  int? thumbnailWidth;
  String? thumbnail;
  String? linkFlairBackgroundColor;
  String? id;
  String? author;
  String? url;
  Media? media;
  bool? isVideo;

  Data(
      {this.title,
      this.thumbnailHeight,
      this.thumbnailWidth,
      this.thumbnail,
      this.linkFlairBackgroundColor,
      this.id,
      this.author,
      this.url,
      this.media,
      this.isVideo});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnailHeight = json['thumbnail_height'];
    thumbnailWidth = json['thumbnail_width'];
    thumbnail = json['thumbnail'];
    linkFlairBackgroundColor = json['link_flair_background_color'];
    id = json['id'];
    author = json['author'];
    url = json['url'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    isVideo = json['is_video'];
  }
}

class Media {
  String? type;
  Oembed? oembed;

  Media({this.type, this.oembed});

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    oembed =
        json['oembed'] != null ? new Oembed.fromJson(json['oembed']) : null;
  }
}

class Oembed {
  String? providerUrl;
  String? version;
  String? title;
  String? type;
  int? thumbnailWidth;
  int? height;
  int? width;
  String? html;
  String? authorName;
  String? providerName;
  String? thumbnailUrl;
  int? thumbnailHeight;
  String? authorUrl;

  Oembed(
      {this.providerUrl,
      this.version,
      this.title,
      this.type,
      this.thumbnailWidth,
      this.height,
      this.width,
      this.html,
      this.authorName,
      this.providerName,
      this.thumbnailUrl,
      this.thumbnailHeight,
      this.authorUrl});

  Oembed.fromJson(Map<String, dynamic> json) {
    providerUrl = json['provider_url'];
    version = json['version'];
    title = json['title'];
    type = json['type'];
    thumbnailWidth = json['thumbnail_width'];
    height = json['height'];
    width = json['width'];
    html = json['html'];
    authorName = json['author_name'];
    providerName = json['provider_name'];
    thumbnailUrl = json['thumbnail_url'];
    thumbnailHeight = json['thumbnail_height'];
    authorUrl = json['author_url'];
  }
}
