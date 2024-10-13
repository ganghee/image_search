import 'package:domain/model/image_dto.dart';

class ImageVo {
  final String imageId;
  final String imageUrl;
  final String label;
  final bool isFavorite;
  final int height;
  final int width;

  ImageVo({
    required this.imageId,
    required this.imageUrl,
    required this.label,
    required this.isFavorite,
    required this.height,
    required this.width,
  });

  ImageVo copyWith({
    String? imageId,
    String? imageUrl,
    String? label,
    bool? isFavorite,
    int? height,
    int? width,
  }) =>
      ImageVo(
        imageId: imageId ?? this.imageId,
        imageUrl: imageUrl ?? this.imageUrl,
        label: label ?? this.label,
        isFavorite: isFavorite ?? this.isFavorite,
        height: height ?? this.height,
        width: width ?? this.width,
      );

  ImageDto toDto() => ImageDto(
        collection: '',
        datetime: '',
        displaySiteName: label,
        docUrl: '',
        height: height,
        imageUrl: imageUrl,
        thumbnailUrl: '',
        width: width,
        isFavorite: isFavorite,
      );
}

extension ImageDtoExtension on ImageDto {
  ImageVo mapper() => ImageVo(
        imageId: imageUrl,
        imageUrl: imageUrl,
        label: displaySiteName,
        isFavorite: isFavorite,
        height: height,
        width: width,
      );
}

extension ImageVoItemsExtension on List<ImageDto> {
  List<ImageVo> mapper() => map((imageVo) => imageVo.mapper()).toList();
}
