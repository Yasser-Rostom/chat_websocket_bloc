import 'dart:async';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/repositories/websocket_repo.dart';

class WebSocketRepositoryImpl implements WebSocketRepository {
  final WebSocketChannel channel;

  WebSocketRepositoryImpl(this.channel);

  @override
  void sendMessage(String message) {
    channel.sink.add(message);
  }

  @override
  Stream<String> getMessageStream() {
    return channel.stream.cast<String>();
  }

  @override
  void dispose() {
    channel.sink.close();
  }
}
