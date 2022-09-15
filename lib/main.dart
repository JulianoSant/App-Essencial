import 'dart:developer';
import 'package:app_essencial/splash.dart';
import 'package:app_essencial/widget/oleos_row.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'edit_oleo_page.dart';
import 'hasura_conexao.dart';
import 'model/post_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (_) => const SplashPage(),
        "/home_page": (_) => const MyHomePage(),
        "/post_page": (context) {
          var result = ModalRoute.of(context)?.settings.arguments;
          Oleos? oleos = result == null ? null : result as Oleos;
          return PostPage(
            oleos: oleos,
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HasuraConexao _hasuraConexao = HasuraConexao();
  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xff01402E),
        title: const Center(child: Text("App Essencial")),
        actions: [
          _isAdmin
              ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    var isSend =
                        await Navigator.pushNamed(context, "/post_page");
                    if (isSend != null) {
                      setState(() {});
                    }
                  },
                )
              : Container()
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Color(0xFF8FC1B5),
            ],
          ),
        ),
        child: FutureBuilder<PostModel?>(
          future: _hasuraConexao.getAllOleos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            log(snapshot.data.toString());
            return ListView.builder(
              itemCount: snapshot.data!.data!.oleos!.length,
              itemBuilder: (context, i) {
                var post = snapshot.data!.data!.oleos!.elementAt(i);
                return WidgetOleos(
                  image: '${post.image}',
                  nome: post.nome!,
                  nomeCientifico: post.nomeCientifico!,
                  preco: post.preco!,
                  tamanho: '${post.tamanho} ml',
                  comoUsar: post.comoUsar!,
                  beneficioPrimario: post.beneficioPrimario!,
                  descricao: post.descricao!,
                  isAdmin: _isAdmin,
                  // EDITAR OLEOS
                  onEdit: () async {
                    await Navigator.pushNamed(
                      context,
                      "/post_page",
                      arguments: post,
                    );
                    setState(() {});
                  },
                  // DELETAR OLEOS
                  onDelete: () async {
                    var isDelete = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Deletar"),
                        content: const Text("Deseja deletar o Oleo?"),
                        actions: [
                          TextButton(
                            child: const Text("Não"),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          TextButton(
                            child: const Text("Sim"),
                            onPressed: () => Navigator.pop(context, true),
                          ),
                        ],
                      ),
                    );
                    if (isDelete != null && isDelete) {
                      await _hasuraConexao.deleteOleos(post.id!);
                      setState(() {});
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF02A676),
        child: const Icon(Icons.call),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (BuildContext context) {
              return _perfil();
            },
          );
        },
      ),
    );
  }

// ABRE O PERFIL DA JULY
  Widget _perfil() {
    int cont = 0;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Color(0xFF8FC1B5),
          ],
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage('images/Perfil.jpeg'),
            ),
            const Text(
              'July Anne',
              style: TextStyle(fontSize: 70, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (() {
                //ABILITAR A FUNÇAO ADMIN
                cont++;
                setState(
                  () {
                    if (cont == 5) {
                      _admin();
                    }
                  },
                );
              }),
              child: const Text(
                'Lider Premier',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 17,
                  color: Colors.black,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 1,
              width: 150,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              height: 40,
              // color: Colors.white,
              child: GestureDetector(
                onTap: () => webWhats(),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child:
                          Icon(FontAwesomeIcons.whatsapp, color: Colors.teal),
                    ),
                    Text(
                      '(41) 99749-1470',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 40,
              // color: Colors.black,
              child: GestureDetector(
                onTap: () => webInstagran(),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 50,
                      child:
                          Icon(FontAwesomeIcons.instagram, color: Colors.teal),
                    ),
                    Text(
                      '@julyannelopes',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 40,
              // color: Colors.black,
              child: Row(
                children: const [
                  SizedBox(
                    width: 50,
                    child: Icon(Icons.account_box_rounded, color: Colors.teal),
                  ),
                  Text(
                    'Julyannelopes@yahoo.com.br',
                    style: TextStyle(
                      fontSize: 20,
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

  Future webInstagran() async {
    final Uri urlInstagran =
        Uri(scheme: 'https', host: 'www.instagram.com', path: 'julyannelopes');

    if (!await launchUrl(
      urlInstagran,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $urlInstagran';
    }
  }

  Future webWhats() async {
    final Uri urlInstagran =
        Uri(scheme: 'https', host: 'wa.me', path: '5541997491470');

    if (!await launchUrl(
      urlInstagran,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $urlInstagran';
    }
  }

  Future _admin() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Admin'),
          content: const Text('Você é o admin'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(
                  () {
                    _isAdmin = true;
                  },
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
