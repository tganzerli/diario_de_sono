import 'database_helper.dart';
import 'storage_service.dart';

class SqfliteStorageService implements StorageService {
  final DatabaseHelper _dbHelper;

  SqfliteStorageService(this._dbHelper);

  Map<String, dynamic> _buildWhereClause(Map<String, dynamic> filter) {
    if (filter.isEmpty) return {'where': '', 'whereArgs': []};
    final whereParts = <String>[];
    final whereArgs = <Object?>[];
    filter.forEach((key, value) {
      whereParts.add('$key = ?');
      whereArgs.add(value);
    });
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
  Future<List<Map<String, dynamic>>> find(Map<String, dynamic> filter) async {
    final db = await _dbHelper.database;
    final clause = _buildWhereClause(filter);
    return await db.query(
      _dbHelper.tableName,
      where: clause['where'].isEmpty ? null : clause['where'],
      whereArgs: clause['whereArgs'].isEmpty ? null : clause['whereArgs'],
    );
  }

  @override
  Future<Map<String, dynamic>?> findOne(Map<String, dynamic> filter) async {
    final results = await find(filter);
    return results.isEmpty ? null : results.first;
  }

  @override
  Future<int> update(
    Map<String, dynamic> filter,
    Map<String, dynamic> data,
  ) async {
    final db = await _dbHelper.database;
    final clause = _buildWhereClause(filter);
    return await db.update(
      _dbHelper.tableName,
      data,
      where: clause['where'],
      whereArgs: clause['whereArgs'],
    );
  }

  @override
  Future<int> delete(Map<String, dynamic> filter) async {
    final db = await _dbHelper.database;
    final clause = _buildWhereClause(filter);
    return await db.delete(
      _dbHelper.tableName,
      where: clause['where'],
      whereArgs: clause['whereArgs'],
    );
  }
}
