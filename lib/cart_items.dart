import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcartapp/controller/add_to_cart_notifer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Cart Items"),
        centerTitle: true,
      ),

      body: ListView(
        children: List.generate(context.watch<AddToCartNotifier>().itemsOnCart.length, (index){
          return Card(
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<AddToCartNotifier>(builder: (context, value, child) => Text(value.itemsOnCart[index].name, style:const  TextStyle(fontSize: 18),),),
                    const SizedBox(height: 10,),
                    Consumer<AddToCartNotifier>(builder: (context, value, child) => Text(value.itemsOnCart[index].description, style:const TextStyle(fontSize: 16),),
                  ),
                  ]
                ),
               
                Row(children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.remove, size: 30,)),
                  const SizedBox(width: 15,),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.add, size: 30,))
                ],)
            ]),
          );
        }),
      ),
    );
  }
}