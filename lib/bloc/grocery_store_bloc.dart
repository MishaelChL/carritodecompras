import 'package:carritodecomprasdefrutas/data/grocery_product.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

enum GroceryState{  //Existirá 3 estados
  normal,
  details,
  cart,
} 

class GroceryStoreBloc with ChangeNotifier{

  GroceryState groceryState = GroceryState.normal;  //inicializamos acá

  List<GroceryProduct> catalog = groceryProducts;

  List<GroceryProductItem> cart = [];

  void changeToNormal(){  //Creamos void que nos ayudara a cambiar a estado normal
    groceryState = GroceryState.normal; 
    notifyListeners();
  }

  void changeToCart(){  //Creamos void que nos ayudara a cambiar a estado cart
    groceryState = GroceryState.cart; 
    notifyListeners();
  }

  void addProduct(GroceryProduct product){
    for(GroceryProductItem item in cart){
      if(item.product.name == product.name){
        // item.increment();
        // notifyListeners();
        return ;
      }
    }
    cart.add(GroceryProductItem(product: product));
    notifyListeners();
  }

  void deleteProduct(GroceryProductItem productItem){
    cart.remove(productItem);
    notifyListeners();
  }

  int totalCartElements() =>  cart.fold<int>(0, (previousValue, element) => previousValue + element.quantity);

  double totalPriceElements() =>  cart.fold<double>(0.0, (previousValue, element) => previousValue + (element.quantity * element.product.price));

}


class GroceryProductItem{
  
  GroceryProductItem({this.quantity = 1,@required this.product});

  int quantity;
  final GroceryProduct product;

  void increment(){
    quantity++;
  }


}