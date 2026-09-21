import 'package:flower_power/models/chapter.dart';
import 'package:flower_power/models/manga.dart';
import 'package:flower_power/repositories/chapter_repository.dart';
import 'package:flower_power/repositories/manga_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isar_providers.g.dart';

@riverpod
Stream<Manga?> getMangaDetailStream(Ref ref, {required int mangaId}) async* {
  yield* mangaRepository.watchById(mangaId);
}

@riverpod
Stream<List<Chapter>> getChaptersStream(
  Ref ref, {
  required int mangaId,
}) async* {
  yield* chapterRepository.watchByMangaId(mangaId);
}
