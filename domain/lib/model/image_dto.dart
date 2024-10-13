class ImageDto {
  final String collection;
  final String datetime;
  final String displaySiteName;
  final String docUrl;
  final int height;
  final String imageUrl;
  final String thumbnailUrl;
  final int width;
  final bool isFavorite;

  ImageDto({
    required this.collection,
    required this.datetime,
    required this.displaySiteName,
    required this.docUrl,
    required this.height,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.width,
    required this.isFavorite,
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
      isFavorite: false,
    );
  }

  ImageDto copyWith({
    String? collection,
    String? datetime,
    String? displaySiteName,
    String? docUrl,
    int? height,
    String? imageUrl,
    String? thumbnailUrl,
    int? width,
    bool? isFavorite = false,
  }) =>
      ImageDto(
        collection: collection ?? this.collection,
        datetime: datetime ?? this.datetime,
        displaySiteName: displaySiteName ?? this.displaySiteName,
        docUrl: docUrl ?? this.docUrl,
        height: height ?? this.height,
        imageUrl: imageUrl ?? this.imageUrl,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        width: width ?? this.width,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
