import 'package:domain/model/meta_dto.dart';

class PagingDto<T> {
  final MetaDto metaDto;
  final List<T> documents;

  PagingDto({
    required this.metaDto,
    required this.documents,
  });
}
