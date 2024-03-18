import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_jam_app/pages/auth/home_page.dart';
import 'package:flutter_app_jam_app/services/auth_service.dart';
import 'package:flutter_app_jam_app/widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String sifre;
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AutService();
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
                      Text("Uygulamımıza \nHoşgeldiniz",
                          style: Theme.of(context).textTheme.headlineMedium),
                      Row(
                        children: [
                          const Opacity(
                            opacity: 1, // Şeffaflık değeri
                            child: Text(
                              'Henüz bir hesabınız yok mu?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/signUp");
                              },
                              child: const Text(
                                "Hesap Oluştur ",
                                style: TextStyle(
                                    color: Color(0xff767CE8),
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                      /* Center(
                        child: CustomTextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/signUp");
                          },
                          buttontext: "Hesap oluştur",
                        ),
                      ), */
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
                      Container(
                          width: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2)),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: sifreTextField()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: TextButton(
                              onPressed: () {
                                authService.sifremiUnuttum(email);
                              },
                              child: const Text(
                                "Şifrenizi Unutunuz mu ?",
                                style: TextStyle(
                                    color: Color(0xff767CE8),
                                    fontSize: 13,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GirisButtonu(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 1,
                            color: Colors.black,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'veya bunla giriş yapın',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: CustomTextButton(
                            onPressed: () async {
                              final reslut = await authService.sigInAnonymous();
                              if (reslut != null) {
                                Navigator.pushReplacementNamed(
                                    context, "/homePage");
                              } else {
                                print("HATA");
                              }
                            },
                            buttontext: "Ziyaretçi Girişi"),
                      ),
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
        border: InputBorder.none);
  }

  Center GirisButtonu() {
    return Center(
      child: TextButton(
        onPressed: signIn,
        child: Container(
          height: 50,
          width: 125,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xff767CE8),
          ),
          child: const Center(
              child: Text(
            "Giris Yap",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final result = await authService.GirisYap(email, sifre);
      if (result == "basarili") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      } else {
        CupertinoAlertDialog(
          title: const Text('Alert'),
          content: const Text('Proceed with destructive action?'),
          actions: [
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      }

      /* formKey.currentState!.save();
      try {
        final userResult = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: sifre);
        Navigator.pushReplacementNamed(context, "/homePage");
        print(userResult.user!.email);
      } catch (e) {
        print(e.toString());
      } */
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
}
