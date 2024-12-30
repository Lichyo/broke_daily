import 'package:shared_preferences/shared_preferences.dart';

class InvoiceService {
  static const _invoiceKey = 'invoice_number';

  Future<void> saveInvoiceNumber(String invoiceNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_invoiceKey, invoiceNumber);
  }

  Future<String?> getInvoiceNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_invoiceKey);
  }

  Future<void> removeInvoiceNumber() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_invoiceKey);
  }
}