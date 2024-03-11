import 'dart:math';
import 'package:teklifimgelsin_feature/models/loan_request.dart';

class LoanOffer {
  final String bankName;
  final double annualExpenseRate;
  final int bankId;
  final String bankType;
  final String productName;
  final double interestRate;
  final String url;
  final int maturity;
  final int amount;

  LoanOffer({
    required this.bankName,
    required this.annualExpenseRate,
    required this.bankId,
    required this.bankType,
    required this.productName,
    required this.interestRate,
    required this.url,
    required this.maturity,
    required this.amount,
  });

  factory LoanOffer.fromJson(Map<String, dynamic> json, LoanRequest request) {
    return LoanOffer(
      bankName: json['bank'] as String,
      annualExpenseRate: json['annual_rate'] as double,
      bankId: json['bank_id'] as int,
      bankType: json['bank_type'] as String,
      productName: json['product_name'] as String,
      interestRate: json['interest_rate'] as double,
      url: json['url'] as String,
      maturity: request.maturity,
      amount: request.amount,
    );
  }

  double get monthlyPayment {
    final totalInterestRate = interestRate * 0.013;
    final exponent = maturity;
    final base = 1 + totalInterestRate;
    final numerator = amount * totalInterestRate * pow(base, exponent);
    final denominator = pow(base, exponent) - 1;
    return numerator / denominator;
  }

  double get totalCost {
    return monthlyPayment * maturity;
  }

  int get id {
    return bankId + 787 * Random().nextInt(1000) + 787 * Random().nextInt(1000);
  }
}
