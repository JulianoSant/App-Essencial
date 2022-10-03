import 'package:hasura_connect/hasura_connect.dart';
import '../model/post_model.dart';

const String url = "https://appessencial.hasura.app/v1/graphql";

class HasuraConexao {
  HasuraConnect connect =
      HasuraConnect(url, headers: {'content-type': 'application/json'});

  String queryOleos = """
    query {
      oleos {
        id
        nome
        nomeCientifico
        image
        preco
        tamanho
        descricao
        beneficioPrimario
        comoUsar
        }
      }
    """;

  Future<PostModel?> getAllOleos() async {
    try {
      var result = await connect.query(queryOleos);
      return PostModel.fromJson(result);
    } catch (e) {
      return null;
    }
  }

  Future<bool> insertOleos(String nome, nomeCientifico, preco, tamanho, image,
      comoUsar, beneficioPrimario, descricao) async {
    //A QUERY PRECISA SER NA ORDEM DO FORMULARIO
    String documentMutation = """
      mutation MyMutation {
        insert_oleos(objects: {
          nome: "$nome",
          nomeCientifico: "$nomeCientifico",
          preco: "$preco",
          tamanho: "$tamanho",
          image: "$image",
          comoUsar: "$comoUsar",
          beneficioPrimario: "$beneficioPrimario",
          descricao: "$descricao"
          }) {
          affected_rows
        }
      }
    """;

    try {
      await connect.mutation(documentMutation);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateOleos(int id, String nome, nomeCientifico, preco, tamanho,
      image, comoUsar, beneficioPrimario, descricao) async {
    //A QUERY PRECISA SER NA ORDEM DO FORMULARIO
    String document = """
      mutation MyMutation {
        update_oleos(where: {id: {_eq: $id }}, _set: {
          nome: "$nome",
          nomeCientifico: "$nomeCientifico",
          preco: "$preco",
          tamanho: "$tamanho",
          image: "$image",
          comoUsar: "$comoUsar",
          beneficioPrimario: "$beneficioPrimario",
          descricao: "$descricao"
          }) {
          affected_rows
        }
      }  
    """;
    try {
      await connect.mutation(document);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteOleos(int id) async {
    String document = """
      mutation MyMutation {
        delete_oleos(where: {id: {_eq: $id }}) {
          affected_rows
        }
      }  
    """;
    try {
      await connect.mutation(document);
      return true;
    } catch (e) {
      return false;
    }
  }
}
