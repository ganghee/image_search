import 'package:data/mapper/data_to_domain_mapper.dart';
import 'package:domain/model/image_dto.dart';

class ImageResponse extends DataToDomainMapper<ImageDto> {
  final String collection;
  final String datetime;
  final String displaySiteName;
  final String docUrl;
  final int height;
  final String imageUrl;
  final String thumbnailUrl;
  final int width;

  ImageResponse({
    required this.collection,
    required this.datetime,
    required this.displaySiteName,
    required this.docUrl,
    required this.height,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.width,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
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

  @override
  ImageDto mapper() => ImageDto(
        collection: collection,
        datetime: datetime,
        displaySiteName: displaySiteName,
        docUrl: docUrl,
        height: height,
        imageUrl: imageUrl,
        thumbnailUrl: thumbnailUrl,
        width: width,
      );
}
