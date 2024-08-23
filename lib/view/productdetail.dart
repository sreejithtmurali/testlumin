import 'package:apibloc/models/Products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../service/databasehelper.dart';

class ProductdetailView extends StatefulWidget {
  late Products product;
   ProductdetailView({super.key, required this.product});

  @override
  State<ProductdetailView> createState() => _ProductdetailViewState();
}

class _ProductdetailViewState extends State<ProductdetailView> {
  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }



  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void openCheckout(int amt, String title, String discription) async {
    var options = {
      //dynamic key of clint please replace key with ur key
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      //amt in pisa
      'amount': amt * 1,
      'name': title,
      'description': discription,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '999999999', 'email': 'user@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper=DatabaseHelper();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text("${widget.product.title}",style:TextStyle(color: Colors.white),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: EdgeInsets.only(right: 8),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Stack(children: [
                  Positioned(
                    top: 15,
                      child: Container(height: 25,width: 100,
                  color: Colors.green,
                  child: Center(child: Text('${widget.product.discountPercentage}% off',style: TextStyle(color: Colors.white),)),)),
                  Positioned(
                      top: 15,
                      right: 0,
                      child: Container(height: 25,width: 100,
                        color: Colors.transparent,
                        child: Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star,color: Colors.amber,size: 18,),
                            SizedBox(width: 5,),
                            Text('${widget.product.rating}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w800),),
                          ],
                        )),))
                ],),
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffeef6eb),

                  image:  DecorationImage(
                    image: NetworkImage('${widget.product.thumbnail}'),
                    fit: BoxFit.fill,
                  ),
                  border: Border.all(
                      width: .4,
                      color: Color(0xffdddcdc)
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text("${widget.product.title}(${widget.product.brand})",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 18),)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Rs : ${widget.product.price}",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green,fontSize: 18),)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${widget.product.description}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 14),)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("(${widget.product.availabilityStatus})",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.red,fontSize: 13),)),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      )),
                  child: Text("Add To Cart",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white,fontSize: 18),),
                  onPressed: () async {
                    var s=await databaseHelper.isProductInCart(int.parse('${widget.product.id}')) ;
                    if(s){
                      databaseHelper.incrementCartCount(int.parse('${widget.product.id}'));
                    }else{
                      setState(() {
                        widget.product.cartCount=1;
                      });
                      databaseHelper.insertProduct(widget.product.toJsonDb());
                    }
                  },
                ),
              )),
            SizedBox(height: 8,),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(


                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    )),

                    child: Text("Buy Now",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 18),),
                    onPressed: (){
                      openCheckout(int.parse('${widget.product.price}'), widget.product.title.toString(), widget.product.description.toString());
                    },
                  ),
                )),

          ],
        ),
      ),
    );
  }
}
