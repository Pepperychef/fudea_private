import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyVisits extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: const Color.fromRGBO(0, 95, 146, 1),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(

                    ),
                  ),
                  Expanded(flex: 5, child: Container(color: Colors.white)),
                ],
              ),
            ],

          ),

        ),
      ),
    );
  }
}