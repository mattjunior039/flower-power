import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flower_power/models/manga.dart';
import 'package:flower_power/modules/library/library_screen.dart';
import 'package:flower_power/providers/l10n_providers.dart';
import 'package:flower_power/l10n/generated/app_localizations.dart';
import 'package:flower_power/utils/item_type_localization.dart';
import 'package:flower_power/utils/platform_utils.dart';
import 'package:flower_power/modules/widgets/tv_pill.dart';
import 'package:flower_power/modules/main_view/providers/tv_mode_provider.dart';

class GlobalLibraryScreen extends ConsumerStatefulWidget {
  const GlobalLibraryScreen({super.key});

  @override
  ConsumerState<GlobalLibraryScreen> createState() => _GlobalLibraryScreenState();
}

class _GlobalLibraryScreenState extends ConsumerState<GlobalLibraryScreen> with TickerProviderStateMixin {
  late TabController tabController;
  late List<ItemType> itemTypes;

  @override
  void initState() {
    super.initState();
    itemTypes = [ItemType.manga, ItemType.anime, ItemType.novel];
    if (ref.read(animeOnlyTvModeProvider)) {
      itemTypes = [ItemType.anime];
    }
    tabController = TabController(length: itemTypes.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  PreferredSizeWidget? _buildTabSwitcher(BuildContext context, AppLocalizations l10n) {
    if (isTv) {
      if (itemTypes.length < 2) return null;
      return PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AnimatedBuilder(
          animation: tabController,
          builder: (context, _) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < itemTypes.length; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    TvPill(
                      label: itemTypes[i].localized(l10n),
                      selected: tabController.index == i,
                      onTap: () {
                        tabController.animateTo(i);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    if (itemTypes.length < 2) return null;
    return TabBar(
      controller: tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: itemTypes.map((t) => Tab(text: t.localized(l10n))).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = l10nLocalizations(context)!;
    final tabSwitcher = _buildTabSwitcher(context, l10n);

    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: itemTypes.map((type) {
          return LibraryScreen(
            itemType: type,
            presetInput: null,
            topTabBar: tabSwitcher,
          );
        }).toList(),
      ),
    );
  }
}
