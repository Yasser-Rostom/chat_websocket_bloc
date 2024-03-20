
import 'package:equatable/equatable.dart';

abstract class WebSocketState extends Equatable {
  const WebSocketState();

  @override
  List<Object> get props => [];
}

class WebSocketInitial extends WebSocketState {}
class WebSocketNotConnected extends WebSocketState {}

class WebSocketConnected extends WebSocketState {}

class WebSocketMessageReceived extends WebSocketState {
  final String message;

  const WebSocketMessageReceived(this.message);

  @override
  List<Object> get props => [message];
}
