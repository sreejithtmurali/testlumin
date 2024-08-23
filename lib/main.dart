import 'package:apibloc/bloc/products_bloc.dart';
import 'package:apibloc/view/productlistingview.dart';
import 'package:apibloc/view/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyBUaDsTc0tQ5VM2nf5WdJV_BaDJ1Uq54jM",
          appId: "1:714034921609:android:683fbc759b169c85038658",
          messagingSenderId: "714034921609",
          projectId: "othphone-cf5a4")
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ProductsBloc>(
        create: (BuildContext context) =>
            ProductsBloc()..add(ProductsLoadedEvent()),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}


