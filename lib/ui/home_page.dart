import 'dart:io';

import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> listContacts = [];

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
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
        backgroundColor: Colors.teal,
        onPressed: () {
          _showContactPage();
        },
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
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
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
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextButton(
                          onPressed: () {
                            launch("tel:${listContacts[index].phone}");
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ligar",
                            style: TextStyle(color: Colors.teal, fontSize: 20),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showContactPage(contact: listContacts[index]);
                          },
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.teal, fontSize: 20),
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              helper.deleteContact(listContacts[index].id);
                              listContacts.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ))
                    ],
                  ),
                );
              });
        });
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));
    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
    }
    _getAllContacts();
  }

  _getAllContacts() {
    helper.getAllContacts().then((list) => {
          setState(() {
            listContacts = list;
          })
        });
  }
}
