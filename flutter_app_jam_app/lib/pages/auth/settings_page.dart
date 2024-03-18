import 'package:flutter/material.dart';
import 'sidebar.dart';

class Ayarlar extends StatelessWidget {
  const Ayarlar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      drawer: SideBar(),
      body: Center(
        child: Text('Ayarlar'),
      ),
    );
  }
}
