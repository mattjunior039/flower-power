import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flower_power/modules/more/providers/downloaded_only_state_provider.dart';
import 'package:flower_power/modules/more/widgets/list_tile_widget.dart';
import 'package:flower_power/providers/l10n_providers.dart';

class DownloadedOnlyWidget extends ConsumerWidget {
  const DownloadedOnlyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = l10nLocalizations(context);
    final downloadedOnly = ref.watch(downloadedOnlyStateProvider);
    return ListTileWidget(
      onTap: () => ref
          .read(downloadedOnlyStateProvider.notifier)
          .setDownloadedOnly(!downloadedOnly),
      icon: Icons.cloud_off_outlined,
      subtitle: l10n!.downloaded_only_description,
      title: l10n.downloaded_only,
      trailing: Switch(
        value: downloadedOnly,
        onChanged: (value) => ref
            .read(downloadedOnlyStateProvider.notifier)
            .setDownloadedOnly(value),
      ),
    );
  }
}
