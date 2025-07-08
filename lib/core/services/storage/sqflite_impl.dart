import 'database_helper.dart';
import 'storage_service.dart';

class SqfliteStorageService implements StorageService {
  final DatabaseHelper _dbHelper;

  SqfliteStorageService(this._dbHelper);

  Map<String, dynamic> _buildWhereClause(List<StorageFilter> filters) {
    if (filters.isEmpty) {
      return {'where': '', 'whereArgs': <Object?>[]};
    }

    final whereParts = <String>[];
    final whereArgs = <Object?>[];

    for (var filter in filters) {
      switch (filter.type) {
        case WhereType.equals:
          whereParts.add('${filter.column} = ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.notEquals:
          whereParts.add('${filter.column} <> ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.greaterThan:
          whereParts.add('${filter.column} > ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.lessThan:
          whereParts.add('${filter.column} < ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.greaterThanOrEqual:
          whereParts.add('${filter.column} >= ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.lessThanOrEqual:
          whereParts.add('${filter.column} <= ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.between:
          whereParts.add('${filter.column} BETWEEN ? AND ?');
          whereArgs.add(filter.values['valueStart']);
          whereArgs.add(filter.values['valueEnd']);
          break;
        case WhereType.inList:
          final values = filter.values['values'] as List;
          final placeholders = List.filled(values.length, '?').join(', ');
          whereParts.add('${filter.column} IN ($placeholders)');
          whereArgs.addAll(values);
          break;
        case WhereType.like:
          whereParts.add('${filter.column} LIKE ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.glob:
          whereParts.add('${filter.column} GLOB ?');
          whereArgs.add(filter.values['value']);
          break;
        case WhereType.contains:
          whereParts.add('${filter.column} LIKE ?');
          whereArgs.add('%${filter.values['value']}%');
          break;
        case WhereType.isNull:
          whereParts.add('${filter.column} IS NULL');
          break;
        case WhereType.isNotNull:
          whereParts.add('${filter.column} IS NOT NULL');
          break;
      }
    }

    return {'where': whereParts.join(' AND '), 'whereArgs': whereArgs};
  }

  @override
  Future<Map<String, dynamic>> create(Map<String, dynamic> itens) async {
    final db = await _dbHelper.database;
    final id = await db.insert(_dbHelper.tableName, itens);
    itens['id'] = id;
    return itens;
  }

  @override
  Future<List<Map<String, dynamic>>> find([
    List<StorageFilter> filters = const [],
  ]) async {
    final db = await _dbHelper.database;
    final clause = _buildWhereClause(filters);
    return await db.query(
      _dbHelper.tableName,
      where: clause['where'].isEmpty ? null : clause['where'],
      whereArgs: clause['whereArgs'].isEmpty ? null : clause['whereArgs'],
    );
  }

  @override
  Future<Map<String, dynamic>?> findOne([
    List<StorageFilter> filters = const [],
  ]) async {
    final results = await find(filters);
    return results.isEmpty ? null : results.first;
  }

  @override
  Future<int> update(
    Map<String, dynamic> data, [
    List<StorageFilter> filters = const [],
  ]) async {
    final db = await _dbHelper.database;
    final clause = _buildWhereClause(filters);
    return await db.update(
      _dbHelper.tableName,
      data,
      where: clause['where'],
      whereArgs: clause['whereArgs'],
    );
  }

  @override
  Future<int> delete([List<StorageFilter> filters = const []]) async {
    final db = await _dbHelper.database;
    final clause = _buildWhereClause(filters);
    return await db.delete(
      _dbHelper.tableName,
      where: clause['where'],
      whereArgs: clause['whereArgs'],
    );
  }
}
