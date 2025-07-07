abstract interface class StorageService {
  Future<Map<String, dynamic>> create(Map<String, dynamic> itens);
  Future<List<Map<String, dynamic>>> find(Map<String, dynamic> filter);
  Future<Map<String, dynamic>?> findOne(Map<String, dynamic> filter);
  Future<int> update(Map<String, dynamic> filter, Map<String, dynamic> data);
  Future<int> delete(Map<String, dynamic> filter);
}
