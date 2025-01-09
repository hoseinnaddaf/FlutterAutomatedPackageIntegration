class Strings {

  static const String appTitle = 'Flutter Manager Tool';
  static const String projectPickerTitle = 'Select and Configure Flutter Project';


  static const String projectPathLabel = 'Project Path';
  static const String selectButton = 'Select';
  static const String clearButton = 'Clear';
  static const String saveButton = 'Save';
  static const String cancelButton = 'Cancel';
  static const String okButton = 'Ok';


  static const String errorTitle = 'Error';
  static const String invalidProjectError = 'This path is not a valid Flutter project.';
  static const String apiKeyDialogTitle = 'Google Maps API Key';
  static const String apiKeyDialogPrompt = 'Enter your API Key';


  static const String pathSelected = 'Selected Path: ';
  static const String pubspecNotFound = 'pubspec.yaml not found!';
  static const String packageAdded = 'google_maps_flutter added successfully under dependencies.';
  static const String packageAlreadyExists = 'google_maps_flutter is already included in pubspec.yaml.';
  static const String noDependenciesSection = 'No dependencies section found in pubspec.yaml.';
  static const String flutterPubGetRunning = 'Running flutter pub get. Please wait a few seconds.';
  static const String packageIntegrated = 'Package integrated successfully!';
  static const String apiKeyRequest= 'Enter API Key .';
  static const String apiKeyProvided = 'API Key provided.';
  static const String noApiKeyProvided = 'No API Key provided.';
  static const String androidManifestNotFound = 'AndroidManifest.xml not found!';
  static const String infoPlistNotFound = 'Info.plist not found!';
  static const String mainDartNotFound = 'main.dart not found!';
  static const String logClearMessage = 'Logs cleared.';

  static const String manifestAdded = 'API Key added to AndroidManifest.xml.';
  static const String manifestApplicationTagError = '<application> tag not found in AndroidManifest.xml.';
  static const String manifestHasKey = 'API Key already exists in AndroidManifest.xml.';
  static const String manifestNotFound = 'AndroidManifest.xml not found!';


  static const String ios_info_permission ='''

      <key>NSLocationWhenInUseUsageDescription</key>
      <string>This app needs access to your location to show it on the map.</string>
      <key>NSLocationAlwaysUsageDescription</key>
      <string>This app needs access to your location to show it on the map.</string>
        
''' ;

  static const String ios_info_plistNotFound = 'Info.plist not found!';
  static const String ios_info_dictNotFound = '</dict> tag not found in Info.plist.';
  static const String ios_info_locationExist = 'Location usage descriptions already exist in Info.plist.';
  static const String ios_info_updatePermissions = 'Updated Info.plist with API Key and location usage descriptions.';

  static const String ios_appDelegate_hasGoogleMap = 'GoogleMaps is already imported in AppDelegate.swift.';
  static const String ios_appDelegate_didFinishNotFound = 'didFinishLaunchingWithOptions not found in AppDelegate.swift.';
  static const String ios_appDelegate_hasApiKey = 'GMSServices.provideAPIKey is already configured in AppDelegate.swift.';
  static const String ios_appDelegate_updateDetails = 'Updated AppDelegate.swift with Google Maps API Key setup.';
  static const String ios_appDelegate_notFound = 'AppDelegate.swift not found!';




  static const String googleMapsExampleTitle = 'Google Maps Example';
  static const String googleMapsExampleSubtitle = 'This app needs access to your location to show it on the map.';

  static const String  exampleWidget = '''
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Scaffold(
    appBar: AppBar(
      title: const Text('Google Maps Example'),
    ),
    body: const GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(34.343044, 62.199074),
        zoom: 10,
      ),
    ),
  ),
);
}
}
''';


  static const String integrationComplete = '''
🎉 Google Maps Integration Complete!

✅ Package added successfully
✅ Platforms configured
✅ Example code added

Your project is ready! You can now:
1. Open the project in your IDE
2. Run 'flutter pub get' if needed
3. Start the app with 'flutter run'

The example map widget has been added to your main.dart file.
''';


}