class ImageVo {
  final String imageId;
  final String imageUrl;
  final String label;
  final bool isFavorite;

  ImageVo({
    required this.imageId,
    required this.imageUrl,
    required this.label,
    required this.isFavorite,
  });

  factory ImageVo.copyWith({
    String? imageUrl,
    String? label,
    bool? isFavorite,
  }) {
    return ImageVo(
      imageId: 'image',
      imageUrl: imageUrl ?? '',
      label: label ?? '',
      isFavorite: isFavorite ?? false,
    );
  }
}
