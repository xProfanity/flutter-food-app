import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/models/menu.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final foodMenu = Provider.of<List<FoodMenu>?>(context);

    return foodMenu != null
        ? Container(
            child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Column(children: [
              _header(),
              Expanded(
                child: ListView.builder(
                    itemCount: foodMenu.length,
                    itemBuilder: (context, int i) {
                      return FoodTile(foodMenu[i]);
                    }),
              )
            ]),
          ))
        : Container(
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/pizza_sliced.gif')),
                  SizedBox(
                    height: 2,
                  ),
                  Text('Loading...')
                ],
              ),
            ),
          );
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
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    height: 350,
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
    return Material(
      elevation: 4,
      child: Container(
          height: 70,
          width: 500,
          color: Colors.white,
          child: Center(
              child: SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFFd79914)),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  focusColor: Color(0xFFd79914)),
            ),
          ))),
    );
  }
}
