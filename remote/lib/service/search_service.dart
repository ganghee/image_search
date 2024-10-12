import 'package:data/model/image_response.dart';
import 'package:data/model/paging_response.dart';
import 'package:dio/dio.dart';
import 'package:domain/model/image_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'search_service.g.dart';

@RestApi(baseUrl: 'https://dapi.kakao.com/v2/')
abstract class SearchService {
  factory SearchService(Dio dio) = _SearchService;

  /// 이미지 검색
  @GET('search/image')
  Future<PagingResponse<ImageResponse, ImageDto>> searchImages({
    @Query('query') required String query,
    @Query('page') required int page,
    @Query('size') required int size,
  });
}
