import 'package:isar_community/isar.dart';
import 'package:flower_power/main.dart';
import 'package:flower_power/models/backup_password_fallback.dart';
import 'package:flower_power/repositories/db_write_queue.dart';

class BackupPasswordRepository {
  Future<BackupPasswordFallback?> findPlaintextFallback() =>
      isar.backupPasswordFallbacks.filter().idEqualTo(0).findFirst();

  Future<void> savePlaintextFallback(String password) => dbWriteQueue.run(
    () => isar.writeTxn(() async {
      await isar.backupPasswordFallbacks.put(
        BackupPasswordFallback()..password = password,
      );
    }),
  );

  Future<void> clearPlaintextFallback() => dbWriteQueue.run(
    () => isar.writeTxn(() async {
      await isar.backupPasswordFallbacks.delete(0);
    }),
  );
}

final backupPasswordRepository = BackupPasswordRepository();
