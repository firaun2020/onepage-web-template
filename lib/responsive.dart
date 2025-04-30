import 'package:flutter/material.dart';


double returnHeightforSliderImage(BuildContext context) {
  if (MediaQuery.of(context).size.width > 1200) {
    return 300;
  } else if (MediaQuery.of(context).size.width > 800) {
    return  250;
  } else {
    return 200;
  }
}