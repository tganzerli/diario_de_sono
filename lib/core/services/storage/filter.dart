/// Defines the types of comparison operations that can be used in a storage filter.
enum WhereType {
  /// Checks if a column's value is equal to a specified value.
  equals,

  /// Checks if a column's value is not equal to a specified value.
  notEquals,

  /// Checks if a column's value is greater than a specified value.
  greaterThan,

  /// Checks if a column's value is less than a specified value.
  lessThan,

  /// Checks if a column's value is greater than or equal to a specified value.
  greaterThanOrEqual,

  /// Checks if a column's value is less than or equal to a specified value.
  lessThanOrEqual,

  /// Checks if a column's value falls within a specified range (inclusive).
  between,

  /// Checks if a column's value is present in a given list of values.
  inList,

  /// Performs a pattern matching comparison (e.g., SQL LIKE operator).
  like,

  /// Performs a glob-style pattern matching comparison.
  glob,

  /// Checks if a column's value contains a specified substring.
  /// This might be implemented differently depending on the storage backend (e.g., LIKE '%value%').
  contains,

  /// Checks if a column's value is NULL.
  isNull,

  /// Checks if a column's value is not NULL.
  isNotNull,
}

/// Represents a filter to be applied to storage queries.
///
/// This class provides a structured way to define various types of
/// conditions (e.g., equals, greater than, between) that can be used
/// to filter data when interacting with a storage mechanism.
class StorageFilter {
  final WhereType type;
  final String column;
  final Map<String, dynamic> values;

  StorageFilter._({
    required this.type,
    required this.column,
    required this.values,
  });

  /// Creates a filter that checks if a [column]'s value is equal to a specified [value].
  ///
  /// Example: `StorageFilter.equals('name', 'John Doe')`
  /// This would filter for records where the 'name' column is 'John Doe'.
  ///
  factory StorageFilter.equals(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.equals,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that checks if a [column]'s value is not equal to a specified [value].
  ///
  /// Example: `StorageFilter.notEquals('status', 'deleted')`
  /// This would filter for records where the 'status' column is not 'deleted'.
  ///
  factory StorageFilter.notEquals(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.notEquals,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that checks if a [column]'s value is greater than a specified [value].
  ///
  /// Example: `StorageFilter.greaterThan('age', 18)`
  /// This would filter for records where the 'age' column is greater than 18.
  ///
  factory StorageFilter.greaterThan(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.greaterThan,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that checks if a [column]'s value is less than a specified [value].
  ///
  /// Example: `StorageFilter.lessThan('price', 100.0)`
  /// This would filter for records where the 'price' column is less than 100.0.
  ///
  factory StorageFilter.lessThan(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.lessThan,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that checks if a [column]'s value is greater than or equal to a specified [value].
  ///
  /// Example: `StorageFilter.greaterThanOrEqual('quantity', 5)`
  /// This would filter for records where the 'quantity' column is 5 or more.
  ///
  factory StorageFilter.greaterThanOrEqual(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.greaterThanOrEqual,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that checks if a [column]'s value is less than or equal to a specified [value].
  ///
  /// Example: `StorageFilter.lessThanOrEqual('score', 90)`
  /// This would filter for records where the 'score' column is 90 or less.
  ///
  factory StorageFilter.lessThanOrEqual(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.lessThanOrEqual,
      column: column,
      values: {'value': value},
    );
  }
  factory StorageFilter.between(
    /// Creates a filter that checks if a [column]'s value falls within a specified range (inclusive).
    ///
    /// The range is defined by [valueStart] and [valueEnd].
    /// Example: `StorageFilter.between('date', DateTime(2023, 1, 1), DateTime(2023, 1, 31))`
    /// This would filter for records where the 'date' column is between January 1st and January 31st, 2023.
    ///
    String column,
    dynamic valueStart,
    dynamic valueEnd,
  ) {
    return StorageFilter._(
      type: WhereType.between,
      column: column,
      values: {'valueStart': valueStart, 'valueEnd': valueEnd},
    );
  }

  /// Creates a filter that checks if a [column]'s value is present in a given list of [values].
  ///
  /// Example: `StorageFilter.inList('category', ['electronics', 'books'])`
  /// This would filter for records where the 'category' column is either 'electronics' or 'books'.
  ///
  factory StorageFilter.inList(String column, List<dynamic> values) {
    return StorageFilter._(
      type: WhereType.inList,
      column: column,
      values: {'values': values},
    );
  }

  /// Creates a filter that performs a pattern matching comparison (e.g., SQL LIKE operator).
  ///
  /// The [value] typically includes wildcard characters (e.g., '%' for any sequence of characters, '_' for any single character).
  /// Example: `StorageFilter.like('productName', 'Laptop%')`
  /// This would filter for records where the 'productName' column starts with 'Laptop'.
  factory StorageFilter.like(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.like,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that performs a glob-style pattern matching comparison.
  ///
  /// Glob patterns use wildcards like `*` (matches any sequence of characters) and `?` (matches any single character).
  /// Example: `StorageFilter.glob('filename', '*.txt')`
  /// This would filter for records where the 'filename' column ends with '.txt'.
  factory StorageFilter.glob(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.glob,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that checks if a [column]'s value contains a specified [value] (substring).
  ///
  /// This might be implemented differently depending on the storage backend (e.g., LIKE '%value%').
  /// Example: `StorageFilter.contains('description', 'waterproof')`
  /// This would filter for records where the 'description' column contains the word 'waterproof'.
  factory StorageFilter.contains(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.contains,
      column: column,
      values: {'value': value},
    );
  }

  /// Creates a filter that checks if a [column]'s value is NULL.
  ///
  /// Example: `StorageFilter.isNull('completionDate')`
  /// This would filter for records where the 'completionDate' column is NULL.
  ///
  factory StorageFilter.isNull(String column) {
    return StorageFilter._(type: WhereType.isNull, column: column, values: {});
  }

  /// Creates a filter that checks if a [column]'s value is not NULL.
  ///
  /// Example: `StorageFilter.isNotNull('email')`
  /// This would filter for records where the 'email' column is not NULL.
  ///
  factory StorageFilter.isNotNull(String column) {
    return StorageFilter._(
      type: WhereType.isNotNull,
      column: column,
      values: {},
    );
  }
}
