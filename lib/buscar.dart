import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Tiendas/ShopOne.dart';

class buscar extends StatefulWidget {
  final String searchWord;
  buscar(this.searchWord);
  @override
  BuscarApp createState() => BuscarApp();
}

//
class BuscarApp extends State<buscar> {
  @override
  Widget build(BuildContext context) {
    ///++++++++++++++++++++++++++++
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Resultados de búsqueda"),
      ),
      body: Center(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Tiendas").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            // print(widget.searchWord);
            return ListView.builder(
              itemCount: snapshot.data!.docs.length, // define las iteraciones
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data!.docs[index].get("nombreTienda").toString().toUpperCase().contains(widget.searchWord.toUpperCase())) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding:
                                        const EdgeInsets.only(bottom: 10),
                                    child: Text(snapshot.data!.docs[index]
                                        .get("nombreTienda"))),
                                Text(
                                  snapshot.data!.docs[index].get("descrip"),
                                  style: TextStyle(
                                    color: Colors.green[500],
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.asset('image/' +
                                  snapshot.data!.docs[index].get("ruta")),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(minimumSize: const Size(50, 40),
                                    primary: Colors.orange),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ShopOne(snapshot.data!.docs[index].id)));
                                }, child: const Text('Entrar'))
                          ]),
                        )
                      ],
                    ),
                  );
                }else {
                  return Card();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
