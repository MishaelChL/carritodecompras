import 'package:carritodecomprasdefrutas/bloc/grocery_provider.dart';
import 'package:carritodecomprasdefrutas/pages/grocery_home_page.dart';
import 'package:carritodecomprasdefrutas/pages/grocery_store_details.dart';
import 'package:carritodecomprasdefrutas/widget/staggered_dual_view_widget.dart';
import 'package:flutter/material.dart';

class GroceryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context).bloc;
    // return ListView.builder(
    //   padding: const EdgeInsets.only(top: cartBarHeight),
    //   itemCount: bloc.catalog.length,
    //   itemBuilder: (context, index){
    //     return Container(
    //       height: 100,
    //       width: 100,
    //       color: Colors.primaries[index % Colors.primaries.length],
    //     );
    //   },
    // );
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(top: cartBarHeight, left: 10, right: 10),
      child: StaggeredDualView(
        aspectRatio: 0.7,
        offsetPercent : 0.3,
        spacing: 20,
        itemBuilder: (context, index){
          final product = bloc.catalog[index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(
                    milliseconds: 900
                  ), 
                  pageBuilder: (context, animation, __){
                    return FadeTransition(
                      opacity: animation,
                      child: GroceryStoreDetails(
                        product: product,
                        onProductAdded: (){
                          bloc.addProduct(product);
                        }
                      )
                    );
                  }
                )
              );
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              elevation: 8,
              shadowColor: Colors.black45,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                      product.image, 
                      fit: BoxFit.contain,
                        ),
                    ),
                    SizedBox(height: 10),
                    Text('${product.name}',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                     ),
                    ),
                    SizedBox(height: 10),
                    Text('\$${product.price}',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                     ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: bloc.catalog.length,
      ),
    );
  }
}