import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flower_power/modules/more/settings/reader/providers/reader_state_provider.dart';
import 'package:flower_power/modules/more/widgets/downloaded_only_widget.dart';
import 'package:flower_power/modules/more/widgets/incognito_mode_widget.dart';
import 'package:flower_power/modules/more/widgets/list_tile_widget.dart';
import 'package:flower_power/providers/l10n_providers.dart';
import 'package:flower_power/utils/constant.dart';
import 'package:flower_power/utils/platform_utils.dart';
import 'package:flower_power/models/manga.dart';
import 'package:flower_power/l10n/generated/app_localizations.dart';

import 'package:flower_power/modules/more/about/providers/get_package_info.dart';

class MoreScreen extends ConsumerStatefulWidget {
  const MoreScreen({super.key});

  @override
  ConsumerState<MoreScreen> createState() => MoreScreenState();
}

class MoreScreenState extends ConsumerState<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = l10nLocalizations(context)!;
    final hiddenItems = ref.watch(hideItemsStateProvider);

    if (Platform.isIOS && !isTv) {
      return _buildIos(context, l10n, hiddenItems);
    }
    return _buildMaterial(context, l10n, hiddenItems);
  }

  Widget _buildIos(BuildContext context, AppLocalizations l10n, List<String> hiddenItems) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(l10n.more),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    appIconAssets[2],
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ),
                CupertinoListSection.insetGrouped(
                  hasLeading: true,
                  children: const [
                    DownloadedOnlyWidget(),
                    IncognitoModeWidget(),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  hasLeading: true,
                  children: [
                    if (hiddenItems.contains("/history"))
                      ListTileWidget(
                        onTap: () {
                          context.push('/history');
                        },
                        icon: Icons.history,
                        title: l10n.history,
                      ),
                    if (!isTv)
                      ListTileWidget(
                        onTap: () {
                          context.push('/downloadQueue');
                        },
                        icon: Icons.download_outlined,
                        title: l10n.download_queue,
                      ),
                    ListTileWidget(
                      onTap: () {
                        context.push('/categories', extra: (false, 0));
                      },
                      icon: Icons.label_outline_rounded,
                      title: l10n.categories,
                    ),
                    ListTileWidget(
                      onTap: () {
                        context.push('/statistics');
                      },
                      icon: Icons.query_stats_outlined,
                      title: l10n.statistics,
                    ),
                    ListTileWidget(
                      onTap: () {
                        context.push('/calendarScreen');
                      },
                      icon: Icons.calendar_month_outlined,
                      title: l10n.calendar,
                    ),
                    ListTileWidget(
                      onTap: () {
                        context.push('/dataAndStorage');
                      },
                      icon: Icons.storage,
                      title: l10n.data_and_storage,
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  hasLeading: true,
                  children: [
                    ListTileWidget(
                      onTap: () {
                        context.push('/settings');
                      },
                      icon: Icons.settings_outlined,
                      title: l10n.settings,
                    ),
                    ListTileWidget(
                      onTap: () {
                        context.push('/about');
                      },
                      icon: Icons.info_outline,
                      title: l10n.about,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ref.watch(getPackageInfoProvider).when(
                  data: (data) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'v${data.version}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterial(BuildContext context, AppLocalizations l10n, List<String> hiddenItems) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: tvPageInsets,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset(
                  appIconAssets[2],
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
              const Divider(),
              const DownloadedOnlyWidget(),
              const IncognitoModeWidget(),
              const Divider(),
              if (hiddenItems.contains("/history"))
                ListTileWidget(
                  onTap: () {
                    context.push('/history');
                  },
                  icon: Icons.history,
                  title: l10n.history,
                ),
              if (!isTv)
                ListTileWidget(
                  onTap: () {
                    context.push('/downloadQueue');
                  },
                  icon: Icons.download_outlined,
                  title: l10n.download_queue,
                ),
              if (isTv)
                ListTileWidget(
                  onTap: () => context.push(
                    '/massMigration',
                    extra: (ItemType.anime, null),
                  ),
                  icon: Icons.swap_horiz,
                  title: l10n.mass_migration_title,
                ),
              ListTileWidget(
                onTap: () {
                  context.push('/categories', extra: (false, 0));
                },
                icon: Icons.label_outline_rounded,
                title: l10n.categories,
              ),
              ListTileWidget(
                onTap: () {
                  context.push('/statistics');
                },
                icon: Icons.query_stats_outlined,
                title: l10n.statistics,
              ),
              ListTileWidget(
                onTap: () {
                  context.push('/calendarScreen');
                },
                icon: Icons.calendar_month_outlined,
                title: l10n.calendar,
              ),
              ListTileWidget(
                onTap: () {
                  context.push('/dataAndStorage');
                },
                icon: Icons.storage,
                title: l10n.data_and_storage,
              ),
              const Divider(),
              ListTileWidget(
                onTap: () {
                  context.push('/settings');
                },
                icon: Icons.settings_outlined,
                title: l10n.settings,
              ),
              ListTileWidget(
                onTap: () {
                  context.push('/about');
                },
                icon: Icons.info_outline,
                title: l10n.about,
              ),
              const SizedBox(height: 20),
              ref
                  .watch(getPackageInfoProvider)
                  .when(
                    data: (data) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'v${data.version}',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
