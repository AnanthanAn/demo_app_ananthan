import 'package:demo_app_ananthan/models/cart.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  void addItemToCart(String prodId, String title, double price) {
    if (_items.containsKey(prodId)) {
      //checking whether product already in cart
      _items.update(
          //updating quantity by 1 if product exists
          prodId,
          (value) => Cart(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price));
    } else {
      _items.putIfAbsent(
          // if product not present in cart adding it
          prodId,
          () => Cart(
              id: prodId,
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  double get totalAmount {
    //calculates total cart amount
    double total = 0;
    _items.forEach((key, value) {
      total += (value.quantity * value.price);
    });
    return total;
  }

  void decreaseQuantityCart(String prodId) {
    if (_items.containsKey(prodId)) {
      //Checking whether product is in cart
      if (_items[prodId].quantity > 1) {
        // Checking quantity is >= 1, then decrease quantity by 1
        _items.update(
            prodId,
            (value) => Cart(
                id: value.id,
                title: value.title,
                quantity: value.quantity - 1,
                price: value.price));
      } else {
        //if quantity <= 1 then remove product from cart
        _items.remove(prodId);
      }
    }
    notifyListeners();
  }

  void clearCart(){
    _items.clear();
    notifyListeners();
  }

  void removeProductFromCart(String pId){
    if(_items.containsKey(pId)){
      _items.remove(pId);
    }
    notifyListeners();
  }
}
