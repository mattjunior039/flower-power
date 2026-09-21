import 'package:flower_power/eval/lib.dart';
import 'package:flower_power/models/source.dart';

List<dynamic> getFilterList({required Source source}) {
  return getCachedExtensionService(source, "").getFilterList().filters;
}
