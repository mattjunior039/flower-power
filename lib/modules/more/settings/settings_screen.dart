import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flower_power/modules/main_view/providers/tv_mode_provider.dart';
import 'package:flower_power/modules/more/widgets/list_tile_widget.dart';
import 'package:flower_power/providers/l10n_providers.dart';
import 'package:flower_power/utils/platform_utils.dart';
import 'package:flower_power/l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = l10nLocalizations(context)!;
    final animeOnly = ref.watch(animeOnlyTvModeProvider);

    if (Platform.isIOS && !isTv) {
      return _buildIos(context, l10n, animeOnly);
    }
    return _buildMaterial(context, l10n, animeOnly);
  }

  Widget _buildIos(BuildContext context, AppLocalizations l10n, bool animeOnly) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(l10n.settings),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CupertinoListSection.insetGrouped(
                  hasLeading: true,
                  children: [
                    ListTileWidget(
                      title: l10n.general,
                      icon: Icons.settings,
                      onTap: () => context.push('/general'),
                    ),
                    ListTileWidget(
                      title: l10n.appearance,
                      icon: Icons.color_lens_rounded,
                      onTap: () => context.push('/appearance'),
                    ),
                  ],
                ),
                if (!animeOnly)
                  CupertinoListSection.insetGrouped(
                    hasLeading: true,
                    children: [
                      ListTileWidget(
                        title: l10n.reader,
                        icon: Icons.chrome_reader_mode_rounded,
                        onTap: () => context.push('/readerMode'),
                      ),
                      ListTileWidget(
                        title: '${l10n.novel} ${l10n.reader}',
                        icon: Icons.menu_book_rounded,
                        onTap: () => context.push('/novelReaderMode'),
                      ),
                    ],
                  ),
                CupertinoListSection.insetGrouped(
                  hasLeading: true,
                  children: [
                    ListTileWidget(
                      title: l10n.player,
                      icon: Icons.play_circle_outline_outlined,
                      onTap: () => context.push('/playerOverview'),
                    ),
                    ListTileWidget(
                      title: l10n.downloads,
                      icon: Icons.download_outlined,
                      onTap: () => context.push('/downloads'),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  hasLeading: true,
                  children: [
                    ListTileWidget(
                      title: l10n.tracking,
                      icon: Icons.sync_outlined,
                      onTap: () => context.push('/track'),
                    ),
                    ListTileWidget(
                      title: l10n.syncing,
                      icon: Icons.cloud_sync_outlined,
                      onTap: () => context.push('/sync'),
                    ),
                    ListTileWidget(
                      title: l10n.browse,
                      icon: Icons.explore_rounded,
                      onTap: () => context.push('/browseS'),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  hasLeading: true,
                  children: [
                    if (!Platform.isLinux)
                      ListTileWidget(
                        title: l10n.security,
                        icon: Icons.security_rounded,
                        onTap: () => context.push('/security'),
                      ),
                    ListTileWidget(
                      title: l10n.about,
                      icon: Icons.info_outline,
                      onTap: () => context.push('/about'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterial(BuildContext context, AppLocalizations l10n, bool animeOnly) {
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: SingleChildScrollView(
        padding: tvPageInsets,
        child: Column(
          children: [
            ListTileWidget(
              autofocus: isTv,
              title: l10n.general,
              icon: Icons.settings,
              onTap: () => context.push('/general'),
            ),
            ListTileWidget(
              title: l10n.appearance,
              icon: Icons.color_lens_rounded,
              onTap: () => context.push('/appearance'),
            ),
            if (!animeOnly) ...[
              ListTileWidget(
                title: l10n.reader,
                icon: Icons.chrome_reader_mode_rounded,
                onTap: () => context.push('/readerMode'),
              ),
              ListTileWidget(
                title: '${l10n.novel} ${l10n.reader}',
                icon: Icons.menu_book_rounded,
                onTap: () => context.push('/novelReaderMode'),
              ),
            ],
            ListTileWidget(
              title: l10n.player,
              icon: Icons.play_circle_outline_outlined,
              onTap: () => context.push('/playerOverview'),
            ),
            ListTileWidget(
              title: l10n.downloads,
              icon: Icons.download_outlined,
              onTap: () => context.push('/downloads'),
            ),
            ListTileWidget(
              title: l10n.tracking,
              icon: Icons.sync_outlined,
              onTap: () => context.push('/track'),
            ),
            ListTileWidget(
              title: l10n.syncing,
              icon: Icons.cloud_sync_outlined,
              onTap: () => context.push('/sync'),
            ),
            ListTileWidget(
              title: l10n.browse,
              icon: Icons.explore_rounded,
              onTap: () => context.push('/browseS'),
            ),
            if (!Platform.isLinux)
              ListTileWidget(
                title: l10n.security,
                icon: Icons.security_rounded,
                onTap: () => context.push('/security'),
              ),
            ListTileWidget(
              title: l10n.about,
              icon: Icons.info_outline,
              onTap: () => context.push('/about'),
            ),
          ],
        ),
      ),
    );
  }
}
