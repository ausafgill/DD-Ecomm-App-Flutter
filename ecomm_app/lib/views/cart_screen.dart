import 'package:ecomm_app/utils/provider/cartprovider.dart';
import 'package:ecomm_app/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double _total = CartProvider.getTotal;
    return Consumer<CartProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrange,
          title: Text('My Cart'),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: value.cart.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            value.cart[index].imgPath,
                          ),
                          title: Text(
                            value.cart[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            value.cart[index].price,
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: InkWell(
                              onTap: () {
                                final cartData = context.read<CartProvider>();
                                cartData.removeFromCart(value.cart[index]);
                              },
                              child: Icon(Icons.delete)),
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(25),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrange,
                ),
                child: InkWell(
                  onTap: () {
                    if (CartProvider.getTotal > 0.0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                    getTotal: _total,
                                  )));
                    } else {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor: Colors.deepOrange,
                                content: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text('Go Back to Shopping',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                title: Text(
                                  'No Data in Cart',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Pay Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                      Text(
                        '\$ ${CartProvider.getTotal.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
