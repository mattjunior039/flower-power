import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'blend_level_state_provider.dart';
import 'flex_scheme_color_state_provider.dart';
import 'pure_black_dark_mode_state_provider.dart';
import 'app_font_family.dart';

import 'package:flower_power/utils/platform_utils.dart';

/// Material draws a focused InkWell's highlight from the ambient
/// [ThemeData.focusColor], and the default is nearly invisible on a TV
/// across a room. Tinting it with the scheme's primary makes every focusable
/// built on an InkResponse legible with a remote: popup menu buttons and
/// their items, list tiles, icon buttons. Off-TV the theme is untouched.
ThemeData _tvFocus(ThemeData theme) {
  if (!isTv) return theme;
  // A focused button drew only a faint focusColor overlay, which is invisible on
  // a filled button (e.g. a dialog's Add/OK) — you can't tell it is focused.
  // Add a high-contrast ring on the focused state so any button reads clearly on
  // a TV, filled or not. Buttons that carry no border otherwise (Text/Elevated/
  // Filled) get the ring only while focused.
  final ring = WidgetStateProperty.resolveWith<BorderSide?>(
    (states) => states.contains(WidgetState.focused)
        ? BorderSide(color: theme.colorScheme.onSurface, width: 2.5)
        : null,
  );
  ButtonStyle withRing(ButtonStyle? base) =>
      (base ?? const ButtonStyle()).copyWith(side: ring);
  return theme.copyWith(
    focusColor: theme.colorScheme.primary.withValues(alpha: 0.45),
    textButtonTheme: TextButtonThemeData(
      style: withRing(theme.textButtonTheme.style),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: withRing(theme.elevatedButtonTheme.style),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: withRing(theme.filledButtonTheme.style),
    ),
  );
}

ThemeData _applyIosThemeSettings(ThemeData theme) {
  if (Platform.isIOS) {
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
  return theme;
}

/// Provides the light theme for the app, recomputed only when
/// flex scheme colors, blend level, or font family change.
final lightThemeProvider = Provider<ThemeData>((ref) {
  final colors = ref.watch(flexSchemeColorStateProvider.select((t) => t.$1));
  final blendLevel = ref.watch(blendLevelStateProvider).toInt();
  final fontFamily = ref.watch(appFontFamilyProvider.select((t) => t.$2));

  return _applyIosThemeSettings(
    _tvFocus(
      FlexThemeData.light(
        colors: colors,
      surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
      blendLevel: blendLevel,
      appBarOpacity: 0.00,
                  subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        thinBorderWidth: 1.0,
        unselectedToggleIsColored: false,
        inputDecoratorRadius: 16.0,
        chipRadius: 16.0,
        cardRadius: 20.0,
        dialogRadius: 24.0,
        bottomSheetRadius: 24.0,
        appBarBackgroundSchemeColor: SchemeColor.surface,
        navigationBarBackgroundSchemeColor: SchemeColor.surface,
        navigationBarElevation: 0,
        navigationBarIndicatorOpacity: 0.15,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarBackgroundSchemeColor: SchemeColor.surface,
        cardElevation: 0,
        popupMenuRadius: 16.0,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      scaffoldBackground: const Color(0xFFFDFBFB),
      fontFamily: fontFamily,
    ),
  ));
});

/// Provides the dark theme for the app, recomputed only when
/// flex scheme colors, blend level, font family, or pure-black toggle change.
final darkThemeProvider = Provider<ThemeData>((ref) {
  final colors = ref.watch(flexSchemeColorStateProvider.select((t) => t.$1));
  final blendLevel = ref.watch(blendLevelStateProvider).toInt();
  final fontFamily = ref.watch(appFontFamilyProvider.select((t) => t.$2));
  final pureBlack = ref.watch(pureBlackDarkModeStateProvider);

  return _applyIosThemeSettings(
    _tvFocus(
      FlexThemeData.dark(
        colors: colors,
      surfaceMode: FlexSurfaceMode.level,
      // Pure black means pure black. The slider that sets this is hidden while
      // the toggle is on, but hiding a control does not stop it applying, so a
      // blend chosen beforehand went on tinting every surface that is not the
      // scaffold: cards, sheets, dialogs, the nav bar. The result was a black
      // page with visibly grey-blue things floating on it, and no way to
      // correct it without turning pure black back off.
      //
      // The stored level is left alone, so turning the toggle off restores
      // whatever blend was chosen.
      blendLevel: pureBlack ? 0 : blendLevel,
      appBarOpacity: 0.00,
      // The framework's own switch rather than painting the scaffold black by
      // hand: it takes the surfaces down with it, which is the half that was
      // missing.
      darkIsTrueBlack: pureBlack,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        thinBorderWidth: 2.0,
        unselectedToggleIsColored: true,
        inputDecoratorRadius: 24.0,
        chipRadius: 24.0,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      
      fontFamily: fontFamily,
    ),
  ));
});
