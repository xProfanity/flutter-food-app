import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/models/menu.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final foodMenu = Provider.of<List<FoodMenu>?>(context);

    return Container(
        child: Align(
      alignment: AlignmentDirectional.topStart,
      child: Column(children: [
        _header(),
        const Text('hi'),
        Expanded(
          child: ListView.builder(
              itemCount: foodMenu?.length,
              itemBuilder: (context, int i) {
                return FoodTile(foodMenu?[i]);
              }),
        )
      ]),
    ));
  }

  Widget FoodTile(food) {
    return Container(
      height: 350,
      width: 350,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Card(
          elevation: 5.0,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(food?.photoUrl), fit: BoxFit.cover)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Container(
                    height: 200,
                    width: 350,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFFd79914),
                              ),
                              child: const Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add to Bag',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 15,
                                    weight: 51.0,
                                  )
                                ],
                              )),
                            ),
                          ),
                        ),
                        Text(
                          '\$${food?.price}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          food?.contents,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(food?.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              height: 5.0,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return const Text('header');
  }
}
