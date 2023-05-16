import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shoppingcartapp/models/Item.dart';

class AddToCartNotifier extends ChangeNotifier{
  final List<Item> _items=[];
  final List<Item> _itemsOnCart=[];
  int _totalItems=0;
  bool addedToCart=false;


  UnmodifiableListView<Item> get items=>UnmodifiableListView(_items);
  UnmodifiableListView<Item> get itemsOnCart=>UnmodifiableListView(_itemsOnCart);
  int get totalItems=>_totalItems;


  void addItem(Item item){
    _items.add(item);
    notifyListeners();
  }

  void removeAll(){
    _items.clear();
    notifyListeners();
  }


  void addToCart(Item item){
      _itemsOnCart.add(item);
      item.addedToCart=true;
      _totalItems++;
      notifyListeners();
  }

    void removeFromCart(int id){
      for(Item item in _itemsOnCart){
          if(item.id==id){
            item.addedToCart=false;
            notifyListeners();
          }
      }
      _itemsOnCart.removeWhere((item) => item.id==id);
      _totalItems--;
      notifyListeners();
  }
}