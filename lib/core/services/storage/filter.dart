enum WhereType {
  equals,
  notEquals,
  greaterThan,
  lessThan,
  greaterThanOrEqual,
  lessThanOrEqual,
  between,
  inList,
  like,
  glob,
  contains,
  isNull,
  isNotNull,
}

class StorageFilter {
  final WhereType type;
  final String column;
  final Map<String, dynamic> values;

  StorageFilter._({
    required this.type,
    required this.column,
    required this.values,
  });

  factory StorageFilter.equals(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.equals,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.notEquals(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.notEquals,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.greaterThan(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.greaterThan,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.lessThan(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.lessThan,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.greaterThanOrEqual(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.greaterThanOrEqual,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.lessThanOrEqual(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.lessThanOrEqual,
      column: column,
      values: {'value': value},
    );
  }
  factory StorageFilter.between(
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

  factory StorageFilter.inList(String column, List<dynamic> values) {
    return StorageFilter._(
      type: WhereType.inList,
      column: column,
      values: {'values': values},
    );
  }

  factory StorageFilter.like(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.like,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.glob(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.glob,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.contains(String column, dynamic value) {
    return StorageFilter._(
      type: WhereType.contains,
      column: column,
      values: {'value': value},
    );
  }

  factory StorageFilter.isNull(String column) {
    return StorageFilter._(type: WhereType.isNull, column: column, values: {});
  }

  factory StorageFilter.isNotNull(String column) {
    return StorageFilter._(
      type: WhereType.isNotNull,
      column: column,
      values: {},
    );
  }
}
