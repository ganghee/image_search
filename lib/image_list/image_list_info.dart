import 'package:flutter/widgets.dart';
import 'package:search/model/image_vo.dart';

abstract class ImageListInfo {
  String emptyMessage();

  List<ImageVo> get imageItems;

  FocusNode? get focusNode => null;

  double get topPadding;

  getPaging({required BuildContext context}) => {};

  setImageItems({required List<ImageVo> images});

  setFocusNode({required FocusNode focusNode}) => {};
}
