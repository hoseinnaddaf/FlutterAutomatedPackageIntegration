import 'dart:io';
import 'package:flutter/material.dart';
import '../constants/strings.dart';
import 'platform_config.dart';

class FileUtils {
  static bool isValidFlutterProject(String path) {
    final pubspecFile = File('$path/pubspec.yaml');
    return pubspecFile.existsSync();
  }

  static Future<void> addPackageToPubspec(
      String projectPath,
      Function(String) appendLogMessage,
      BuildContext context,
      Function(bool) setProcessing,
      ) async {
    final pubspecFile = File('$projectPath/pubspec.yaml');

    if (await pubspecFile.exists()) {
      String content = await pubspecFile.readAsString();

      if (!content.contains('google_maps_flutter')) {
        final lines = content.split('\n');
        final dependenciesIndex = lines.indexWhere((line) => line.trim() == 'dependencies:');

        if (dependenciesIndex != -1) {
          lines.insert(dependenciesIndex + 1, '  google_maps_flutter: ^2.3.0');
          final updatedContent = lines.join('\n');
          await pubspecFile.writeAsString(updatedContent);
          appendLogMessage(Strings.packageAdded);
        } else {
          appendLogMessage(Strings.noDependenciesSection);
        }
      } else {
        appendLogMessage(Strings.packageAlreadyExists);
      }

      appendLogMessage(Strings.flutterPubGetRunning);

      try {

        final flutterCommand = Platform.isWindows ?  'flutter.bat' : 'flutter' ;

        final result = await Process.run(
          flutterCommand ,
          ['pub', 'get'],
          workingDirectory: Directory(projectPath).path,
        );

        if (result.exitCode == 0) {
          appendLogMessage(Strings.packageIntegrated);
          appendLogMessage(Strings.apiKeyRequest);

          final apiKey = await promptForApiKey(context);
          if (apiKey != null && apiKey.isNotEmpty) {
            appendLogMessage(Strings.apiKeyProvided);
            await PlatformConfig.configurePlatformSpecificSettings(
                projectPath, apiKey, appendLogMessage);
            await addExampleWidget(projectPath, appendLogMessage);
          } else {
            appendLogMessage(Strings.noApiKeyProvided);
          }
        }
        else {
          appendLogMessage('${Strings.errorTitle}: ${result.stderr}');
        }
      }
      catch(e)
    {
      appendLogMessage('Exception Error : ${e.toString()}') ;
    }

    } else {
      appendLogMessage(Strings.pubspecNotFound);
    }
    setProcessing(false);
  }

  static Future<String?> promptForApiKey(BuildContext context) async {
    TextEditingController apiKeyController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(Strings.apiKeyDialogTitle),
          content: TextField(
            controller: apiKeyController,
            decoration: const InputDecoration(
              labelText: Strings.apiKeyDialogPrompt,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text(Strings.cancelButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, apiKeyController.text),
              child: const Text(Strings.saveButton),
            ),
          ],
        );
      },
    );
  }

  static Future<void> addExampleWidget(String projectPath, Function(String) appendLogMessage) async {
    final mainFile = File('$projectPath/lib/main.dart');

    if (await mainFile.exists()) {
      const exampleWidget = Strings.exampleWidget;
      await mainFile.writeAsString(exampleWidget);
      appendLogMessage(Strings.integrationComplete);
    } else {
      appendLogMessage(Strings.mainDartNotFound);
    }
  }
}