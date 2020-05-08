import 'package:flutter/material.dart';
import 'package:lista_contatos/dao/contato_dao.dart';
import 'package:lista_contatos/models/contato.dart';

class ContatoForm extends StatefulWidget {
  const ContatoForm({Key key}) : super(key: key);

  @override
  _ContatoFormState createState() => _ContatoFormState();
}

class _ContatoFormState extends State<ContatoForm> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _telefoneController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();

    final ContatoDao _dao = ContatoDao();

    return Scaffold(
      appBar: AppBar(
        title: Text('Novo contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
              style: TextStyle(fontSize: 24.0),
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              style: TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.emailAddress,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Criar'),
                  onPressed: () {
                    final String name = _nomeController.text;
                    final String telefone = _telefoneController.text;
                    final String email = _emailController.text;

                    final novoContato = Contato(null, name, telefone, email);
                    _dao.save(novoContato).then((id) {
                      Navigator.pop(context);
                      });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}