import 'package:flutter/material.dart' hide ThemeMode;
import 'package:glider_domain/glider_domain.dart';
import 'package:material_color_utilities/dynamiccolor/variant.dart';

const int settingsBackupSchemaVersion = 1;

class SettingsBackup {
  const SettingsBackup({
    this.version = settingsBackupSchemaVersion,
    this.favorites,
    this.settings,
    this.filters,
  });

  final int version;
  final List<int>? favorites;
  final SettingsBackupSettings? settings;
  final SettingsBackupFilters? filters;

  Map<String, dynamic> toJson() => {
        'version': version,
        if (favorites != null) 'favorites': favorites,
        if (settings != null) 'settings': settings!.toJson(),
        if (filters != null) 'filters': filters!.toJson(),
      };

  factory SettingsBackup.fromJson(Object? json) {
    if (json is List) {
      return SettingsBackup(
        favorites: json.map(_asInt).whereType<int>().toList(),
      );
    }

    if (json is! Map) {
      throw const FormatException('Backup must be a JSON object.');
    }

    final map = json.cast<String, dynamic>();
    final hasFavorites = map.containsKey('favorites');
    final hasSettings = map.containsKey('settings');
    final hasFilters = map.containsKey('filters');

    if (!hasFavorites && !hasSettings && !hasFilters) {
      throw const FormatException('Unrecognized backup file.');
    }

    if (hasFavorites && map['favorites'] is! List) {
      throw const FormatException('Favorites backup section must be an array.');
    }

    if (hasSettings && map['settings'] == null) {
      throw const FormatException('Settings backup section must be an object.');
    }

    if (hasFilters && map['filters'] == null) {
      throw const FormatException('Filters backup section must be an object.');
    }

    return SettingsBackup(
      version: _asInt(map['version']) ?? settingsBackupSchemaVersion,
      favorites: hasFavorites ? _asIntList(map['favorites']) : null,
      settings: hasSettings ? SettingsBackupSettings.fromJson(map['settings']) : null,
      filters: hasFilters ? SettingsBackupFilters.fromJson(map['filters']) : null,
    );
  }
}

class SettingsBackupSettings {
  const SettingsBackupSettings({
    this.themeMode,
    this.useDynamicTheme,
    this.themeColor,
    this.themeVariant,
    this.usePureBackground,
    this.font,
    this.storyLines,
    this.useLargeStoryStyle,
    this.showFavicons,
    this.showStoryMetadata,
    this.showUserAvatars,
    this.useActionButtons,
    this.showJobs,
    this.useThreadNavigation,
    this.enableDownvoting,
    this.useInAppBrowser,
    this.useNavigationDrawer,
  });

  final ThemeMode? themeMode;
  final bool? useDynamicTheme;
  final Color? themeColor;
  final Variant? themeVariant;
  final bool? usePureBackground;
  final String? font;
  final int? storyLines;
  final bool? useLargeStoryStyle;
  final bool? showFavicons;
  final bool? showStoryMetadata;
  final bool? showUserAvatars;
  final bool? useActionButtons;
  final bool? showJobs;
  final bool? useThreadNavigation;
  final bool? enableDownvoting;
  final bool? useInAppBrowser;
  final bool? useNavigationDrawer;

  Map<String, dynamic> toJson() => {
        if (themeMode != null) 'themeMode': themeMode!.name,
        if (useDynamicTheme != null) 'useDynamicTheme': useDynamicTheme,
        if (themeColor != null) 'themeColor': themeColor!.value,
        if (themeVariant != null) 'themeVariant': themeVariant!.name,
        if (usePureBackground != null) 'usePureBackground': usePureBackground,
        if (font != null) 'font': font,
        if (storyLines != null) 'storyLines': storyLines,
        if (useLargeStoryStyle != null) 'useLargeStoryStyle': useLargeStoryStyle,
        if (showFavicons != null) 'showFavicons': showFavicons,
        if (showStoryMetadata != null) 'showStoryMetadata': showStoryMetadata,
        if (showUserAvatars != null) 'showUserAvatars': showUserAvatars,
        if (useActionButtons != null) 'useActionButtons': useActionButtons,
        if (showJobs != null) 'showJobs': showJobs,
        if (useThreadNavigation != null) 'useThreadNavigation': useThreadNavigation,
        if (enableDownvoting != null) 'enableDownvoting': enableDownvoting,
        if (useInAppBrowser != null) 'useInAppBrowser': useInAppBrowser,
        if (useNavigationDrawer != null) 'useNavigationDrawer': useNavigationDrawer,
      };

