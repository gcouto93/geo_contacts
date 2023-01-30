class ResponseConsultaCepFields {
  static const String cep = 'cep';
  static const String logradouro = 'logradouro';
  static const String complemento = 'complemento';
  static const String bairro = 'bairro';
  static const String uf = 'uf';
  static const String localidade = 'localidade';
}

class ResponseConsultaCep {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? uf;
  String? localidade;

  ResponseConsultaCep.fromJson(Map<String, dynamic> json) {
    cep = json[ResponseConsultaCepFields.cep];
    logradouro = json[ResponseConsultaCepFields.logradouro];
    complemento = json[ResponseConsultaCepFields.complemento];
    bairro = json[ResponseConsultaCepFields.bairro];
    uf = json[ResponseConsultaCepFields.uf];
    localidade = json[ResponseConsultaCepFields.localidade];
  }

}