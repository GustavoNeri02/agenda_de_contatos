import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();
    // Contact c = Contact();
    // c.name = "Gustavo Neri";
    // c.email = "gutneri@hotmail.com";
    // c.phone = "(77) 4615";
    // c.img = "sdsadsa";
    // helper.saveContact(c);
    helper.getAllContacts().then((list) => {print(list)});

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