  factory SettingsBackupSettings.fromJson(Object? json) {
    if (json == null) {
      return const SettingsBackupSettings();
    }

    if (json is! Map) {
      throw const FormatException('Settings backup section must be an object.');
    }

    final map = json.cast<String, dynamic>();
    return SettingsBackupSettings(
      themeMode: _parseThemeMode(map['themeMode']),
      useDynamicTheme: _asBool(map['useDynamicTheme']),
      themeColor: _asColor(map['themeColor']),
      themeVariant: _parseVariant(map['themeVariant']),
      usePureBackground: _asBool(map['usePureBackground']),
      font: _asString(map['font']),
      storyLines: _asInt(map['storyLines']),
      useLargeStoryStyle: _asBool(map['useLargeStoryStyle']),
      showFavicons: _asBool(map['showFavicons']),
      showStoryMetadata: _asBool(map['showStoryMetadata']),
      showUserAvatars: _asBool(map['showUserAvatars']),
      useActionButtons: _asBool(map['useActionButtons']),
      showJobs: _asBool(map['showJobs']),
      useThreadNavigation: _asBool(map['useThreadNavigation']),
      enableDownvoting: _asBool(map['enableDownvoting']),
      useInAppBrowser: _asBool(map['useInAppBrowser']),
      useNavigationDrawer: _asBool(map['useNavigationDrawer']),
    );
  }
}

class SettingsBackupFilters {
  const SettingsBackupFilters({
    this.wordFilters,
    this.domainFilters,
  });

  final List<String>? wordFilters;
  final List<String>? domainFilters;

  Map<String, dynamic> toJson() => {
        if (wordFilters != null) 'words': wordFilters,
        if (domainFilters != null) 'domains': domainFilters,
      };

  factory SettingsBackupFilters.fromJson(Object? json) {
    if (json == null) {
      return const SettingsBackupFilters();
    }

    if (json is! Map) {
      throw const FormatException('Filters backup section must be an object.');
    }

    final map = json.cast<String, dynamic>();
    return SettingsBackupFilters(
      wordFilters: _asStringList(map['words']) ?? _asStringList(map['wordFilters']),
      domainFilters:
          _asStringList(map['domains']) ?? _asStringList(map['domainFilters']),
    );
  }
}

int? _asInt(Object? value) => switch (value) {
      int() => value,
      num() => value.toInt(),
      String() => int.tryParse(value),
      _ => null,
    };

List<int>? _asIntList(Object? value) {
  if (value is! List) {
    return null;
  }

  return value.map(_asInt).whereType<int>().toList();
}

List<String>? _asStringList(Object? value) {
  if (value is! List) {
    return null;
  }

  return value.map(_asString).whereType<String>().toList();
}

String? _asString(Object? value) => switch (value) {
      String() => value,
      _ => null,
    };

bool? _asBool(Object? value) => switch (value) {
      bool() => value,
      _ => null,
    };

Color? _asColor(Object? value) {
  final colorValue = _asInt(value);
  return colorValue != null ? Color(colorValue) : null;
}

ThemeMode? _parseThemeMode(Object? value) {
  final modeName = _asString(value);
  if (modeName == null) {
    return null;
  }

  for (final mode in ThemeMode.values) {
    if (mode.name == modeName) {
      return mode;
    }
  }

  return null;
}

Variant? _parseVariant(Object? value) {
  final variantName = _asString(value);
  if (variantName == null) {
    return null;
  }

  for (final variant in Variant.values) {
    if (variant.name == variantName) {
      return variant;
    }
  }

  return null;
}
