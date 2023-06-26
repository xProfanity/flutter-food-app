import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodapp/widgets/AddToCartButton.dart';
import 'package:foodapp/widgets/CrashReport.dart';
import 'package:foodapp/widgets/Loader.dart';

class Menu extends StatefulWidget {
  final docId;
  final updateCartCount;
  final cart;
  final foodMenu;
  final count;
  final updateSearchTerm;
  final searchTerm;

  const Menu(this.updateCartCount, this.docId, this.cart, this.count,
      this.foodMenu, this.updateSearchTerm, this.searchTerm);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List foodMenu = widget.foodMenu;
    final cart = widget.cart;
    print('yiy foof maend $foodMenu');
    return foodMenu != null
        ? Container(
            child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Column(children: [
              _header(),
              Visibility(
                visible:
                    widget.searchTerm != '' && foodMenu.isEmpty ? false : true,
                child: Expanded(
                  child: ListView.builder(
                      itemCount: foodMenu.length,
                      itemBuilder: (context, int i) {
                        return FoodTile(foodMenu[i], cart);
                      }),
                ),
              ),
              Visibility(
                  visible: widget.searchTerm != '' && foodMenu.isEmpty,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        CrashReport(
                            "No results found for \"${widget.searchTerm}\"",
                            false),
                      ],
                    ),
                  ))
            ]),
          ))
        : const Loader("Getting food menu 🥳");
  }

  Widget FoodTile(food, cart) {
    final docId = widget.docId;
    final updateCartCount = widget.updateCartCount;
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
                            child: AddToCartButton(updateCartCount,
                                widget.count, food, docId, cart)),
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
              onChanged: (value) {
                widget.updateSearchTerm(value);
              },
              controller: _controller,
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
