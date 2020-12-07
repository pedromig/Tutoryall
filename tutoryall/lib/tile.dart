/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Gabriel Mendes Fernandes
 *   
*/

import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;

  CustomTile(
      {this.snapshot,
      this.index}); //assign the input parameter to this.snapshot

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              title: Text(this.snapshot.data[this.index].name),
              trailing: InkWell(
                  onTap: () {
                    print("imagem premida");
                  }, //adicionar o que faz quando a imagem de user e pressionada
                  child: CircleAvatar()),
            ),
          ), //serve para colocar a imagem do user
          Container(
            /*padding: EdgeInsets.all(20),
          child: Align(alignment: Alignment.centerLeft, child: Text("Teste"))*/
            height: 30,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.snapshot.data[this.index].tags.length,
              itemBuilder: (BuildContext context, int ind) {
                int c = 100 + 100 * (ind % 2);
                return InkWell(
                  onTap: () {
                    print("É suposto implementar algo quando a tag é premida?");
                  }, //colocar aqui o que fazer quando a tag for premida (pode pesquisar automaticamente tudo o que tenha essa tag)
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    color: Colors.blue[c],
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          this.snapshot.data[this.index].tags[ind].tagName),
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
