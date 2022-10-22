import 'package:app_essencial/controller/controller.dart';
import 'package:app_essencial/controller/hasura_conexao.dart';
import 'package:flutter/material.dart';

class WidgetOleos extends StatelessWidget {
  final String preco;
  final String tamanho;
  final String image;
  final String nome;
  final String nomeCientifico;
  final String descricao;
  final String comoUsar;
  final String beneficioPrimario;
  final Function()? onEdit;
  final Function()? onDelete;
  final bool isAdmin;

  const WidgetOleos({
    Key? key,
    required this.image,
    required this.tamanho,
    required this.nome,
    required this.preco,
    required this.nomeCientifico,
    required this.descricao,
    required this.comoUsar,
    required this.beneficioPrimario,
    required this.isAdmin,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          backgroundColor: const Color(0xFFF4F8FD),
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Color(0xFF02A676),
                  ],
                ),
              ),
              child: _popUpInfoCard(),
            );
          },
        );
      },
      child: Container(
        height: isAdmin ? 150 : 120,
        margin: const EdgeInsets.only(left: 16, right: 6, top: 24),
        child: Stack(
          children: [
            _oleosCard(),
            _oleosImage(),
          ],
        ),
      ),
    );
  }

  Widget _oleosImage() {
    return Container(
      height: 100,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // boxShadow: const <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black,
        //     blurRadius: 10.0,
        //     offset: Offset(0.0, 10.0),
        //   ),
        // ],
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: NetworkImage(image),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      alignment: const FractionalOffset(0.0, 0.5),
    );
  }

  Widget _oleosCard() {
    return Container(
      margin: const EdgeInsets.only(left: 46, right: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff01402E),
            Color(0xFF02A676),
          ],
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black87,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Container(
          margin: const EdgeInsets.only(top: 16.0, left: 72.0),
          constraints: const BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                nome,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                nomeCientifico,
                style: const TextStyle(color: Colors.white),
              ),
              Container(
                  color: Colors.white,
                  width: 24.0,
                  height: 1.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    tamanho,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_rounded,
                          size: 18.0, color: Colors.white),
                      Text(
                        preco,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              isAdmin
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: onEdit,
                          child: const Text('Editar'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue,
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: onDelete,
                          child: const Text('Deletar'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.red,
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popUpInfoCard() {
    Controller controller = Controller();
    const TextStyle textoSubTitulo =
        TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //container para o image
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0xff01402E),
                        blurRadius: 15.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            //Container para dados dos oleos
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0xff01402E),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      color: const Color(0xFF02A676),
                      icon: const Icon(Icons.share),
                      onPressed: () => controller.sharePost(
                        nome: nome,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nome,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF02A676),
                          ),
                        ),
                        Text(
                          nomeCientifico,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Modo de Usar',
                          style: textoSubTitulo,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          comoUsar,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Benefícios Primários',
                          style: textoSubTitulo,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          beneficioPrimario,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Descrição Aromática',
                          style: textoSubTitulo,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          descricao,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xff01402E),
                                primary: Colors.white,
                              ),
                              onPressed: () => controller.webWhats(
                                  link:
                                      'Ola, gostaria de encomendar o oleo $nome'),
                              child: const Text('Encomendar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
