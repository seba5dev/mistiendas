import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class Shop extends StatefulWidget {
  @override
  ShopApp createState() => ShopApp();
}

class ShopApp extends State<Shop> {
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tiendas'),
      ),
      body:  Container(
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Tiendas").snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,// define las iteraciones
                itemBuilder: (BuildContext context, int index){
                  return new Card(
                    child: new Column(
                      children:<Widget>[
                        Container(
                          padding:const EdgeInsets.all(15),
                          child: Row(
                            children:[
                              Expanded(child: Column(
                                crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                    const EdgeInsets.only(bottom: 10),
                                    child:Text(snapshot.data!.docs[index].get("nombreTienda"))
                                  ),
                                  Text(snapshot.data!.docs[index].get("descrip")
                                    ,
                                    style: TextStyle(
                                      color: Colors.green[500],
                                    ),
                                  ),

                                ],
                              )),
                              Container(
                                width: 80,
                                height: 80,
                                child: Image.asset('image/'+snapshot.data!.docs[index].get("ruta")),
                              ),
                              ElevatedButton(onPressed: (){}, child: Text('Entrar'))
                            ]
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
          },
          ),
        ),
      ),
    );
  }
}
