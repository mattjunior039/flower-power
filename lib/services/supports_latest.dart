import 'package:flower_power/eval/lib.dart';
import 'package:flower_power/models/source.dart';
import 'package:flower_power/modules/more/settings/browse/providers/browse_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'supports_latest.g.dart';

@riverpod
bool supportsLatest(Ref ref, {required Source source}) {
  final androidProxy = ref.read(androidProxyServerStateProvider);
  return getCachedExtensionService(source, androidProxy).supportsLatest;
}
