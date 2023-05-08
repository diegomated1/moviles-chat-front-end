class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.secondName,
    required this.jobOcupation,
    required this.numberPhone,
    required this.password,
  });
  
  final String email;
  final String name;
  final String secondName;
  final String jobOcupation;
  final String numberPhone;
  final String password;

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      email: json['email'],
      name: json['name'],
      secondName: json['second_name'],
      jobOcupation: json['job_ocupation'],
      numberPhone: json['number_phone'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'second_name': secondName,
      'job_ocupation': jobOcupation,
      'number_phone': numberPhone,
      'password': password,
    };
  }
}

class UsersModel {
  UsersModel({required this.products});

  final List<UserModel> products;
  
  factory UsersModel.fromJson(List<dynamic> json){
    List<UserModel> lista = json.map((student) => UserModel.fromJson(student)).toList();
    return UsersModel(products: lista);
  }
}
