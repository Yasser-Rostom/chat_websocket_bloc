import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../domain/repositories/websocket_repo.dart';
import '../event/chat_event.dart';
import '../state/chat_state.dart';


class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  final WebSocketRepository repository;

  WebSocketBloc({required this.repository}) : super(WebSocketNotConnected());

  @override
  Stream<WebSocketState> mapEventToState(WebSocketEvent event) async* {
    if (event is ConnectWebSocketEvent) {
      // Connect WebSocket logic
      yield WebSocketConnected();
    } else if (event is DisconnectWebSocketEvent) {
      // Disconnect WebSocket logic
      repository.dispose(); // Dispose the repository
      yield WebSocketNotConnected();
    } else if (event is SendMessageEvent) {
      // Send message logic
      repository.sendMessage(event.message);
    } else if (event is MessageReceivedEvent) {
      yield WebSocketMessageReceived(event.message);
    }
  }
}
