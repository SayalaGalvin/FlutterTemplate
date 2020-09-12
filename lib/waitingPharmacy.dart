import 'package:flutter/material.dart';
import 'package:mobi_pharmacy_project/auth.dart';
import 'package:mobi_pharmacy_project/navigation_bloc.dart';

class WaitingPharmacy extends StatefulWidget with NavigationStates {
  final BaseAuth auth;
  WaitingPharmacy(this.auth);
  @override
  State<StatefulWidget> createState() => new _WaitingPharmacyState();
}

class _WaitingPharmacyState extends State<WaitingPharmacy> {
  String name;
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser.then((userid) {
      setState(() {
        name = userid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
