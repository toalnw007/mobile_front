import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/user.dart';
import 'package:flutter_application/utility/my_constant.dart';
import 'package:flutter_application/utility/my_dialog.dart';
import 'package:flutter_application/utility/my_style.dart';
import 'package:flutter_application/widgets/show_image.dart';
import 'package:flutter_application/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    print('size = $size');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  buildImage(size),
                  ShowTitle(
                    title: 'tisco.co.th',
                    textStyle: MyStyle().h2Style(),
                  ),
                  buildUser(size),
                  buildPassword(size),
                  buildLogin(size),
                  buildRow()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Non Account ?',
          textStyle: MyStyle().h3Style(),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/createAccount'),
          child: const Text(
            'Create Account',
            style: TextStyle(color: MyConstant.statndard),
          ),
        )
      ],
    );
  }

  Container buildLogin(double size) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: size * 0.6,
      child: ElevatedButton(
        style: MyStyle().myButtonStyleV2(),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            checkAuthen(
                user: userController.text, password: passwordController.text);
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> checkAuthen(
      {@required String? user, @required String? password}) async {
    print("### user = $user, password = $password");
    String api = 'http://10.0.2.2:8080/api/user?username=$user';
    await Dio().get(api).then((value) async {
      print("### value = $value");
      if (value.toString() == '[null]') {
        normalDialog(
            context, 'User False', 'No $user in my system.', 'Pleas Try Again');
      } else {
        //var result = json.decode(value.data); encodeภาษาไทย
        for (var element in value.data) {
          UserModel model = UserModel.fromMap(element);
          if (password == model.password) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('user', model.username);
            preferences.setString('name', model.name);
            preferences.setInt('id', model.id);

            Navigator.pushNamedAndRemoveUntil(
                context, '/serviceUSer', (route) => false);
          } else {
            normalDialog(context, 'Password False', ' Please Try Again ',
                ' Or contact admin');
          }
        }
      }
    });
  }

  Container buildUser(double size) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill User';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'User : ',
          prefixIcon: const Icon(
            Icons.perm_identity,
            color: MyConstant.light,
            size: 30,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: MyConstant.dart),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Container buildPassword(double size) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Password';
          } else {
            return null;
          }
        },
        obscureText: true,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye),
          ),
          labelText: 'Password : ',
          prefixIcon: const Icon(
            Icons.lock_outlined,
            color: MyConstant.light,
            size: 30,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: MyConstant.dart),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Container buildImage(double size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 400,
      child: const ShowImage(),
    );
  }
}
