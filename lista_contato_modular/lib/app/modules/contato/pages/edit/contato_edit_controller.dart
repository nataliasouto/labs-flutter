import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_contato_modular/app/modules/contato/models/contato_model.dart';
import 'package:lista_contato_modular/app/modules/contato/services/interfaces/contato.interface.service.dart';
import 'package:mobx/mobx.dart';

part 'contato_edit_controller.g.dart';

class ContatoEditController = _ContatoEditControllerBase
    with _$ContatoEditController;

abstract class _ContatoEditControllerBase extends Disposable with Store {
  final IContatoService contatoService;

  final GlobalKey<FormState> keyForm = new GlobalKey();

  @observable
  ContatoModel contatoModel = ContatoModel();

  @observable
  bool validate = false;

  int _id;

  _ContatoEditControllerBase({@required this.contatoService});

  @action
  load(int id) async {
    this._id = id;
    contatoModel = await contatoService.findById(_id);
  }

  @action
  salvar() async {
    if (!keyForm.currentState.validate()) {
      validate = true;
    } else {
      if (this._id == null) {
        await this._insert(contatoModel);
      } else {
        await this._update(contatoModel);
      }
      keyForm.currentState.save();
      Modular.link.pushNamedAndRemoveUntil("/", (route) => false);
    }
  }

  _insert(ContatoModel contato) async {
    await this.contatoService.insert(contato);
  }

  _update(ContatoModel contato) async {
    await this.contatoService.update(contato);
  }

  void setNome(String value) => this.contatoModel.nome = value;

  void setTelefone(String value) => this.contatoModel.telefone = value;

  void setEmail(String value) => this.contatoModel.email = value;


  String validarNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String validarCelular(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o celular";
    } else if(value.length != 10){
      return "O celular deve ter 10 dígitos";
    }else if (!regExp.hasMatch(value)) {
      return "O número do celular so deve conter dígitos";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  @override
  void dispose() {}
}
