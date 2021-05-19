import 'dart:io';

import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> listContacts = [];

  //teste
  @override
  void initState() {
    super.initState();
    setState(() {
      helper.getAllContacts().then((list) => {
        listContacts = list,
        listContacts.clear(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contatos",
          style: TextStyle(color: Colors.white),
        ),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: listContacts.length,
          itemBuilder: (context, index) {
            return contactCard(context, index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: listContacts[index].img != null
                          ? FileImage(File(listContacts[index].img))
                          : AssetImage("images/person.png")),
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listContacts[index].name ?? "",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(listContacts[index].email ?? "",
                      style: TextStyle(fontSize: 18)),
                  Text(listContacts[index].phone ?? "",
                      style: TextStyle(fontSize: 18)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
