class ImageDto {
  final String collection;
  final String datetime;
  final String displaySiteName;
  final String docUrl;
  final int height;
  final String imageUrl;
  final String thumbnailUrl;
  final int width;

  ImageDto({
    required this.collection,
    required this.datetime,
    required this.displaySiteName,
    required this.docUrl,
    required this.height,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.width,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) {
    return ImageDto(
      collection: json['collection'],
      datetime: json['datetime'],
      displaySiteName: json['display_sitename'],
      docUrl: json['doc_url'],
      height: json['height'],
      imageUrl: json['image_url'],
      thumbnailUrl: json['thumbnail_url'],
      width: json['width'],
    );
  }
}
