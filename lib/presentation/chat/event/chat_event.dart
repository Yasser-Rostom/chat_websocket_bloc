
import 'package:equatable/equatable.dart';

abstract class WebSocketEvent extends Equatable {
  const WebSocketEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends WebSocketEvent {
  final String message;

  const SendMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectWebSocketEvent extends WebSocketEvent {}

class DisconnectWebSocketEvent extends WebSocketEvent {}

class MessageReceivedEvent extends WebSocketEvent {
  final String message;

  const MessageReceivedEvent(this.message);

  @override
  List<Object> get props => [message];
}
