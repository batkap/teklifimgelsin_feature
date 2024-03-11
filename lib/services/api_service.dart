import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:teklifimgelsin_feature/models/loan_offer.dart';
import 'package:teklifimgelsin_feature/models/loan_request.dart';

class ApiService {
  static const String baseUrl = 'https://api2.teklifimgelsin.com/api';

  Future<List<LoanOffer>> fetchLoanOffers(LoanRequest request) async {
    final url =
        '$baseUrl/getLoanOffers?kredi_tipi=0&vade=${request.maturity}&tutar=${request.amount}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final offers = (jsonData['active_offers'] as List<dynamic>?)
              ?.map((offer) => LoanOffer.fromJson(offer, request))
              .toList() ??
          [];
      return offers;
    } else {
      throw Exception('Failed to fetch loan offers');
    }
  }
}
