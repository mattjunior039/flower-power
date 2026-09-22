import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flower_power/modules/more/settings/appearance/providers/theme_mode_state_provider.dart';
import 'package:flower_power/repositories/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'flex_scheme_color_state_provider.g.dart';

@riverpod
class FlexSchemeColorState extends _$FlexSchemeColorState {
  @override
  (FlexSchemeColor color, int index) build() {
    final index = settingsRepository.current.flexSchemeColorIndex ?? 0;
    final color = ref.read(themeModeStateProvider)
        ? ThemeAA.schemes[index].dark
        : ThemeAA.schemes[index].light;
    return (color, index);
  }

  void setTheme(FlexSchemeColor color, int index) {
    state = (color, index);
    settingsRepository.update((s) => s.flexSchemeColorIndex = index);
  }
}

class ThemeAA {
  static const FlexSchemeData flowerPowerScheme = FlexSchemeData(
    name: 'Flower Power',
    description: 'The official FlowerPower aesthetic',
    light: FlexSchemeColor(
      primary: Color(0xFFFF2E7E), // accent from index.html
      primaryContainer: Color(0xFFFFD9E2),
      secondary: Color(0xFF111111), // text from index.html
      secondaryContainer: Color(0xFFD6D6D6),
      tertiary: Color(0xFFFF2E7E),
      tertiaryContainer: Color(0xFFFFD9E2),
      appBarColor: Color(0xFFFF2E7E),
      error: Color(0xFFB00020),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFFFF2E7E),
      primaryContainer: Color(0xFF7A0033),
      secondary: Color(0xFFFDFBFB), // off-white
      secondaryContainer: Color(0xFF333333),
      tertiary: Color(0xFFFF2E7E),
      tertiaryContainer: Color(0xFF7A0033),
      appBarColor: Color(0xFFFF2E7E),
      error: Color(0xFFCF6679),
    ),
  );

  static const List<FlexSchemeData> schemes = <FlexSchemeData>[
    flowerPowerScheme,
    ...FlexColor.schemesList,
  ];
}
