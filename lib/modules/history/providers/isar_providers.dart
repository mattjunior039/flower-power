import 'package:flower_power/models/update.dart';
import 'package:flower_power/models/history.dart';
import 'package:flower_power/models/manga.dart';
import 'package:flower_power/repositories/history_repository.dart';
import 'package:flower_power/repositories/manga_repository.dart';
import 'package:flower_power/repositories/update_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isar_providers.g.dart';

@riverpod
Stream<List<History>> getAllHistoryStream(
  Ref ref, {
  required ItemType itemType,
  String search = "",
}) async* {
  yield* historyRepository.watchByItemTypeAndSearch(itemType, search);
}

@Riverpod(keepAlive: true)
class ActiveHistoryItemTypeState extends _$ActiveHistoryItemTypeState {
  @override
  ItemType build() => ItemType.manga;

  void set(ItemType type) => state = type;
}

@riverpod
Stream<List<Update>> getAllUpdateStream(
  Ref ref, {
  required ItemType itemType,
  String search = "",
}) async* {
  // Filtering via .chapter((q) => q.manga(...)) makes Isar walk and fully
  // deserialize the linked Chapter+Manga for every Update row on every watch
  // re-evaluation. Resolving matching manga ids up front (indexed) and
  // filtering Updates by mangaId (also indexed) avoids that link traversal.
  final mangaIdsStream = mangaRepository.watchIdsByItemTypeAndSearch(
    itemType,
    search,
  );

  await for (final mangaIds in mangaIdsStream) {
    yield* updateRepository.watchByMangaIds(mangaIds);
  }
}
