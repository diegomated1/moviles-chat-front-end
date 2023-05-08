import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketConnection{

  Socket socket = io(dotenv.env['CHAT_SERVER_URL']!);

  SocketConnection(){
    socket.connect();
  }

  sendMessage({
    required String emailUserAddresse,
		required String emailUserSender,
		required String title,
		required String message	
  }){
    socket.emit('chat:message', {emailUserAddresse, emailUserSender, title, message});
  }

}
