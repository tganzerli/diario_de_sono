/// Represents the parameters required for caching operations.
///
/// This class is used to store a key-value pair that can be cached.
class CacheParams {
  /// The unique key identifying the cached data.
  final String key;

  /// The value associated with the key in the cache.
  final String value;

  /// Indicates whether the cached data should be stored in session storage.
  /// (Session storage is typically used for data that should only persist for the duration of a page session.)
  /// Defaults to `false`, meaning the data will be stored in persistent storage.
  final bool sessionStorage;

  /// Creates a `CacheParams` instance with the given key and value.
  const CacheParams({
    required this.key,
    required this.value,
    this.sessionStorage = false,
  });
}
