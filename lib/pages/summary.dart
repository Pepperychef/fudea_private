
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(

          ),

        ),
      ),
    );
  }


}