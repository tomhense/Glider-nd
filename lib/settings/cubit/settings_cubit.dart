import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cross_file/cross_file.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:glider/common/extensions/bloc_base_extension.dart';
import 'package:glider/settings/models/settings_backup.dart';
import 'package:glider_domain/glider_domain.dart';
import 'package:intl/intl.dart';
import 'package:material_color_utilities/dynamiccolor/variant.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:share_plus/share_plus.dart';

part 'settings_cubit_event.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>
    with BlocPresentationMixin<SettingsState, SettingsCubitEvent> {
  SettingsCubit(
    this._settingsRepository,
    this._packageRepository,
    this._itemInteractionRepository,
  ) : super(const SettingsState()) {
    unawaited(_load());
  }

  final SettingsRepository _settingsRepository;
  final PackageRepository _packageRepository;
  final ItemInteractionRepository _itemInteractionRepository;

  Future<void> _load() async {
    final themeMode = await _settingsRepository.getThemeMode();
    final useDynamicTheme = await _settingsRepository.getUseDynamicTheme();
    final themeColor = await _settingsRepository.getThemeColor();
    final themeVariant = await _settingsRepository.getThemeVariant();
    final usePureBackground = await _settingsRepository.getUsePureBackground();
    final font = await _settingsRepository.getFont();
    final storyLines = await _settingsRepository.getStoryLines();
    final useLargeStoryStyle =
        await _settingsRepository.getUseLargeStoryStyle();
    final showFavicons = await _settingsRepository.getShowFavicons();
    final showStoryMetadata = await _settingsRepository.getShowStoryMetadata();
    final showUserAvatars = await _settingsRepository.getShowUserAvatars();
    final useActionButtons = await _settingsRepository.getUseActionButtons();
    final showJobs = await _settingsRepository.getShowJobs();
    final useThreadNavigation =
        await _settingsRepository.getUseThreadNavigation();
    final enableDownvoting = await _settingsRepository.getEnableDownvoting();
    final useInAppBrowser = await _settingsRepository.getUseInAppBrowser();
    final useNavigationDrawer =
        await _settingsRepository.getUseNavigationDrawer();
    final wordFilters = await _settingsRepository.getWordFilters();
    final domainFilters = await _settingsRepository.getDomainFilters();
    safeEmit(
      state.copyWith(
        themeMode: themeMode != null ? () => themeMode : null,
        useDynamicTheme: useDynamicTheme != null ? () => useDynamicTheme : null,
        themeColor: themeColor != null ? () => themeColor : null,
        themeVariant: themeVariant != null ? () => themeVariant : null,
        usePureBackground:
            usePureBackground != null ? () => usePureBackground : null,
        font: font != null ? () => font : null,
        storyLines: storyLines != null ? () => storyLines : null,
        useLargeStoryStyle:
            useLargeStoryStyle != null ? () => useLargeStoryStyle : null,
        showFavicons: showFavicons != null ? () => showFavicons : null,
        showStoryMetadata:
            showStoryMetadata != null ? () => showStoryMetadata : null,
        showUserAvatars: showUserAvatars != null ? () => showUserAvatars : null,
        useActionButtons:
            useActionButtons != null ? () => useActionButtons : null,
        showJobs: showJobs != null ? () => showJobs : null,
        useThreadNavigation:
            useThreadNavigation != null ? () => useThreadNavigation : null,
        enableDownvoting:
            enableDownvoting != null ? () => enableDownvoting : null,
        useInAppBrowser: useInAppBrowser != null ? () => useInAppBrowser : null,
        useNavigationDrawer:
            useNavigationDrawer != null ? () => useNavigationDrawer : null,
        wordFilters: wordFilters != null ? () => wordFilters : null,
        domainFilters: domainFilters != null ? () => domainFilters : null,
        appVersion: _packageRepository.getVersion,
      ),
    );
  }

  Future<void> setUseLargeStoryStyle(bool value) async {
    await _settingsRepository.setUseLargeStoryStyle(value: value);
    final useLargeStoryStyle =
        await _settingsRepository.getUseLargeStoryStyle();

    if (useLargeStoryStyle != null) {
      safeEmit(
        state.copyWith(useLargeStoryStyle: () => useLargeStoryStyle),
      );
    }
  }

  Future<void> setThemeMode(ThemeMode value) async {
    await _settingsRepository.setThemeMode(value: value);
    final themeMode = await _settingsRepository.getThemeMode();

    if (themeMode != null) {
      safeEmit(
        state.copyWith(themeMode: () => themeMode),
      );
    }
  }

  Future<void> setUseDynamicTheme(bool value) async {
    await _settingsRepository.setUseDynamicTheme(value: value);
    final useDynamicTheme = await _settingsRepository.getUseDynamicTheme();

    if (useDynamicTheme != null) {
      safeEmit(
        state.copyWith(useDynamicTheme: () => useDynamicTheme),
      );
    }
  }

  Future<void> setThemeColor(Color value) async {
    await _settingsRepository.setThemeColor(value: value);
    final themeColor = await _settingsRepository.getThemeColor();

    if (themeColor != null) {
      safeEmit(
        state.copyWith(themeColor: () => themeColor),
      );
    }
  }

  Future<void> setThemeVariant(Variant value) async {
    await _settingsRepository.setThemeVariant(value: value);
    final themeVariant = await _settingsRepository.getThemeVariant();

    if (themeVariant != null) {
      safeEmit(
        state.copyWith(themeVariant: () => themeVariant),
      );
    }
  }

  Future<void> setUsePureBackground(bool value) async {
    await _settingsRepository.setUsePureBackground(value: value);
    final usePureBackground = await _settingsRepository.getUsePureBackground();

    if (usePureBackground != null) {
      safeEmit(
        state.copyWith(usePureBackground: () => usePureBackground),
      );
    }
  }

  Future<void> setStoryLines(int value) async {
    await _settingsRepository.setStoryLines(value: value);
    final storyLines = await _settingsRepository.getStoryLines();

    if (storyLines != null) {
      safeEmit(
        state.copyWith(storyLines: () => storyLines),
      );
    }
  }

  Future<void> setFont(String value) async {
    await _settingsRepository.setFont(value: value);
    final font = await _settingsRepository.getFont();

    if (font != null) {
      safeEmit(
        state.copyWith(font: () => font),
      );
    }
  }

  Future<void> setShowFavicons(bool value) async {
    await _settingsRepository.setShowFavicons(value: value);
    final showFavicons = await _settingsRepository.getShowFavicons();

    if (showFavicons != null) {
      safeEmit(
        state.copyWith(showFavicons: () => showFavicons),
      );
    }
  }

  Future<void> setShowStoryMetadata(bool value) async {
    await _settingsRepository.setShowStoryMetadata(value: value);
    final showStoryMetadata = await _settingsRepository.getShowStoryMetadata();

    if (showStoryMetadata != null) {
      safeEmit(
        state.copyWith(showStoryMetadata: () => showStoryMetadata),
      );
    }
  }

  Future<void> setShowUserAvatars(bool value) async {
    await _settingsRepository.setShowUserAvatars(value: value);
    final showUserAvatars = await _settingsRepository.getShowUserAvatars();

    if (showUserAvatars != null) {
      safeEmit(
        state.copyWith(showUserAvatars: () => showUserAvatars),
      );
    }
  }

  Future<void> setUseActionButtons(bool value) async {
    await _settingsRepository.setUseActionButtons(value: value);
    final useActionButtons = await _settingsRepository.getUseActionButtons();

    if (useActionButtons != null) {
      safeEmit(
        state.copyWith(useActionButtons: () => useActionButtons),
      );
    }
  }

  Future<void> setShowJobs(bool value) async {
    await _settingsRepository.setShowJobs(value: value);
    final showJobs = await _settingsRepository.getShowJobs();

    if (showJobs != null) {
      safeEmit(
        state.copyWith(showJobs: () => showJobs),
      );
    }
  }

  Future<void> setUseThreadNavigation(bool value) async {
    await _settingsRepository.setUseThreadNavigation(value: value);
    final useThreadNavigation =
        await _settingsRepository.getUseThreadNavigation();

    if (useThreadNavigation != null) {
      safeEmit(
        state.copyWith(useThreadNavigation: () => useThreadNavigation),
      );
    }
  }

  Future<void> setEnableDownvoting(bool value) async {
    await _settingsRepository.setEnableDownvoting(value: value);
    final enableDownvoting = await _settingsRepository.getEnableDownvoting();

    if (enableDownvoting != null) {
      safeEmit(
        state.copyWith(enableDownvoting: () => enableDownvoting),
      );
    }
  }

  Future<void> setUseInAppBrowser(bool value) async {
    await _settingsRepository.setUseInAppBrowser(value: value);
    final useInAppBrowser = await _settingsRepository.getUseInAppBrowser();

    if (useInAppBrowser != null) {
      safeEmit(
        state.copyWith(useInAppBrowser: () => useInAppBrowser),
      );
    }
  }

  Future<void> setUseNavigationDrawer(bool value) async {
    await _settingsRepository.setUseNavigationDrawer(value: value);
    final useNavigationDrawer =
        await _settingsRepository.getUseNavigationDrawer();

    if (useNavigationDrawer != null) {
      safeEmit(
        state.copyWith(useNavigationDrawer: () => useNavigationDrawer),
      );
    }
  }

  Future<void> setWordFilter(String value, {required bool filter}) async {
    await _settingsRepository.setWordFilter(value: value, filter: filter);
    final wordFilters = await _settingsRepository.getWordFilters();

    if (wordFilters != null) {
      safeEmit(
        state.copyWith(wordFilters: () => wordFilters),
      );
    }
  }

  Future<void> setDomainFilter(String value, {required bool filter}) async {
    await _settingsRepository.setDomainFilter(value: value, filter: filter);
    final domainFilters = await _settingsRepository.getDomainFilters();

    if (domainFilters != null) {
      safeEmit(
        state.copyWith(domainFilters: () => domainFilters),
      );
    }
  }

  Future<void> exportBackup() async {
    try {
      final backup = SettingsBackup(
        favorites: await _itemInteractionRepository.getFavoritedIds(),
        settings: SettingsBackupSettings(
          themeMode: state.themeMode,
          useDynamicTheme: state.useDynamicTheme,
          themeColor: state.themeColor,
          themeVariant: state.themeVariant,
          usePureBackground: state.usePureBackground,
          font: state.font,
          storyLines: state.storyLines,
          useLargeStoryStyle: state.useLargeStoryStyle,
          showFavicons: state.showFavicons,
          showStoryMetadata: state.showStoryMetadata,
          showUserAvatars: state.showUserAvatars,
          useActionButtons: state.useActionButtons,
          showJobs: state.showJobs,
          useThreadNavigation: state.useThreadNavigation,
          enableDownvoting: state.enableDownvoting,
          useInAppBrowser: state.useInAppBrowser,
          useNavigationDrawer: state.useNavigationDrawer,
        ),
        filters: SettingsBackupFilters(
          wordFilters: state.wordFilters.toList()..sort(),
          domainFilters: state.domainFilters.toList()..sort(),
        ),
      );
      final backupJson =
          const JsonEncoder.withIndent('  ').convert(backup.toJson());
      final backupFileName = 'glider-backup-'
          '${DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now())}.json';

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              utf8.encode(backupJson),
              name: backupFileName,
              mimeType: 'application/json',
            ),
          ],
          fileNameOverrides: [backupFileName],
          subject: 'Glider backup',
        ),
      );
    } on Object {
      emitPresentation(const SettingsActionFailedEvent());
    }
  }

  Future<void> importBackup() async {
    try {
      if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
        emitPresentation(const SettingsActionFailedEvent());
        return;
      }

      final backupBytes =
          await const MethodChannel('nl.viter.glider/backup_picker')
              .invokeMethod<Uint8List?>('pickBackupFile');

      if (backupBytes == null) {
        return;
      }

      final backup = SettingsBackup.fromJson(
        jsonDecode(utf8.decode(backupBytes)),
      );

      final settings = backup.settings;
      if (settings != null) {
        if (settings.themeMode != null) {
          await _settingsRepository.setThemeMode(value: settings.themeMode!);
        }
        if (settings.useDynamicTheme != null) {
          await _settingsRepository.setUseDynamicTheme(
            value: settings.useDynamicTheme!,
          );
        }
        if (settings.themeColor != null) {
          await _settingsRepository.setThemeColor(value: settings.themeColor!);
        }
        if (settings.themeVariant != null) {
          await _settingsRepository.setThemeVariant(
            value: settings.themeVariant!,
          );
        }
        if (settings.usePureBackground != null) {
          await _settingsRepository.setUsePureBackground(
            value: settings.usePureBackground!,
          );
        }
        if (settings.font != null) {
          await _settingsRepository.setFont(value: settings.font!);
        }
        if (settings.storyLines != null) {
          await _settingsRepository.setStoryLines(value: settings.storyLines!);
        }
        if (settings.useLargeStoryStyle != null) {
          await _settingsRepository.setUseLargeStoryStyle(
            value: settings.useLargeStoryStyle!,
          );
        }
        if (settings.showFavicons != null) {
          await _settingsRepository.setShowFavicons(
            value: settings.showFavicons!,
          );
        }
        if (settings.showStoryMetadata != null) {
          await _settingsRepository.setShowStoryMetadata(
            value: settings.showStoryMetadata!,
          );
        }
        if (settings.showUserAvatars != null) {
          await _settingsRepository.setShowUserAvatars(
            value: settings.showUserAvatars!,
          );
        }
        if (settings.useActionButtons != null) {
          await _settingsRepository.setUseActionButtons(
            value: settings.useActionButtons!,
          );
        }
        if (settings.showJobs != null) {
          await _settingsRepository.setShowJobs(value: settings.showJobs!);
        }
        if (settings.useThreadNavigation != null) {
          await _settingsRepository.setUseThreadNavigation(
            value: settings.useThreadNavigation!,
          );
        }
        if (settings.enableDownvoting != null) {
          await _settingsRepository.setEnableDownvoting(
            value: settings.enableDownvoting!,
          );
        }
        if (settings.useInAppBrowser != null) {
          await _settingsRepository.setUseInAppBrowser(
            value: settings.useInAppBrowser!,
          );
        }
        if (settings.useNavigationDrawer != null) {
          await _settingsRepository.setUseNavigationDrawer(
            value: settings.useNavigationDrawer!,
          );
        }
      }

      final filters = backup.filters;
      if (filters != null) {
        if (filters.wordFilters != null) {
          await _settingsRepository.setWordFilters(
            values: filters.wordFilters!,
          );
        }
        if (filters.domainFilters != null) {
          await _settingsRepository.setDomainFilters(
            values: filters.domainFilters!,
          );
        }
      }

      if (backup.favorites != null) {
        final success = await _itemInteractionRepository.setFavoritedIds(
          backup.favorites!,
        );
        if (!success) {
          emitPresentation(const SettingsActionFailedEvent());
          return;
        }
      }

      await _load();
    } on FormatException {
      emitPresentation(const SettingsActionFailedEvent());
    } on PlatformException {
      emitPresentation(const SettingsActionFailedEvent());
    } on Object {
      emitPresentation(const SettingsActionFailedEvent());
    }
  }

  Future<void> clearVisited() async {
    final success = await _itemInteractionRepository.clearVisited();

    if (!success) {
      emitPresentation(const SettingsActionFailedEvent());
    }
  }
}
