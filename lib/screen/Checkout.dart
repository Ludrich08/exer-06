// checkout.dart

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/Item.dart';
import '../provider/shoppingcart_provider.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;

    // Calculate total price of all items in the cart
    double total = products.fold(0, (previousValue, element) => previousValue + element.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text("Item Details", textAlign: TextAlign.center),
            ),
            products.isEmpty
                ? Center(
                    child: Text("Shopping cart is empty"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(products[index].name),
                        subtitle:
                            Text("Price: ${products[index].price}"),
                      );
                    },
                  ),
            SizedBox(height: 20), // Add some spacing between the list and the total
            Text(
              "Total: ${total.toStringAsFixed(2)}", // Display total with two decimal places
            ),
          ],
        ),
      ),
      bottomNavigationBar: products.isEmpty
        ? null // Set to null when no items in the cart to hide the BottomAppBar
        : BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement payment logic here
                // For example, you can navigate to a payment screen
                // After successful payment, set total to zero and display "Payment Successful" prompt
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Payment Successful'),
                  ),
                );
                // Set total to zero
                context.read<ShoppingCart>().removeAll();
              },
              child: Text("Pay Now"),
            ),
          ),
        ),
    );
  }
}
