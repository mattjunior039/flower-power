import 'package:flower_power/eval/lib.dart';
import 'package:flower_power/models/source.dart';
import 'package:flower_power/modules/more/settings/browse/providers/browse_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_source_baseurl.g.dart';

@riverpod
String sourceBaseUrl(Ref ref, {required Source source}) {
  return getCachedExtensionService(
    source,
    ref.read(androidProxyServerStateProvider),
  ).sourceBaseUrl;
}
