import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

class Controller {
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

  Future webWhats({String? link}) async {
    final Uri urlWhats =
        Uri.http('wa.me', '5541997491470', {'text': link} ?? null);

    // final Uri urlWhats = Uri(
    //   scheme: 'https',
    //   host: 'wa.me',
    //   path: link ?? '5541997491470',
    // );
    if (!await launchUrl(
      urlWhats,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $urlWhats';
    }
  }

  Future webTelegran() async {
    final Uri urlTelegran =
        Uri(scheme: 'https', host: 't.me', path: 'LK4tsedzU9tkNWRh');
    if (!await launchUrl(
      urlTelegran,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $urlTelegran';
    }
  }

  Future<void> sharePost({String? nome, menssagem}) async {
    await SocialShare.shareOptions(
        'Ola, gostaria de compartilhar com voce esse oleo chamado $nome!');
  }
}
