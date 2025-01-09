// lib/utils/platform_config.dart
import 'dart:io';
import '../constants/strings.dart';

class PlatformConfig {
  static Future<void> configurePlatformSpecificSettings(
      String projectPath,
      String apiKey,
      Function(String) appendLogMessage,
      ) async {
    await _configureAndroid(projectPath, apiKey, appendLogMessage);
    await _configureIOS(projectPath, apiKey, appendLogMessage);
  }

  static Future<void> _configureAndroid(
      String projectPath,
      String apiKey,
      Function(String) appendLogMessage,
      ) async {
    final androidManifestFile = File('$projectPath/android/app/src/main/AndroidManifest.xml');

    if (await androidManifestFile.exists()) {
      String content = await androidManifestFile.readAsString();

      if (!content.contains('com.google.android.geo.API_KEY')) {
        final applicationTagIndex = content.indexOf('<application');
        if (applicationTagIndex != -1) {
          final insertIndex = content.indexOf('>', applicationTagIndex) + 1;
          final apiKeyMetaTag = '''
            <meta-data
                android:name="com.google.android.geo.API_KEY"
                android:value="$apiKey" />
          ''';

          content = content.substring(0, insertIndex) + apiKeyMetaTag + content.substring(insertIndex);
          await androidManifestFile.writeAsString(content);
          appendLogMessage(Strings.manifestAdded);
        } else {
          appendLogMessage(Strings.manifestApplicationTagError);
        }
      } else {
        appendLogMessage(Strings.manifestHasKey);
      }
    } else {
      appendLogMessage(Strings.manifestNotFound);
    }
  }

  static Future<void> _configureIOS(
      String projectPath,
      String apiKey,
      Function(String) appendLogMessage,
      ) async {
    final infoPlistFile = File('$projectPath/ios/Runner/Info.plist');

    if (await infoPlistFile.exists()) {
      String content = await infoPlistFile.readAsString();

      // Add Google Maps API Key
      if (!content.contains('GMSApiKey')) {
        final gmsKeyString = '''
        <key>GMSApiKey</key>
        <string>$apiKey</string>
        ''';

        final dictCloseIndex = content.lastIndexOf('</dict>');
        if (dictCloseIndex != -1) {
          content = content.substring(0, dictCloseIndex) + gmsKeyString + content.substring(dictCloseIndex);
        } else {
          appendLogMessage('</dict> tag not found in Info.plist.');
          return;
        }
      } else {
        appendLogMessage('GMSApiKey already exists in Info.plist.');
      }

      // Add Location Usage Description
      if (!content.contains('NSLocationWhenInUseUsageDescription')) {
        final locationUsageStrings = Strings.ios_info_permission;
        final dictCloseIndex = content.lastIndexOf('</dict>');
        if (dictCloseIndex != -1) {
          content = content.substring(0, dictCloseIndex) + locationUsageStrings + content.substring(dictCloseIndex);
        } else {
          appendLogMessage(Strings.ios_info_dictNotFound);
          return;
        }
      } else {
        appendLogMessage(Strings.ios_info_locationExist);
      }

      // Save updated Info.plist
      await infoPlistFile.writeAsString(content);
      appendLogMessage(Strings.ios_info_updatePermissions);

      // Configure AppDelegate.swift
      final appDelegateFile = File('$projectPath/ios/Runner/AppDelegate.swift');
      if (await appDelegateFile.exists()) {
        String appDelegateContent = await appDelegateFile.readAsString();

        // Add Google Maps import
        if (!appDelegateContent.contains('import GoogleMaps')) {
          appDelegateContent = 'import GoogleMaps\n' + appDelegateContent;
        } else {
          appendLogMessage(Strings.ios_appDelegate_hasGoogleMap);
        }

        // Add API key initialization
        if (!appDelegateContent.contains('GMSServices.provideAPIKey')) {
          final didFinishLaunchingIndex = appDelegateContent.indexOf('didFinishLaunchingWithOptions');
          if (didFinishLaunchingIndex != -1) {
            final insertionPoint = appDelegateContent.indexOf('{', didFinishLaunchingIndex) + 1;
            appDelegateContent = appDelegateContent.substring(0, insertionPoint) +
                '\n    GMSServices.provideAPIKey("$apiKey");\n' +
                appDelegateContent.substring(insertionPoint);
          } else {
            appendLogMessage(Strings.ios_appDelegate_didFinishNotFound);
            return;
          }
        } else {
          appendLogMessage(Strings.ios_appDelegate_hasApiKey);
        }

        // Save updated AppDelegate.swift
        await appDelegateFile.writeAsString(appDelegateContent);
        appendLogMessage(Strings.ios_appDelegate_updateDetails);
      } else {
        appendLogMessage(Strings.ios_appDelegate_notFound);
      }
    } else {
      appendLogMessage(Strings.ios_info_plistNotFound);
    }
  }
}