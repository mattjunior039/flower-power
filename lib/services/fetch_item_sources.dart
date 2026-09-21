import 'package:flower_power/models/manga.dart';
import 'package:flower_power/models/settings.dart';
import 'package:flower_power/modules/more/settings/browse/providers/browse_state_provider.dart';
import 'package:flower_power/services/fetch_sources_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flower_power/utils/log/logger.dart';
part 'fetch_item_sources.g.dart';

@Riverpod(keepAlive: true)
Future<void> fetchItemSourcesList(
  Ref ref, {
  int? id,
  required bool reFresh,
  required ItemType itemType,
}) async {
  if (ref.watch(checkForExtensionsUpdateStateProvider) || reFresh) {
    final repos = ref.watch(extensionsRepoStateProvider(itemType));
    for (Repo repo in repos) {
      try {
        await fetchSourcesList(
          repo: repo,
          refresh: reFresh,
          id: id,
          androidProxyServer: ref.watch(androidProxyServerStateProvider),
          autoUpdateExtensions: ref.watch(autoUpdateExtensionsStateProvider),
          itemType: itemType,
        );
      } catch (e, st) {
        // The user just sees no sources for the repo.
        AppLogger.log(
          'fetchItemSources: repo fetch failed: $e\n$st',
          logLevel: LogLevel.error,
        );
      }
    }
  }
}
