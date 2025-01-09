import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../utils/file_utils.dart';
import '../constants/strings.dart';

class ProjectProvider extends ChangeNotifier {
  String? _selectedPath;
  String _logMessages = '';
  bool _isProcessing = false;

  String? get selectedPath => _selectedPath;
  String get logMessages => _logMessages;
  bool get isProcessing => _isProcessing;

  void appendLogMessage(String message) {
    _logMessages += '$message\n';
    notifyListeners();
  }

  void clearState() {
    _selectedPath = null;
    _logMessages = '';
    notifyListeners();
  }

  void setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  Future<void> pickProjectDirectory(BuildContext context) async {
    setProcessing(true);

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      if (FileUtils.isValidFlutterProject(selectedDirectory)) {
        _selectedPath = selectedDirectory;
        _logMessages = '';
        appendLogMessage("${Strings.pathSelected}: $_selectedPath");
        await FileUtils.addPackageToPubspec(
          selectedDirectory,
          appendLogMessage,
          context,
          setProcessing,

        );
      } else {
        _selectedPath = null;
        setProcessing(false);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(Strings.errorTitle),
            content: const Text(Strings.invalidProjectError),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(Strings.okButton),
              ),
            ],
          ),
        );
      }
    } else {
      setProcessing(false);
    }
  }
}
