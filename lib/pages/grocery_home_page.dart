import 'package:carritodecomprasdefrutas/bloc/grocery_provider.dart';
import 'package:carritodecomprasdefrutas/bloc/grocery_store_bloc.dart';
import 'package:carritodecomprasdefrutas/pages/grocery_list_page.dart';
import 'package:carritodecomprasdefrutas/pages/grocery_store_cart.dart';
import 'package:flutter/material.dart';

const backgroundColor=Color(0xFFF6F5F2);
const cartBarHeight = 100.0;
const _panelTransition = Duration(milliseconds: 500);

class GroceryHomePage extends StatefulWidget {
  @override
  _GroceryHomePageState createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {

  final bloc = GroceryStoreBloc();

  void _onVerticalGesture(DragUpdateDetails details){
    print(details.primaryDelta);
    if(details.primaryDelta < -7){
      bloc.changeToCart();
    }else if(details.primaryDelta > 12){
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size){
    if(state==GroceryState.normal){
      return -cartBarHeight + kToolbarHeight+30;  
    }else if(state==GroceryState.cart){
      return - (size.height - kToolbarHeight) - cartBarHeight / 2;
    }
    return 0.0;
  }

  double _getTopForBlackPanel(GroceryState state, Size size){
    if(state==GroceryState.normal){
      return size.height - cartBarHeight+30;  
    }else if(state==GroceryState.cart){
      return cartBarHeight / 2;
    }
    return 0.0;
  }

  double _getTopForAppBar(GroceryState state){
    if(state==GroceryState.normal){
      return 0.0;  
    }else if(state==GroceryState.cart){
      return -cartBarHeight;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GroceryProvider(
        bloc: bloc,
        child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _ ) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                AnimatedPositioned(
                  duration: _panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: _getTopForWhitePanel(bloc.groceryState, size),
                  height: size.height - kToolbarHeight, 
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: GroceryListPage(),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: _getTopForBlackPanel(bloc.groceryState, size),
                  height: size.height - kToolbarHeight,
                  child: GestureDetector(
                    onVerticalDragUpdate: _onVerticalGesture,
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AnimatedSwitcher(
                              duration: _panelTransition,
                                child: SizedBox(
                                height: kToolbarHeight,
                                child: bloc.groceryState == GroceryState.normal? Row(
                                children: [
                                  Text('Cart', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20)),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: const  EdgeInsets.symmetric(horizontal: 8.0), 
                                        child: Row(
                                          children: List.generate(
                                            bloc.cart.length, 
                                            (index) => Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: NetworkImage(bloc.cart[index].product.image),
                                              ),
                                            )
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Color(0xFFF4C459),
                                    child: Text(bloc.totalCartElements().toString()),
                                  ),
                                ],
                              ) : const SizedBox.shrink(),
                              )
                            ),
                          ),
                          Expanded(child: GroceryStoreCart()),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _panelTransition,
                  curve: Curves.decelerate,
                  left: 0,
                  right: 0,
                  top: _getTopForAppBar(bloc.groceryState),
                  child: _AppBarGrocery(),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class _AppBarGrocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: kToolbarHeight+30,    
      child: Row(
        children: [
          BackButton(
            color: Colors.black,  
            onPressed: ()=> Navigator.of(context).pop(),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text('Fruits and Vegetables', style: TextStyle(color: Colors.black),)
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: ()=>null
          ),
        ],
      ),
    );
  }
}