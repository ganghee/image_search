import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/search_bloc.dart';
import 'package:search/image_list/image_list_info.dart';
import 'package:search/model/image_vo.dart';

class SearchImageListInfoImpl extends ImageListInfo {
  @override
  String emptyMessage() => '검색 결과가 없습니다';

  @override
  late List<ImageVo> imageItems;

  @override
  late FocusNode? focusNode;

  @override
  double get topPadding => 70;

  @override
  getPaging({required BuildContext context}) {
    context.read<SearchBloc>().add(
          SearchImagesEvent(isRefresh: false),
        );
  }

  @override
  setImageItems({required List<ImageVo> images}) {
    imageItems = images;
  }

  @override
  setFocusNode({required FocusNode focusNode}) {
    this.focusNode = focusNode;
  }
}

class FavoriteImageListInfoImpl extends ImageListInfo {
  @override
  String emptyMessage() => '즐겨찾기한 이미지가 없습니다';

  @override
  late List<ImageVo> imageItems;

  @override
  double get topPadding => 0;

  @override
  setImageItems({required List<ImageVo> images}) {
    imageItems = images;
  }
}
