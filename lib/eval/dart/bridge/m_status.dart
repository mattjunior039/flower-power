import 'package:d4rt/d4rt.dart';
import 'package:flower_power/models/manga.dart';

class MStatusBridge {
  final statusDefinition = BridgedEnumDefinition<Status>(
    name: 'MStatus',
    values: Status.values,
  );
  void registerBridgedEnum(D4rt interpreter) {
    interpreter.registerBridgedEnum(
      statusDefinition,
      'package:flower_power/bridge_lib.dart',
    );
  }
}
