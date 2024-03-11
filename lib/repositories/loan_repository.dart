import 'package:teklifimgelsin_feature/models/loan_offer.dart';
import 'package:teklifimgelsin_feature/models/loan_request.dart';
import 'package:teklifimgelsin_feature/services/api_service.dart';

class LoanRepository {
  final ApiService _apiService = ApiService();

  Future<List<LoanOffer>> fetchLoanOffers(LoanRequest request) async {
    return await _apiService.fetchLoanOffers(request);
  }
}
