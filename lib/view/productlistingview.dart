import 'package:apibloc/service/databasehelper.dart';
import 'package:apibloc/view/productdetail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products_bloc.dart';
import '../models/Products.dart';

class ProductsListingView extends StatefulWidget {
  const ProductsListingView({super.key});

  @override
  State<ProductsListingView> createState() => _ProductsListingViewState();
}

class _ProductsListingViewState extends State<ProductsListingView> {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper=DatabaseHelper();
    return Scaffold(

        body:
        BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
          if (state is ProductLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          else if (state is ProductLoaded) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height*2,
                child: Column(children: [
                  Container(
                    height: 280,
                    child: CarouselSlider(
                        items:state.plist.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xffeef6eb),

                                    image:  DecorationImage(
                                      image: NetworkImage('${i.thumbnail}'),
                                      fit: BoxFit.fill,
                                    ),
                                    border: Border.all(
                                      width: .4,
                                      color: Color(0xffdddcdc)
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
  child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Buy @ just Rs:${i.price}',style: TextStyle(fontWeight: FontWeight.w800,),)
                                ],
                              ),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 250,
                          aspectRatio: 16/9,
                          viewportFraction: 0.95,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,

                          scrollDirection: Axis.horizontal,
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(alignment: Alignment.centerLeft,
                        child: Text("All Products",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900,fontSize: 20))),
                  ),
                  Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: GridView.builder(
                           // physics: NeverScrollableScrollPhysics(),
                            itemCount: state.plist.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                            mainAxisExtent: 200),
                            itemBuilder: (BuildContext context, int index) {
                              Products p=state.plist[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  ProductdetailView(product:p)),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  Color(0xffffffff),
                                      border: Border.all(
                                        width: .5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child:  Stack(
                                      children: [
                                        Card(
                                          child: Container(
                                            height: 120,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:  Color(0xffffffff),

                                              image:  DecorationImage(
                                                image: NetworkImage('${p.thumbnail}'),
                                                fit: BoxFit.fitHeight,
                                              ),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                            ),


                                          ),
                                        ),
                                        Positioned(
                                            top: 130,
                                            left: 10,
                                            child: Text("${p.title}",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black,fontSize: 14),)),
                                        Positioned(
                                            top: 150,
                                            left: 10,
                                            child: Text("Rs.${p.price}",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green,fontSize: 14),)),
                                        Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: Container(width: 80,
                                              child: InkWell(


                                                onTap: () async {
                                                  var s=await databaseHelper.isProductInCart(int.parse('${p.id}')) ;
                                                  if(s){
                                                    databaseHelper.incrementCartCount(int.parse('${p.id}'));
                                                  }else{
                                                    setState(() {
                                                      p.cartCount=1;
                                                    });
                                                    databaseHelper.insertProduct(p.toJsonDb());
                                                  }
                                                },child: Container(
                                                  decoration: BoxDecoration(
                                                    color:  Color(0xff1c420f),
                                                    border: Border.all(
                                                      width: .5,
                                                    ),
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                height: 25,
                                                  width: 35,
                                                  child: Center(child: Text("ADD",style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 14))))),
                                            )),


                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },),
                        ),
                      )
                  )
                ],),
              ),
            );
            // return GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //   itemCount: state.plist.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return ListTile(
            //       leading: CircleAvatar(backgroundImage: NetworkImage('${state.plist[index].thumbnail}'),),
            //       title: Text("${state.plist[index].title}"),
            //       subtitle: Text("${state.plist[index].price}"),
            //     );
            //   },
            // );
          }
          else if (state is ProductLoadingError) {
            return Text("${state.ErrorMsg}");
          } else {
            return Container();
          }
        }));
  }
}