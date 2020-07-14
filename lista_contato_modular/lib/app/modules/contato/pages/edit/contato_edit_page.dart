import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_contato_modular/app/modules/contato/pages/edit/contato_edit_controller.dart';
import 'package:lista_contato_modular/app/modules/contato/pages/edit/widgets/setting_modal_bottom_sheet_widget.dart';
import 'package:lista_contato_modular/app/modules/contato/widgets/text_field_widget.dart';

class ContatoEditPage extends StatefulWidget {
  final String title;
  final String id;
  const ContatoEditPage({Key key, this.title = "Novo contato", this.id})
      : super(key: key);

  @override
  _ContatoEditPageState createState() => _ContatoEditPageState();
}

class _ContatoEditPageState
    extends ModularState<ContatoEditPage, ContatoEditController> {
  @override
  void initState() {
    if (widget.id != null) controller.load(int.parse(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(builder: (_) {
            return Form(
              key: controller.keyForm,
              autovalidate: controller.validate,
              child: Column(
                children: <Widget>[
                  Observer(
                    builder: (_) {
                      return GestureDetector(
                        onTap: () => _display(_),
                        child: CircleAvatar(
                          backgroundImage:
                              controller.contatoModel.imagemPath != null
                                  ? FileImage(
                                      File(controller.contatoModel.imagemPath))
                                  : AssetImage("images/default_user.png"),
                          radius: 60.0,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Observer(builder: (_) {
                    return TextFieldWidget(
                      labelText: 'Nome',
                      validator: controller.validarNome,
                      icon: Icons.person,
                      initialValue: controller.contatoModel.nome,
                      onChanged: controller.setNome,
                    );
                  }),
                  SizedBox(height: 16.0),
                  Observer(builder: (_) {
                    return TextFieldWidget(
                      labelText: 'Telefone',
                      validator: controller.validarCelular,
                      textInputType: TextInputType.phone,
                      initialValue: controller.contatoModel.telefone,
                      onChanged: controller.setTelefone,
                      icon: Icons.phone,
                    );
                  }),
                  SizedBox(height: 16.0),
                  Observer(builder: (_) {
                    return TextFieldWidget(
                        labelText: 'E-mail',
                        validator: controller.validateEmail,
                        textInputType: TextInputType.emailAddress,
                        initialValue: controller.contatoModel.email,
                        onChanged: controller.setEmail,
                        icon: Icons.alternate_email);
                  }),
                  SizedBox(height: 16.0),
                  Observer(builder: (_) {
                    return RaisedButton(
                      onPressed: () => controller.salvar(),
                      child: Text("Salvar"),
                    );
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  _display(BuildContext context) {
    Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
      return SettingModelBottomSheetWidget(
        onTapCamera: () => controller.takePicture(ImageSource.camera),
        onTapGaleria: () => controller.takePicture(ImageSource.gallery),
      );
    });
  }
}
