import 'dart:io';
import 'dart:async';

import 'package:cab_rider/dataproviders/appdata.dart';
import 'package:cab_rider/globalvariables.dart';
import 'package:cab_rider/screens/driverpage.dart';
import 'package:cab_rider/screens/loginpage.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/screens/registrationpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'bolt-clone',
    options: Platform.isIOS
        ? const FirebaseOptions(
            appId: '1:553304875493:android:d8b16e00f6aa678fe40f0c',
            apiKey: 'AIzaSyCq4vD2a0XjllUequk0tRiQ44hSmdeUrss',
            projectId: 'bolt-clone-45f14',
            messagingSenderId: '553304875493',
            databaseURL:
                'https://geetaxi-24ea3-default-rtdb.europe-west1.firebasedatabase.app',
          )
        : const FirebaseOptions( 
            appId: '1:149931963815:android:b9abb8ed8a352f8178f282',
            apiKey: 'AIzaSyBR5gvRUQFjI-CUHfQFSjGQTwtbJzE_92Q',
            projectId: 'bolt-clone-55d4a',
            messagingSenderId: '149931963815',
            databaseURL:
                'https://bolt-clone-55d4a-default-rtdb.firebaseio.com/',
          ),
  );

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Brand-Regular',
          primarySwatch: Colors.blue,
        ),
        initialRoute:
            (currentFirebaseUser == null) ? LoginPage.id : RegistrationPage.id,
        routes: {
          RegistrationPage.id: (context) => RegistrationPage(),
          LoginPage.id: (context) => LoginPage(),
          MainPage.id: (context) => MainPage(),
          DriverPage.id: (context) => DriverPage()
        },
      ),
    );
  }
}
