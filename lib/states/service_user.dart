import 'dart:convert';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/loan.dart';
import 'package:flutter_application/utility/my_constant.dart';
import 'package:flutter_application/utility/my_style.dart';
import 'package:flutter_application/widgets/home.dart';
import 'package:flutter_application/widgets/loan.dart';
import 'package:flutter_application/widgets/show_image.dart';
import 'package:flutter_application/widgets/show_progress.dart';
import 'package:flutter_application/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceUser extends StatefulWidget {
  const ServiceUser({super.key});

  @override
  State<ServiceUser> createState() => _ServiceUserState();
}

class _ServiceUserState extends State<ServiceUser> {
  int _mainIndex = 0;
  final _pageOptions = [Home(), const Loan()];
  List<Widget> widgets = [];
  List<String> pathImages = [
    'images/banner1.jpg',
    'images/banner2.png',
    'images/banner3.jpg',
  ];

  List<String> pathLoanImages = [
    'images/loan1.png',
    'images/loan2.png',
    'images/loan3.png'
  ];

  List<LoanModel> LoanModels = [];
  List<Widget> imageWidgets = [];

  @override
  void initState() {
    super.initState();
    buildWidgets();
    readData();
  }

  Future<Null> readData() async {
    String apiLoan = 'http://10.0.2.2:8080/api/Loan';
    await Dio().get(apiLoan).then(
      (value) {
        print('### apiLoan = $value');
        for (var element in value.data) {
          LoanModel model = LoanModel.fromMap(element);
          setState(() {
            LoanModels.add(model);
          });
        }
      },
    );
  }

  void buildWidgets() {
    for (var element in pathImages) {
      widgets.add(Image.asset(element));
    }
  }

  final iconList = <IconData>[
    Icons.person,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home_rounded), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Loan')
      //   ],
      //   elevation: 15.0,
      //   currentIndex: _mainIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       _mainIndex = index;
      //     });
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: MyConstant.statndard),
            borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          Icons.home,
          color: MyConstant.statndard,
          size: 30,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        inactiveColor: MyConstant.primary,
        activeColor: MyConstant.primary,
        activeIndex: _mainIndex,
        backgroundColor: MyConstant.statndard,
        gapLocation: GapLocation.center,

        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => setState(() => _mainIndex = index),
        //other params
      ),
      // bottomNavigationBar: AnimatedBottomNavigationBar.builder(
      //   itemCount: iconList.length,
      //   tabBuilder: (int index, bool isActive) {
      //     final color = isActive ? MyConstant.primary : MyConstant.statndard;
      //     return Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(
      //           iconList[index],
      //           size: 24,
      //           color: color,
      //         ),
      //         const SizedBox(height: 4),
      //         const Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 8),
      //         )
      //       ],
      //     );
      //   },
      //   backgroundColor: MyConstant.light,
      //   activeIndex: _mainIndex,
      //   splashColor: MyConstant.primary,
      //   // notchAndCornersAnimation:
      //   splashSpeedInMilliseconds: 300,
      //   notchSmoothness: NotchSmoothness.defaultEdge,
      //   gapLocation: GapLocation.center,
      //   leftCornerRadius: 32,
      //   rightCornerRadius: 32,
      //   onTap: (index) => setState(() => _mainIndex = index),
      //   // hideAnimationController: _hideBottomBarAnimationController,
      // ),

      appBar: AppBar(
        backgroundColor: MyConstant.statndard,
        title: Center(
          child: Column(
            children: [
              Image.asset(
                'images/somwang_logo.png',
                height: 50,
              ),
            ],
          ),
        ),
        actions: [buildSignOut()],
      ),
      body: _pageOptions[_mainIndex],
    );
  }

  String cutWord(String string) {
    String word = string;
    if (word.length > 100) {
      word = word.substring(1, 100);
      word = '$word...';
    }
    return word;
  }

  Future<Null> showDetailDialog(LoanModel model) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: const ShowImage(),
          title: ShowTitle(
            title: " detail " + model.name,
            textStyle: MyStyle().h2Style(),
          ),
        ),
        children: [
          for (int i = 0; i <= pathLoanImages.length; i++)
            if (model.id == i)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(pathLoanImages[i - 1]),
              ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowTitle(
                  title: " รายการที่ " + model.id.toString(),
                  textStyle: MyStyle().h2Style(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShowTitle(
                title: "รายละเอียด " + model.name,
                textStyle: MyStyle().h3Style()),
          )
        ],
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: pathLoanImages.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          showDetailDialog(LoanModels[index]);
        },
        child: Card(
          color: index % 2 == 0 ? Colors.grey.shade200 : MyConstant.statndard,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowTitle(
                        title: LoanModels[index].name,
                        textStyle: MyStyle().h3Style(),
                      ),
                      ShowTitle(
                        title: cutWord(" รายละเอียด" + LoanModels[index].name),
                        textStyle: MyStyle().h3Style(),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Image.asset(
                    pathLoanImages[
                        index], // แทนที่ 'path/to/image.jpg' ด้วย path จริง
                    height: 50, // ปรับความสูงตามต้องการ
                    width: 50, // ปรับความกว้างตามต้องการ
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTiltle() {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        ShowTitle(
          title: 'สินเชื่อ : ',
          textStyle: MyStyle().h1Style(),
        ),
      ],
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      items: widgets,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        viewportFraction: 0.8,
      ),
    );
  }

  IconButton buildSignOut() {
    return IconButton(
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
      },
      icon: const Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
    );
  }
}
