import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:diario_de_sono/data/repositories/sleep_log_repository.dart';
import 'package:diario_de_sono/domain/dto/sleep_log_dto.dart';
import 'package:diario_de_sono/domain/entities/sleep_log.dart';
import 'package:diario_de_sono/core/services/storage/storage_service.dart';
import 'package:diario_de_sono/core/value_object/of_time_vo.dart';

class MockStorageService extends Mock implements StorageService {}

class FakeStorageFilter extends Fake implements StorageFilter {}

class FakeMap extends Fake implements Map<String, dynamic> {}

void main() {
  late MockStorageService mockStorageService;
  late SleepLogRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(<StorageFilter>[]);
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockStorageService = MockStorageService();
    repository = SleepLogRepositoryImpl(mockStorageService);
  });

  group('add', () {
    test('should add a valid sleep log and return Success', () async {
      final dto = SleepLogDto(
        bedtime: OfTime('22:00'),
        sleepLatency: OfTime('00:15'),
        sleepDuration: OfTime('07:30'),
        awakeningsCount: 1,
      );
      when(
        () => mockStorageService.create(any()),
      ).thenAnswer((_) async => {'id': 1});
      final result = await repository.add(dto);
      expect(result.isSuccess(), true);
    });

    test('should return Failure when storage throws', () async {
      final dto = SleepLogDto(
        bedtime: OfTime('22:00'),
        sleepLatency: OfTime('00:15'),
        sleepDuration: OfTime('07:30'),
        awakeningsCount: 1,
      );
      when(
        () => mockStorageService.create(any()),
      ).thenThrow(Exception('error'));
      final result = await repository.add(dto);
      expect(result.isError(), true);
    });
  });

  group('get', () {
    test('should return a list of SleepLog on success', () async {
      when(() => mockStorageService.find(any())).thenAnswer(
        (_) async => [
          {
            'id': 1,
            'date': DateTime.now().millisecondsSinceEpoch,
            'bedtime': '22:00',
            'sleep_latency': '00:15',
            'sleep_duration': '07:30',
            'awakenings_count': 1,
            'is_sent': 0,
          },
        ],
      );
      final result = await repository.get();
      expect(result.isSuccess(), true);
      expect(result.getOrNull(), isA<List<SleepLog>>());
    });

    test('should return Failure when storage throws', () async {
      when(() => mockStorageService.find(any())).thenThrow(Exception('error'));
      final result = await repository.get();
      expect(result.isError(), true);
    });
  });

  group('getToSend', () {
    test('should return a list of SleepLog to send', () async {
      when(() => mockStorageService.find(any())).thenAnswer(
        (_) async => [
          {
            'id': 1,
            'date': DateTime.now().millisecondsSinceEpoch,
            'bedtime': '22:00',
            'sleep_latency': '00:15',
            'sleep_duration': '07:30',
            'awakenings_count': 1,
            'is_sent': 0,
          },
        ],
      );
      final result = await repository.getToSend();
      expect(result.isSuccess(), true);
      expect(result.getOrNull(), isA<List<SleepLog>>());
    });
  });

  group('updateToSend', () {
    test('should update logs to sent and return Success', () async {
      when(
        () => mockStorageService.update(any(), any()),
      ).thenAnswer((_) async => 1);
      final result = await repository.updateToSend();
      expect(result.isSuccess(), true);
    });

    test('should return Failure when storage throws', () async {
      when(
        () => mockStorageService.update(any(), any()),
      ).thenThrow(Exception('error'));
      final result = await repository.updateToSend();
      expect(result.isError(), true);
    });
  });
}
