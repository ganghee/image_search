import 'package:data/mapper/data_to_domain_mapper.dart';
import 'package:domain/model/image_dto.dart';

class FavoriteImageEntity extends DataToDomainMapper<ImageDto> {
  final String imageId;
  final String imageUrl;
  final String displaySiteName;
  final int height;
  final int width;

  FavoriteImageEntity({
    required this.imageId,
    required this.imageUrl,
    required this.displaySiteName,
    required this.height,
    required this.width,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'imageId': imageId,
        'imageUrl': imageUrl,
        'displaySiteName': displaySiteName,
        'height': height,
        'width': width,
      };

  factory FavoriteImageEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteImageEntity(
      imageId: json['imageId'],
      imageUrl: json['imageUrl'],
      displaySiteName: json['displaySiteName'],
      height: json['height'],
      width: json['width'],
    );
  }

  @override
  ImageDto mapper() => ImageDto(
        collection: '',
        datetime: '',
        displaySiteName: displaySiteName,
        docUrl: '',
        height: height,
        imageUrl: imageUrl,
        thumbnailUrl: '',
        width: width,
        isFavorite: true,
      );
}

extension FavoriteImageDtoExtension on ImageDto {
  FavoriteImageEntity toEntity() => FavoriteImageEntity(
        imageId: imageUrl,
        imageUrl: imageUrl,
        displaySiteName: displaySiteName,
        height: height,
        width: width,
      );
}
