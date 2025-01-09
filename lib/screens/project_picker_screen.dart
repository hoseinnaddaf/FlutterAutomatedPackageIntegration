import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import '../widgets/log_messages_widget.dart';

class ProjectPickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Manager Tool'),
      ),
      body: Consumer<ProjectProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  'Select and Configure Flutter Project',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Project Path',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        controller: TextEditingController(text: provider.selectedPath),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      icon: Icon(Icons.folder),
                      label: Text('Select'),
                      onPressed: () => provider.pickProjectDirectory(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (provider.selectedPath != null)
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Selected Project Path: ${provider.selectedPath}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                SizedBox(height: 20),

                LogMessagesWidget(messages: provider.logMessages),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: provider.clearState,
                      child: Text('Clear'),
                    ),
                  ],
                ),
                if (provider.isProcessing)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}