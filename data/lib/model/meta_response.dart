import 'package:data/mapper/data_to_domain_mapper.dart';
import 'package:domain/model/meta_dto.dart';

class MetaResponse extends DataToDomainMapper<MetaDto> {
  final int totalCount;
  final int pageableCount;
  final bool isEnd;

  MetaResponse({
    required this.totalCount,
    required this.pageableCount,
    required this.isEnd,
  });

  factory MetaResponse.fromJson(Map<String, dynamic> json) {
    return MetaResponse(
      totalCount: json['total_count'],
      pageableCount: json['pageable_count'],
      isEnd: json['is_end'],
    );
  }

  @override
  MetaDto mapper() => MetaDto(
        totalCount: totalCount,
        pageableCount: pageableCount,
        isEnd: isEnd,
      );
}
