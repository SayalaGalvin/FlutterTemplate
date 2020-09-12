import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobi_pharmacy_project/sidebar_layout.dart';
import 'auth.dart';

class Session extends StatefulWidget {
  Session({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  static void logOut() {
    _sessionState()._signOut();
  }

  @override
  State<StatefulWidget> createState() => new _sessionState();
}

class _sessionState extends State<Session> {
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

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        /*appBar: new AppBar(
          title: new Text("Flutter Template"),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Logout', style: new TextStyle(fontSize: 20)),
                onPressed: _signOut)
          ],
        ),*/
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("Users")
                .document(name)
                .collection("User_details")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading");
                  default:
                    return checkRole(snapshot.data);
                }
            }));
  }

  Center checkRole(QuerySnapshot snapshot) {
    if (snapshot.documents[0].data['UserType'] == "Pharmacy") {
      return Pharmacy(snapshot);
    } else if (snapshot.documents[0].data['UserType'] == "Patient") {
      return Patient(snapshot);
    } else {
      return Admin(snapshot);
    }
  }

  Center Patient(QuerySnapshot snapshot) {
    return Center(
        child: SideBarLayout(
            auth: this.widget.auth,
            onSignedOut: this.widget.onSignedOut,
            type: snapshot.documents[0].data[
                'UserType']) //Text(snapshot.documents[0].data['UserType']),
        );
  }

  Center Pharmacy(QuerySnapshot snapshot) {
    //SideBarLayout();
    return Center(
        child: SideBarLayout(
            auth: this.widget.auth,
            onSignedOut: this.widget.onSignedOut,
            type: snapshot.documents[0].data[
                'UserType']) //Text(snapshot.documents[0].data['UserType']),
        );
  }

  Center Admin(QuerySnapshot snapshot) {
    return Center(
        child: SideBarLayout(
            auth: this.widget.auth,
            onSignedOut: this.widget.onSignedOut,
            type: snapshot.documents[0].data['UserType'])
        // child: Text(snapshot.documents[0].data['UserType']),
        );
  }
}
