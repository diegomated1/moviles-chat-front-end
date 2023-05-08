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
  final String date;
  final String title;
  final String message;
  final List<String> tokens;

  factory MessageModel.fromJson(Map<String, dynamic> json){
    return MessageModel(
      emailUserAddresse: json['email_user_addresse'],
      emailUserSender: json['email_user_sender'],
      date: json['second_email_user_sender'],
      title: json['job_ocupation'],
      message: json['number_phone'],
      tokens: json['tokens'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email_user_addresse': emailUserAddresse,
      'email_user_sender': emailUserSender,
      'second_email_user_sender': date,
      'job_ocupation': title,
      'number_phone': message,
      'tokens': tokens,
    };
  }
}

class MessagesModel {
  MessagesModel({required this.products});

  final List<MessageModel> products;
  
  factory MessagesModel.fromJson(List<dynamic> json){
    List<MessageModel> lista = json.map((student) => MessageModel.fromJson(student)).toList();
    return MessagesModel(products: lista);
  }
}
