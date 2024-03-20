import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/chat_bloc.dart';
import '../event/chat_event.dart';
import '../state/chat_state.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: BlocBuilder<WebSocketBloc, WebSocketState>(
        builder: (context, state) {
          if (state is WebSocketNotConnected) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WebSocketConnected || state is WebSocketMessageReceived) {
            return ChatScreen();
          } else {
            return const Center(
              child: Text('Error connecting to WebSocket'),
            );
          }
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final WebSocketBloc webSocketBloc = BlocProvider.of<WebSocketBloc>(context);

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<WebSocketBloc, WebSocketState>(
            builder: (context, state) {
              if (state is WebSocketConnected || state is WebSocketMessageReceived) {
                return ListView.builder(
                  reverse: true,
                  itemCount: state is WebSocketConnected
                      ? 0
                      : (state as WebSocketMessageReceived).message.length,
                  itemBuilder: (context, index) {
                    final message = (state as WebSocketMessageReceived).message[index];
                    return ListTile(
                      title: Text(message),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Error occurred while fetching messages.'),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              SizedBox(width: 8),
              FloatingActionButton(
                onPressed: () {
                  final message = _controller.text;
                  if (message.isNotEmpty) {
                    webSocketBloc.add(SendMessageEvent(message));
                    _controller.clear();
                  }
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
