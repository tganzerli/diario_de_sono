import 'package:diario_de_sono/core/services/storage/filter.dart';

export 'filter.dart';

abstract interface class StorageService {
  Future<Map<String, dynamic>> create(Map<String, dynamic> itens);
  Future<List<Map<String, dynamic>>> find([
    List<StorageFilter> filters = const [],
  ]);
  Future<Map<String, dynamic>?> findOne([
    List<StorageFilter> filters = const [],
  ]);
  Future<int> update(
    Map<String, dynamic> data, [
    List<StorageFilter> filters = const [],
  ]);
  Future<int> delete([List<StorageFilter> filters = const []]);
}
