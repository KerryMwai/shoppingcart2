import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shoppingcartapp/cart_items.dart';
import 'package:shoppingcartapp/controller/add_to_cart_notifer.dart';
import 'package:shoppingcartapp/controller/counter_notifier.dart';
import 'package:shoppingcartapp/models/Item.dart';

void main() {
  runApp(
    MultiProvider( providers: [
            ChangeNotifierProvider(create: (_) => CounterNotifier()),
            ChangeNotifierProvider(create: (_) => AddToCartNotifier())
          ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
 MyHomePage();

  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 8),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -10),
                badgeAnimation: const badges.BadgeAnimation.slide(
                  disappearanceFadeAnimationDuration:
                      Duration(milliseconds: 200),
                  curve: Curves.easeInCubic,
                ),
                badgeContent: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Consumer<AddToCartNotifier>(
                      builder: (context, value, child) => Text(
                        value.totalItems.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.4,
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    key: const Key("ProductName"),
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product name',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    key: const Key("ProductDescription"),
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product description',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        key: const Key("addButton"),
                        onPressed: () {
                          if(nameController.text.isEmpty || descriptionController.text.isEmpty) return;
                          context.read<AddToCartNotifier>().addItem(Item(
                              id: context
                                      .read<AddToCartNotifier>()
                                      .items
                                      .length +
                                  1,
                              name: nameController.text,
                              description: descriptionController.text));
                          nameController.clear();
                          descriptionController.clear();
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: Text("Add"),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: Text("View Cart items"),
                        ))
                  ],
                )
              ]),
            ),
            Expanded(
                child: ListView(
              children: List.generate(
                  context.watch<AddToCartNotifier>().items.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<AddToCartNotifier>(
                                  builder: (context, value, child) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: size.width * 0.6,
                                              child: Text(
                                                maxLines: 1,
                                                value.items[index].name,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                              width: size.width * 0.6,
                                              child: Text(
                                                maxLines: 2,
                                                value.items[index].description,
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                ),
                                              )),
                                        ],
                                      )),
                              context
                                      .watch<AddToCartNotifier>()
                                      .items[index]
                                      .addedToCart
                                  ? Consumer<AddToCartNotifier>(
                                      builder: (context, value, child) =>
                                          IconButton(
                                              onPressed: () {
                                                value.removeFromCart(value.items[index].id);
                                              },
                                              icon: const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                size: 30,
                                              )),
                                    )
                                  : Consumer<AddToCartNotifier>(
                                      builder: (context, value, child) =>
                                          TextButton(
                                              onPressed: () {
                                                value.addToCart(
                                                    value.items[index]);
                                              },
                                              child: const Text(
                                                "Add item",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                    )
                            ]),
                      )),
            ))
          ],
        ));
  }
}
