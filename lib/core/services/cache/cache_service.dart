import 'cache_params.dart';

export 'cache_params.dart';

abstract interface class Cache {
  /// Saves data in the cache.
  ///
  /// Returns `true` if the operation is successful, otherwise `false`.
  Future<bool> setData(CacheParams params);

  /// Retrieves data from the cache using a unique key.
  ///
  /// Returns the cached value if found, otherwise `null`.
  Future<String> getData(String key);

  /// Removes a specific cached item by key.
  ///
  /// Returns `true` if the item was successfully removed, otherwise `false`.
  Future<bool> removeData(String key);

  /// Clears all stored cache data.
  ///
  /// Returns `true` if the operation is successful, otherwise `false`.
  Future<bool> clearAll();
}
