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
              onTap: () => {print("Tapped!")},
              leading: InkWell(
                onTap: () => {print("imagem premida")},
                child: CircleAvatar(),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Explicação de turtle",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text("5ºfeira 18h - Coimbra"),
                  Text("10/20 people are going"),
                ],
              ),
              trailing: Column(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                    child: Text("4.5"),
                  ),
                ],
              ),
              title: Text(
                this.snapshot.data[this.index].name,
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 70, right: 50),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.snapshot.data[this.index].tags.length,
              itemBuilder: (BuildContext context, int ind) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(this.snapshot.data[this.index].tags[ind].tagName),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
