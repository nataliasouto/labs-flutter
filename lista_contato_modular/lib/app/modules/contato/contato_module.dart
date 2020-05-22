import 'package:lista_contato_modular/app/modules/contato/pages/edit/contato_edit_controller.dart';
import 'package:lista_contato_modular/app/modules/contato/pages/edit/contato_edit_page.dart';
import 'package:lista_contato_modular/app/modules/contato/repositories/contato_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_contato_modular/app/modules/contato/pages/list/contato_controller.dart';
import 'package:lista_contato_modular/app/modules/contato/pages/list/contato_page.dart';
import 'package:lista_contato_modular/app/modules/contato/repositories/interfaces/contato.interface.repository.dart';
import 'package:lista_contato_modular/app/modules/contato/services/contato_service.dart';
import 'package:lista_contato_modular/app/modules/contato/services/interfaces/contato.interface.service.dart';

class ContatoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<IContatoRepository>((i) => ContatoRepository()),
        Bind<IContatoService>(
            (i) => ContatoService(contatoRepository: i.get())),
        Bind(
            (i) => ContatoController(contatoService: i.get<IContatoService>()), singleton: false),
        Bind((i) =>
            ContatoEditController(contatoService: i.get<IContatoService>()), singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ContatoPage()),
        Router("/edit", child: (_, args) => ContatoEditPage())
      ];

  static Inject get to => Inject<ContatoModule>.of();
}
