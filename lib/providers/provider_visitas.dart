

import 'package:flutter/cupertino.dart';

import '../data/entities/visit.dart';

class ProviderVisitas with ChangeNotifier{

  List<Visit> visits;

  ProviderVisitas({required this.visits});


}