import 'package:apibloc/view/cartview.dart';
import 'package:apibloc/view/productlistingview.dart';
import 'package:apibloc/view/profileview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex=0;
  void updateindex(int index){
    setState(() {
      currentIndex=index;
    });
  }
  List<Widget>pages=[
    ProductsListingView(),
    CartView(),
    Profileview()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Home",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFF1C420F), // Selected item color
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          updateindex(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_cal),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
