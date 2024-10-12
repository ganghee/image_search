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

  factory ImageVo.copyWith({
    String? imageUrl,
    String? label,
    bool? isFavorite,
    int? height,
    int? width,
  }) {
    return ImageVo(
      imageId: imageUrl ?? '',
      imageUrl: imageUrl ?? '',
      label: label ?? '',
      isFavorite: isFavorite ?? false,
      height: height ?? 200,
      width: width ?? 200,
    );
  }
}

extension ImageDtoExtension on ImageDto {
  ImageVo mapper() {
    return ImageVo(
      imageId: imageUrl,
      imageUrl: imageUrl,
      label: displaySiteName,
      isFavorite: false,
      height: height,
      width: width,
    );
  }
}
