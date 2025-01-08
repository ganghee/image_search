import 'package:search/image_list/image_list_info.dart';
import 'package:search/image_list/image_list_info_impl.dart';

enum ImageListType { search, favorite }

class ImageListFactory {
  static ImageListInfo createImageList({
    required ImageListType type,
  }) {
    switch (type) {
      case ImageListType.search:
        return SearchImageListInfoImpl();
      case ImageListType.favorite:
        return FavoriteImageListInfoImpl();
    }
  }
}
