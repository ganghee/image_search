import 'package:domain/model/image_dto.dart';
import 'package:domain/model/paging_dto.dart';

abstract class SearchRepository {
  Future<PagingDto<ImageDto>> searchImages({
    required String query,
    required int page,
  });
}
