import 'package:flutter/material.dart';

import 'mapa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaViagens = [
    "Cristo Redentor",
    "Grande Muralha da China",
    "Taj Mahal",
    "Macho Picchu",
    "Coliseu"
  ];

  _excluirViagem(){

  }

  _abrirMapa(){

  }
  _adicionarLocal(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder :(_) => Mapa() )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Viagens"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          backgroundColor: Color(0xff0066cc),
          onPressed: (){
            _adicionarLocal();
          }),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _listaViagens.length,
              itemBuilder: (context, index){
                String titulo = _listaViagens[index];
                return GestureDetector(
                  onTap: (){
                    _abrirMapa();
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(titulo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              _excluirViagem();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
