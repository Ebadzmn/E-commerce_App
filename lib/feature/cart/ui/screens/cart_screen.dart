import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String name = '/cart-list';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  void IncrementQuantity(int index) {
    cartItem[index]['quantity']++;
    setState(() {});
  }

  void DecrementQuantity(int index) {
    cartItem[index]['quantity']--;
    setState(() {});
  }

  List<Map<String,dynamic>> cartItem = [
    {'name' : 'product1' , 'price' : 20 , 'quantity' : 1},
    {'name' : 'product3' , 'price' : 40 , 'quantity' : 1},
  ];

  double getTotalPrice () {
    double total = 0;
    for (var item in cartItem) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemCount: cartItem.length,itemBuilder: (context,index) {
              var item = cartItem[index];
              return ListTile(
                title: Text(item['name']),
                subtitle: Text('\$${item['price']} | Total : \$${item['price'] * item['quantity']} '), // You can also add the dollar sign
                trailing: SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () => IncrementQuantity(index), icon: Icon(Icons.add)),
                      Text('${item['quantity']}'),
                      IconButton(onPressed: () => DecrementQuantity(index), icon: Icon(Icons.remove)),
                    ],
                  ),
                ),
              );
            }),
          ),
          Padding(padding: EdgeInsets.all(5), child: Text('Total Price : \$${getTotalPrice()}'),)
        ],
      ),
    );
  }
}


