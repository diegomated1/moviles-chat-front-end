class MessageModel {
  MessageModel({
    required this.emailUserAddresse,
    required this.emailUserSender,
    required this.date,
    required this.title,
    required this.message,
    required this.tokens,
  });
  
  final String emailUserAddresse;
  final String emailUserSender;
  final DateTime date;
  final String title;
  final String message;
  final List<dynamic> tokens;

  factory MessageModel.fromJson(Map<String, dynamic> json){
    List<dynamic>? tokensAny = json['tokens'];
    List<String> tokens;
    if(tokensAny!=null){
      tokens = tokensAny.map((t)=>t.toString()).toList();
    }else{
      tokens = [];
    }
    return MessageModel(
      emailUserAddresse: json['email_user_addresse'],
      emailUserSender: json['email_user_sender'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      message: json['message'],
      tokens: tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email_user_addresse': emailUserAddresse,
      'email_user_sender': emailUserSender,
      'date': date,
      'title': title,
      'message': message,
      'tokens': tokens,
    };
  }
}

class MessagesModel {
  MessagesModel({required this.messages});

  final List<MessageModel> messages;
  
  factory MessagesModel.fromJson(List<dynamic> json){
    List<MessageModel> lista = json.map((student) => MessageModel.fromJson(student)).toList();
    return MessagesModel(messages: lista);
  }
}
