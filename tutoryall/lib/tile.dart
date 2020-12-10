import 'package:flutter/cupertino.dart';
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
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.red),
      ),
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
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 1.0,
                    children: <Widget>[
                      Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(CupertinoIcons.flame),
                        ),
                        label: Text("Python"),
                      ),
                      Chip(
                        label: Text("C/C++"),
                      ),
                      Chip(
                        label: Text("Java"),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.star,
                      size: 70,
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
        ],
      ),
    );
  }
}