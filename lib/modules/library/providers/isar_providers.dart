import 'package:flower_power/models/manga.dart';
import 'package:flower_power/models/settings.dart';
import 'package:flower_power/repositories/manga_repository.dart';
import 'package:flower_power/repositories/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isar_providers.g.dart';

@riverpod
Stream<List<Manga>> getAllMangaStream(
  Ref ref, {
  required int? categoryId,
  required ItemType itemType,
}) {
  return mangaRepository.watchFavorites(itemType, categoryId: categoryId);
}

@riverpod
Stream<List<Manga>> getAllMangaWithoutCategoriesStream(
  Ref ref, {
  required ItemType itemType,
}) {
  return mangaRepository.watchFavoritesWithoutCategories(itemType);
}

@riverpod
Stream<Settings> getSettingsStream(Ref ref) {
  return settingsRepository.watch();
}
