import 'package:data/mapper/data_to_domain_mapper.dart';
import 'package:data/model/meta_response.dart';
import 'package:domain/model/paging_dto.dart';

class PagingResponse<T extends DataToDomainMapper<DomainT>, DomainT>
    extends DataToDomainMapper<PagingDto<DomainT>> {
  final MetaResponse metaResponse;
  final List<T> documents;

  PagingResponse({
    required this.metaResponse,
    required this.documents,
  });

  factory PagingResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
    DomainT Function(Object? json) fromJsonDomainT,
  ) {
    return PagingResponse(
      metaResponse: MetaResponse.fromJson(json['meta']),
      documents: (json['documents'] as List).map((e) => fromJsonT(e)).toList(),
    );
  }

  @override
  PagingDto<DomainT> mapper() => PagingDto(
        metaDto: metaResponse.mapper(),
        documents: documents.map((e) => e.mapper()).toList(),
      );
}