import 'package:flower_power/eval/lib.dart';
import 'package:flower_power/eval/model/source_preference.dart';
import 'package:flower_power/models/source.dart';

List<SourcePreference> getSourcePreference({required Source source}) {
  return getCachedExtensionService(source, "").getSourcePreferences();
}
