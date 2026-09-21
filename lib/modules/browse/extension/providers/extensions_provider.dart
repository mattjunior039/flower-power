import 'package:flower_power/models/manga.dart';
import 'package:flower_power/models/source.dart';
import 'package:flower_power/repositories/source_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'extensions_provider.g.dart';

@riverpod
Stream<List<Source>> getExtensionsStream(Ref ref, ItemType itemType) async* {
  yield* sourceRepository.watchActiveVisibleByItemType(itemType);
}
