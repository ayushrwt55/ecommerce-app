import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/module/user/screens/payment/upi_pay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../services/Provider/add_to_cart_provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  double subtotal = 0;
  double tax = 0;
  double total = 0;
  String discountCode = '';
  bool isDiscountApplied = false;
  bool isCreditCardSelected = true;
  bool isCodSelected = false;
  bool isUPISelected = false;
  String address = '';

  final _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    subtotal =
        finalList.fold(0, (sum, item) => sum + item.price * item.quantity);
    tax = subtotal * 0.1;
    total = subtotal + tax;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ...finalList.map((item) => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.title),
                                  Text('x${item.quantity}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(''),
                                  Text(
                                      '₹ ${(item.price * item.quantity).toStringAsFixed(2)}'),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal'),
                          Text('₹ $subtotal'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax (10%)'),
                          Text('₹ ${tax.toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total'),
                          Text('₹ ${total.toStringAsFixed(2)}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        'Discount Code',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter discount code',
                        ),
                        onChanged: (value) {
                          setState(() {
                            discountCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (discountCode.isNotEmpty) {
                            setState(() {
                              isDiscountApplied = true;
                              total -= 10;
                            });
                          }
                        },
                        child: const Text('Apply Discount'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your address',
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_addressController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter your address')),
                            );
                          } else {
                            setState(() {
                              address = _addressController.text;
                            });
                          }
                        },
                        child: const Text('Save Address'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        'Payment Options',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Credit Card'),
                          Checkbox(
                            value: isCreditCardSelected,
                            onChanged: (value) {
                              setState(() {
                                isCreditCardSelected = value!;
                                isCodSelected = false;
                                isUPISelected = false;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('CASH ON DELIVERY'),
                          Checkbox(
                            value: isCodSelected,
                            onChanged: (value) {
                              setState(() {
                                isCodSelected = value!;
                                isCreditCardSelected = false;
                                isUPISelected = false;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('UPI'),
                          Checkbox(
                            value: isUPISelected,
                            onChanged: (value) {
                              setState(() {
                                isUPISelected = value!;
                                isCreditCardSelected = false;
                                isCodSelected = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (address.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter your address')),
                    );
                  } else {
                    if (isUPISelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpiPay(
                                  totalprice: total,
                                  onPaymentSuccess: () {
                                    _placeOrder();
                                  },
                                )),
                      );
                    } else if (isCodSelected) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Order Confirmed'),
                          content: const Text(
                              'Your order has been confirmed. Thank you for shopping with us!'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                      _placeOrder();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text('Processing payment...'),
                          content: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimaryColor,
                  padding: EdgeInsets.all(15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _placeOrder() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference _documentReference =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      CollectionReference order = _documentReference.collection("orders");
      final orderData = {
        // 'orderId': orderId,
        'products': Provider.of<CartProvider>(context, listen: false)
            .cart
            .map((product) => {
                  'productName': product.title,
                  'productPrice': product.price,
                  'productQuantity': product.quantity,
                  'productImage': product.image,
                  'productCategory': product.category
                })
            .toList(),
        'totalPrice':
            Provider.of<CartProvider>(context, listen: false).totalPrice(),
        'paymentStatus': 'success',
      };
      order.add(orderData);
    }
  }
}
