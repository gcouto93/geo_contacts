
const String tableRegister = 'table_register';

class RegisterFields {
  static const String id = "id";
  static const String nome = "nome";
  static const String email = "email";
  static const String senha = "senha";

}

class RegisterModel {
  int? id;
  String? nome;
  String? email;
  String? senha;

  RegisterModel({
    this.id,
    this.nome,
    this.email,
    this.senha
  });

  RegisterModel.fromJson(Map<String?, dynamic> json) {
    id = json[RegisterFields.id] as int;
    nome = json[RegisterFields.nome] as String;
    email = json[RegisterFields.email] as String;
    senha = json[RegisterFields.senha] as String;
  }

  Map<String, Object?> toJson() => {
    RegisterFields.id: id,
    RegisterFields.nome: nome,
    RegisterFields.email: email,
    RegisterFields.senha: senha,
  };

}