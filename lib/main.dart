import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manager_tool/providers/project_provider.dart';
import 'package:manager_tool/screens/project_picker_screen.dart';
import 'package:provider/provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized() ;
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProjectProvider(),
      child: MaterialApp(
        title: 'Flutter Manager Tool',
        debugShowCheckedModeBanner: false ,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProjectPickerScreen(),
      ),
    );
  }
}


