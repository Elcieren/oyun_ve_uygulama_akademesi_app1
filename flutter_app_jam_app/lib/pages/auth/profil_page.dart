import 'package:flutter/material.dart';
import 'sidebar.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      drawer: SideBar(),
      body: Center(
        child: Text('Profil'),
      ),
    );
  }
}
