import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kPrimaryTextStyle = GoogleFonts.getFont(
  'Montserrat',
  fontSize: 23,
  fontWeight: FontWeight.bold,
);

final kSecondTextStyle = GoogleFonts.getFont(
  'Montserrat',
  fontSize: 21,
  fontWeight: FontWeight.bold,
);

final kThirdTextStyle = GoogleFonts.getFont(
  'Montserrat',
  fontSize: 19,
  fontWeight: FontWeight.bold,
);

enum CalModes { income, expense }

enum AccountingTypes {
  luxury,
  drink,
  food,
  daily,
  traffic,
  salary,
  stock,
  passive,
  nil,
}

extension AccountingTypesExtension on AccountingTypes {
  static AccountingTypes fromString(String type) {
    switch (type) {
      case 'luxury':
        return AccountingTypes.luxury;
      case 'drink':
        return AccountingTypes.drink;
      case 'food':
        return AccountingTypes.food;
      case 'daily':
        return AccountingTypes.daily;
      case 'traffic':
        return AccountingTypes.traffic;
      case 'salary':
        return AccountingTypes.salary;
      case 'stock':
        return AccountingTypes.stock;
      case 'passive':
        return AccountingTypes.passive;
      default:
        return AccountingTypes.nil;
    }
  }
}