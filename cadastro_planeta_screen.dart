import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/planeta.dart';

class CadastroPlanetaScreen extends StatefulWidget {
  @override
  _CadastroPlanetaScreenState createState() => _CadastroPlanetaScreenState();
}

class _CadastroPlanetaScreenState extends State<CadastroPlanetaScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  _savePlaneta() async {
    if (_formKey.currentState?.validate() ?? false) {
      final planeta = Planeta(
        nome: _nomeController.text,
        distanciaSol: double.parse(_distanciaController.text),
        tamanho: double.parse(_tamanhoController.text),
        apelido: _apelidoController.text.isEmpty ? null : _apelidoController.text,
      );

      await _dbHelper.insertPlaneta(planeta);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Planeta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Planeta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanciaController,
                decoration: InputDecoration(labelText: 'Distância do Sol (UA)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Insira um valor válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tamanhoController,
                decoration: InputDecoration(labelText: 'Tamanho (km)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Insira um valor válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apelidoController,
                decoration: InputDecoration(labelText: 'Apelido (opcional)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePlaneta,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
