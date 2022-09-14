class PostModel {
  Data? data;

  PostModel({this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Oleos>? oleos;

  Data({this.oleos});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['oleos'] != null) {
      oleos = <Oleos>[];
      json['oleos'].forEach((v) {
        oleos!.add(Oleos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (oleos != null) {
      data['oleos'] = oleos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Oleos {
  int? id;
  int? tamanho;
  String? preco;
  String? nome;
  String? image;
  String? nomeCientifico;
  String? descricao;
  String? beneficioPrimario;
  String? comoUsar;

  Oleos(
      {required this.id,
      required this.preco,
      required this.tamanho,
      required this.nome,
      required this.nomeCientifico,
      required this.descricao,
      required this.beneficioPrimario,
      required this.comoUsar});

  Oleos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    preco = json['preco'];
    tamanho = json['tamanho'];
    nome = json['nome'];
    image = json['image'];
    nomeCientifico = json['nomeCientifico'];
    descricao = json['descricao'];
    beneficioPrimario = json['beneficioPrimario'];
    comoUsar = json['comoUsar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['preco'] = preco;
    data['tamanho'] = tamanho;
    data['nome'] = nome;
    data['image'] = image;
    data['nomeCientifico'] = nomeCientifico;
    data['descricao'] = descricao;
    data['beneficioPrimario'] = beneficioPrimario;
    data['comoUsar'] = comoUsar;
    return data;
  }
}
