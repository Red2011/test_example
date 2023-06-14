import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget{
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Text('account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
  }
}