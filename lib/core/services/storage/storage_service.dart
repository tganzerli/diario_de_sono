import 'package:diario_de_sono/core/services/storage/filter.dart';

export 'filter.dart';

/// Services that handle data storage operations.
///
/// Implementations of this interface are responsible for providing methods
/// to create, retrieve, update, and delete data, typically from a persistent
/// storage like a database.
abstract interface class StorageService {
  /// Creates a new record in the storage with the given [itens].
  ///
  /// Returns the created record, typically with an ID assigned by the storage.
  ///
  /// [itens]: A map representing the data to be stored.
  Future<Map<String, dynamic>> create(Map<String, dynamic> itens);

  /// Retrieves a list of records from the storage.
  ///
  /// Records can be filtered by providing a list of [filters].
  /// Returns a list of maps, where each map represents a record.
  ///
  /// [filters]: Optional list of [StorageFilter] to apply to the query.
  Future<List<Map<String, dynamic>>> find([
    List<StorageFilter> filters = const [],
  ]);

  /// Retrieves a single record from the storage.
  ///
  /// The record can be filtered by providing a list of [filters].
  /// Returns a map representing the record if found, otherwise `null`.
  ///
  /// [filters]: Optional list of [StorageFilter] to apply to the query.
  Future<Map<String, dynamic>?> findOne([
    List<StorageFilter> filters = const [],
  ]);

  /// Updates records in the storage with the given [data].
  ///
  /// Records to be updated can be filtered by providing a list of [filters].
  /// Returns the number of records updated.
  ///
  /// [data]: A map representing the data to update the records with.
  /// [filters]: Optional list of [StorageFilter] to apply to the update operation.
  Future<int> update(
    Map<String, dynamic> data, [
    List<StorageFilter> filters = const [],
  ]);

  /// Deletes records from the storage.
  ///
  /// Records to be deleted can be filtered by providing a list of [filters].
  /// Returns the number of records deleted.
  ///
  /// [filters]: Optional list of [StorageFilter] to apply to the delete operation.
  Future<int> delete([List<StorageFilter> filters = const []]);
}
