import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/planeta.dart';
import 'cadastro_planeta_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Planeta> _planetas = [];

  @override
  void initState() {
    super.initState();
    _loadPlanetas();
  }

  _loadPlanetas() async {
    final planetas = await _dbHelper.getPlanetas();
    setState(() {
      _planetas = planetas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planetas')),
      body: ListView.builder(
        itemCount: _planetas.length,
        itemBuilder: (context, index) {
          final planeta = _planetas[index];
          return ListTile(
            title: Text(planeta.nome),
            subtitle: Text(planeta.apelido ?? ''),
            onTap: () {
              // Navegar para a tela de detalhes
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CadastroPlanetaScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
