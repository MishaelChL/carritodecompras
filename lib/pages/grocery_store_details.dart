import 'package:cached_network_image/cached_network_image.dart';
import 'package:carritodecomprasdefrutas/data/grocery_product.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class GroceryStoreDetails extends StatefulWidget {

  const GroceryStoreDetails({Key key, @required this.product, this.onProductAdded}) : super(key: key);

  final GroceryProduct product;

  final VoidCallback onProductAdded;

  @override
  _GroceryStoreDetailsState createState() => _GroceryStoreDetailsState();
}

class _GroceryStoreDetailsState extends State<GroceryStoreDetails> {
  String heroTag = '';

  void _addToCart(BuildContext context){
    setState(() {
      heroTag = 'details';
    });
    widget.onProductAdded();
    Navigator.of(context).pop();
  }

  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GestureDetector(
                        onScaleStart: (ScaleStartDetails details) {
                          // print(details);
                          _previousScale = _scale;
                          setState(() {});
                        },
                        onScaleUpdate: (ScaleUpdateDetails details) {
                          // print(details);
                          _scale = _previousScale * details.scale;
                          setState(() {});
                        },
                        onScaleEnd: (ScaleEndDetails details) {
                          // print(details);

                          _previousScale = 1.0;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: Image.network(
                          //   widget.product.image, 
                          //   fit: BoxFit.fill,
                          //   height: MediaQuery.of(context).size.height * 0.36,
                          // ),
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                            child: CachedNetworkImage(
                              imageUrl: widget.product.image,
                              fit: BoxFit.fitWidth,
                              color: Colors.red[200],
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.product.name, 
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black,fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        '\$${widget.product.price}', 
                        style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'NOTA: POR SEGURIDAD HEMOS IMPLEMENTADO EL FONDO ROJO, CUANDO LO COMPRÉ YA NO HABRÁ ESE FONDO ROJO, SALUDOS...', 
                    style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 10)
                  ),
                ],
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.black
                    ), 
                    onPressed: () => null
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: RaisedButton(
                    color: Color(0xFFF4C459),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text('Add to Cart', style: TextStyle(color: Colors.black)),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: ()=>_addToCart(context),
                  ) 
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}