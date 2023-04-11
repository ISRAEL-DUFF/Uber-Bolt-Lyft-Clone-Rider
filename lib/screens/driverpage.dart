import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/screens/registrationpage.dart';
import 'package:cab_rider/widgets/ProgressDialog.dart';
import 'package:cab_rider/widgets/TaxiButton.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

import '../rideVariables.dart';

class DriverPage extends StatefulWidget {
  static const String id = 'driver';

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void acceptRide() async {
    //show dialog
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Accepting Ride...',
      ),
    );
    DatabaseReference rideRef =
          FirebaseDatabase.instance.reference().child('rideRequest/$currentRideKey');
    rideRef.update({
      "status": "accepted",
      "car_details": "A good looking car close to you",
      "driver_name": "John Doe",
      "driver_phone": "08035758473",
      "driver_location": {
        "longitude": 1,
        "latitude": 2
      }
    });

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void setDriverStatus(String driverStatus) async {
    //show dialog

    if (driverStatus != "ended") {
      showDialog(
            context: context,
            builder: (BuildContext context) => ProgressDialog(
              status: 'Setting status...',
            ),
          );
    }
    
    DatabaseReference rideRef =
          FirebaseDatabase.instance.reference().child('rideRequest/$currentRideKey');
    await rideRef.update({
      "status": driverStatus,
      "fares": currentRideFare
    });


    if(driverStatus != 'ended') {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Image(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  image: AssetImage('images/logo.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Driver Status',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      // TextField(
                      //   controller: emailController,
                      //   keyboardType: TextInputType.emailAddress,
                      //   decoration: InputDecoration(
                      //     labelText: 'Your name',
                      //     labelStyle: TextStyle(
                      //       fontSize: 14,
                      //     ),
                      //     hintStyle: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 10,
                      //     ),
                      //   ),
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // TextField(
                      //   controller: passwordController,
                      //   //  keyboardType: TextInputType.visiblePassword,
                      //   decoration: InputDecoration(
                      //       labelText: 'Car Details',
                      //       labelStyle: TextStyle(
                      //         fontSize: 14,
                      //       ),
                      //       hintStyle:
                      //           TextStyle(color: Colors.grey, fontSize: 10)),
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      TaxiButton(
                        title: 'ACCEPT RIDE',
                        color: BrandColors.colorGreen,
                        onPressed: () async {

                          acceptRide();
                        },
                      ),
                      TaxiButton(
                        title: 'Set On-Trip',
                        color: BrandColors.colorBlue,
                        onPressed: () async {

                          setDriverStatus('ontrip');
                        },
                      ),

                      TaxiButton(
                        title: 'Set Arrived Destination',
                        color: BrandColors.colorOrange,
                        onPressed: () async {

                          setDriverStatus('arrived');
                        },
                      ),

                      TaxiButton(
                        title: 'End Trip',
                        color: BrandColors.colorPink,
                        onPressed: () async {

                          setDriverStatus('ended');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
