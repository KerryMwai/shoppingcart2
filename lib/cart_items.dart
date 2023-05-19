import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcartapp/constants/color.dart';
import 'package:shoppingcartapp/controller/add_to_cart_notifer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon:const Icon(Icons.arrow_back_ios, color: black,)),
        title: const Text(
          "Cart Items",
          style: TextStyle(color: black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: List.generate(
            context.watch<AddToCartNotifier>().itemsOnCart.length, (index) {
          return Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<AddToCartNotifier>(
                          builder: (context, value, child) => Text(
                            value.itemsOnCart[index].name,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<AddToCartNotifier>(
                          builder: (context, value, child) => Text(
                            value.itemsOnCart[index].description,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ]),
                  Row(
                    children: [
                      Consumer<AddToCartNotifier>(builder: (context, item,child){
                          return IconButton(
                          onPressed: ()=>item.decrementItem(item.itemsOnCart[index].id),
                          icon: const Icon(
                            Icons.remove,
                            size: 30,
                            color: red,
                          ));
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<AddToCartNotifier>(
                        builder: (context, value, child) => Text(
                          "${value.itemsOnCart[index].itemCount}",
                          style: const TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<AddToCartNotifier>(builder: (context, item,child){
                          return IconButton(
                          onPressed: ()=>item.incrementItem(item.itemsOnCart[index].id),
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                            color: green,
                          ));
                      }),
                  
                    ],
                  )
                ]),
          );
        }),
      ),
    );
  }
}
