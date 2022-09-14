import 'package:flutter/material.dart';

import 'hasura_conexao.dart';
import 'model/post_model.dart';

class PostPage extends StatefulWidget {
  final Oleos? oleos;
  const PostPage({Key? key, this.oleos}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var nome = TextEditingController();
  var nomeCientifico = TextEditingController();
  var image = TextEditingController();
  var preco = TextEditingController();
  var tamanho = TextEditingController();
  var nomeIdCampo = TextEditingController();
  var comoUsar = TextEditingController();
  var beneficioPrimario = TextEditingController();
  var descricao = TextEditingController();
  final HasuraConexao _hasuraConexao = HasuraConexao();

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    if (widget.oleos != null) {
      nome.text = widget.oleos!.nome!;
      nomeCientifico.text = widget.oleos!.nomeCientifico!;
      preco.text = widget.oleos!.preco!;
      tamanho.text = widget.oleos!.tamanho!.toString();
      image.text = widget.oleos!.image!;
      comoUsar.text = widget.oleos!.comoUsar!;
      beneficioPrimario.text = widget.oleos!.beneficioPrimario!;
      descricao.text = widget.oleos!.descricao!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff01402E),
        title: const Text("Cadastrar Oleo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                lineText(nomeIdCampo: nome, nomeCampo: "Nome..."),
                lineText(
                    nomeIdCampo: nomeCientifico,
                    nomeCampo: "Nome Cientifico..."),
                lineText(nomeIdCampo: preco, nomeCampo: "Preço..."),
                lineText(nomeIdCampo: tamanho, nomeCampo: "Tamanho..."),
                lineText(nomeIdCampo: image, nomeCampo: "URL imagem..."),
                lineText(nomeIdCampo: comoUsar, nomeCampo: "Modo de Usar..."),
                lineText(
                    nomeIdCampo: beneficioPrimario,
                    nomeCampo: "Benefícios Primários..."),
                lineText(
                    nomeIdCampo: descricao,
                    nomeCampo: "Descrição Aromática..."),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: 60,
              child: ElevatedButton.icon(
                onPressed: nome.text == ""
                    ? null
                    : () async {
                        late bool isSend;
                        if (widget.oleos != null) {
                          isSend = await _hasuraConexao.updateOleos(
                            widget.oleos!.id!,
                            nome.text,
                            nomeCientifico.text,
                            preco.text,
                            tamanho.text,
                            image.text,
                            comoUsar.text,
                            beneficioPrimario.text,
                            descricao.text,
                          );
                        } else {
                          isSend = await _hasuraConexao.insertOleos(
                            nome.text,
                            nomeCientifico.text,
                            preco.text,
                            tamanho.text,
                            image.text,
                            comoUsar.text,
                            beneficioPrimario.text,
                            descricao.text,
                          );
                        }
                        if (isSend) {
                          Navigator.pop(context, isSend);
                        }
                      },
                icon: const Icon(
                  Icons.send,
                ),
                label: const Text(
                  'Adicionar',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget lineText(
      {required TextEditingController nomeIdCampo, required String nomeCampo}) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: nomeIdCampo,
        decoration: InputDecoration(
            filled: true, fillColor: Colors.grey.shade200, hintText: nomeCampo),
        expands: true,
        maxLines: null,
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
