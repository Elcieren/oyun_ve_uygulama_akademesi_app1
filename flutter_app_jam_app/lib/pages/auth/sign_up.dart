import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String adsoyad;
  late String kullaniciadi;
  late String email;
  late String sifre;
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var heigh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: heigh * .25,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/background.png"))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hemen Sende \nAramıza\nKatıl",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2)),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: emailTextField()),
                      const SizedBox(
                        height: 20,
                      ),
                      //AdSoyadTextField(),

                      // userNameTextField(),

                      Container(
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2)),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: sifreTextField()),
                      const SizedBox(
                        height: 20,
                      ),
                      HesapOlusturButton(),
                      const SizedBox(
                        height: 5,
                      ),
                      GirisSayfasinaGeriDonButton()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration customInputDecaration(String hinText) {
    return InputDecoration(
      hintText: hinText,
      hintStyle: const TextStyle(color: Colors.grey),
      border: InputBorder.none,
    );
  }

  Center HesapOlusturButton() {
    return Center(
      child: TextButton(
        onPressed: sign_up,
        child: const Text("Hesap Oluştur"),
      ),
    );
  }

  void sign_up() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        var userResult = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: sifre);
        formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Giriş Yapıldı Ana Sayafaya yönlendiriliyorsunuz"),
          ),
        );
        Navigator.pushReplacementNamed(context, "/loginPage");
      } catch (e) {
        print(e.toString());
      }
    } else {}
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksik girdiniz";
        } else {}
        return null;
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: customInputDecaration("e-mail"),
    );
  }

  TextFormField sifreTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksik girdiniz";
        } else {}
        return null;
      },
      onSaved: (value) {
        sifre = value!;
      },
      obscureText: true,
      decoration: customInputDecaration("Sifre"),
    );
  }

  TextFormField userNameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksik girdiniz";
        } else {}
        return null;
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: customInputDecaration("Kullanıcı Adı"),
    );
  }

  TextFormField AdSoyadTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksik girdiniz";
        } else {}
        return null;
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: customInputDecaration("Ad Soyad"),
    );
  }

  Center GirisSayfasinaGeriDonButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, "/loginPage");
        },
        child: const Text("Giriş Sayfasına Geri Dön"),
      ),
    );
  }
}
