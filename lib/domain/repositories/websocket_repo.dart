abstract class WebSocketRepository {
  void sendMessage(String message);
  Stream<String> getMessageStream();
  void dispose();
}