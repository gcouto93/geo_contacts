import 'package:geo_contacts/models/response_consulta_cep.dart';

const String tableContact = 'contacts_table';

class ContactModelFields {
  static const String nome = 'nome';
  static const String cpf = 'cpf';
  static const String telefone = 'telefone';
  static const String uf = 'uf';
  static const String cidade = 'cidade';
  static const String rua = 'rua';
  static const String numero = 'numero';
  static const String cep = 'cep';
  static const String usuarioCriador = 'usuarioCriador';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
}

class ContactModel {
  String? nome;
  String? cpf;
  String? telefone;
  String? uf;
  String? cidade;
  String? rua;
  String? numero;
  String? cep;
  String? usuarioCriador;
  String? latitude;
  String? longitude;

  ContactModel({
    this.nome,
    this.cpf,
    this.telefone,
    this.uf,
    this.cidade,
    this.rua,
    this.numero,
    this.cep,
    this.usuarioCriador,
    this.latitude,
    this.longitude});



  ContactModel.fromJson(Map<String?, dynamic> json) {
    nome = json[ContactModelFields.nome];
    cpf = json[ContactModelFields.cpf];
    telefone = json[ContactModelFields.telefone];
    uf = json[ContactModelFields.uf];
    cidade = json[ContactModelFields.cidade];
    cidade = json[ContactModelFields.cidade];
    rua = json[ContactModelFields.rua];
    numero = json[ContactModelFields.numero];
    cep = json[ContactModelFields.cep];
    usuarioCriador = json[ContactModelFields.usuarioCriador];
    latitude = json[ContactModelFields.latitude];
    longitude = json[ContactModelFields.longitude];
  }

  Map<String, Object?> toJson() => {
    ContactModelFields.nome: nome,
    ContactModelFields.cpf: cpf,
    ContactModelFields.telefone: telefone,
    ContactModelFields.uf: uf,
    ContactModelFields.cidade: cidade,
    ContactModelFields.rua: rua,
    ContactModelFields.numero: numero,
    ContactModelFields.cep: cep,
    ContactModelFields.usuarioCriador: usuarioCriador,
    ContactModelFields.latitude: latitude,
    ContactModelFields.longitude: longitude,
  };




}