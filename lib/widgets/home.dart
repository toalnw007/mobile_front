import 'package:flutter/material.dart';
import 'package:flutter_application/model/news.dart';
import 'package:flutter_application/utility/my_constant.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  List<News> news = [
    News(
        id: 1,
        header: 'BYD Atto3',
        imageSource: 'images/car.jpg',
        detail:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
    News(
        id: 2,
        header: 'Tesla',
        imageSource: 'images/tesla.jpg',
        detail:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
    News(
        id: 3,
        header: 'Ora',
        imageSource: 'images/ora.jpg',
        detail:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.')
  ];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              height: MediaQuery.of(context).size.height * 0.78,
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: MyConstant.light,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 8,
                      child: SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  news[index].header,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                            Image.asset(
                              news[index].imageSource,
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                news[index].detail,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
