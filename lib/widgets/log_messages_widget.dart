
import 'package:flutter/material.dart';


class LogMessagesWidget extends StatefulWidget {
  final String messages;

  const LogMessagesWidget({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  State<LogMessagesWidget> createState() => _LogMessagesWidgetState();
}

class _LogMessagesWidgetState extends State<LogMessagesWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(LogMessagesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages != oldWidget.messages) {

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 300,
          minHeight: 100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.terminal, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Logs',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.messages.split('\n').length,
                  itemBuilder: (context, index) {
                    final line = widget.messages.split('\n')[index];
                    if (line.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '→',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              line,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}