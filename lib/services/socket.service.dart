import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConnection{

  IO.Socket? socket;

  SocketConnection(String user1, String user2){
    var users = [user1, user2];
    users.sort();

    socket = IO.io(dotenv.env['CHAT_SOCKET_URL']!, <String, dynamic>{
      "transports": ["websocket"],
      "path": "/apichats/",
      "query": {"id_chat": users.join("")}
    });
    socket!.onConnect((_) {
      socket!.emit('msg', 'test');
    });
  }

  sendMessage({
    required String emailUserAddresse,
		required String emailUserSender,
		required String title,
		required String message	
  }){
    socket!.emit('chat:message', {emailUserAddresse, emailUserSender, title, message});
  }

}
