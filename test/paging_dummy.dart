import 'package:domain/model/image_dto.dart';
import 'package:domain/model/meta_dto.dart';
import 'package:domain/model/paging_dto.dart';
import 'package:search/model/image_vo.dart';
import 'package:search/model/paging_vo.dart';

ImageDto imageDtoDummy = ImageDto(
  collection: 'blog',
  thumbnailUrl: 'https://www.example.com/image1',
  imageUrl: 'https://www.example.com/image1',
  width: 100,
  height: 100,
  displaySiteName: '티스토리',
  datetime: '2021-08-01T00:00:00.000+09:00',
  docUrl: 'https://www.example.com',
  isFavorite: false,
);

ImageVo imageVoDummy = imageDtoDummy.mapper();

PagingVo<ImageVo> imagePagingVoDummy = PagingVo(
  page: 1,
  totalCount: 3,
  hasNextPage: false,
  isPageLoading: false,
  items: [
    imageVoDummy,
    imageVoDummy,
    imageVoDummy,
  ],
);

PagingDto<ImageDto> imagePagingDtoDummy = PagingDto(
  metaDto: MetaDto(
    pageableCount: 3,
    isEnd: true,
    totalCount: 3,
  ),
  documents: [
    imageDtoDummy,
    imageDtoDummy,
    imageDtoDummy,
  ],
);
