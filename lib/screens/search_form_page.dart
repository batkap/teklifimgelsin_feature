import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teklifimgelsin_feature/blocs/loan_bloc.dart';
import 'package:teklifimgelsin_feature/widgets/dashed_slider_track_shape.dart';
import 'package:teklifimgelsin_feature/widgets/slider_component_thumb_shape.dart';
import 'package:teklifimgelsin_feature/models/loan_request.dart';
import 'package:teklifimgelsin_feature/screens/result_listing_page.dart';

class SearchFormPage extends StatefulWidget {
  const SearchFormPage({super.key});
  @override
  State<SearchFormPage> createState() => _SearchFormPageState();
}

class _SearchFormPageState extends State<SearchFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController(text: '30.000');
  final _maturityController = TextEditingController(text: '36');
  double _amountSliderValue = 30000.0;
  double _maturitySliderValue = 36.0;

  String get _maturitySuffixText {
    final maturityValue = _maturitySliderValue.toInt();
    final blankSpaces = maturityValue >= 10
        ? '                            '
        : '                              ';
    return 'Ay $blankSpaces';
  }

  String _formatAmount(double amount) {
    final formattedAmount = amount.toStringAsFixed(0);
    final buffer = StringBuffer();

    for (int i = formattedAmount.length - 1; i >= 0; i--) {
      buffer.write(formattedAmount[i]);
      if ((formattedAmount.length - i) % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }

    return buffer.toString().split('').reversed.join();
  }

  int _parseAmount(String formattedAmount) {
    final cleanedAmount = formattedAmount.replaceAll('.', '');
    return int.parse(cleanedAmount);
  }

  String? _validateAmountAndMaturity(String amountValue, String maturityValue) {
    final amount = _parseAmount(amountValue);
    final maturity = int.parse(maturityValue);

    if (amount > 100000 && maturity > 12) {
      return 'BDDK kararları gereğince 100.000 TL ve üzeri krediler için maksimum vade 12 ay ile sınırlandırılmıştır.';
    } else if (amount >= 50000 && amount <= 100000 && maturity > 24) {
      return 'BDDK kararları gereğince 50.000 ve 100.000 TL aralığındaki krediler için maksimum vade 24 ay ile sınırlandırılmıştır.';
    } else if (amount < 1000) {
      return 'Girilen tutar en az ₺1.000 olmalıdır.';
    }

    return null;
  }

  @override
  Widget build(BuildContext contexsxt) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        title: const Text('İhtiyaç Kredisi'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: IntrinsicHeight(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorColor: const Color.fromRGBO(59, 180, 172, 0.9),
                      // cursorHeight: 22, ---> MIGHT BE ADJUSTED LATER
                      decoration: InputDecoration(
                        errorMaxLines: 3,
                        prefixText: '₺',
                        prefixStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(59, 180, 172, 0.9),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(157, 157, 157, 0.16),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(59, 180, 172, 0.9),
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                          child: Container(
                            width: 75,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(59, 180, 172, 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.shade500, width: 0.45)),
                            child: const Text(
                              'Tutar',
                              style: TextStyle(
                                color: Color.fromRGBO(59, 180, 172, 0.9),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 70,
                          maxWidth: 70,
                          minHeight: 34,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NOT SUPPOSED TO BE EMPTY';
                        } else {
                          return _validateAmountAndMaturity(
                              value, _maturityController.text);
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          final amount = value.isNotEmpty
                              ? (int.parse(value) >= 300000
                                  ? 300000
                                  : int.parse(value))
                              : 0;

                          _amountController.text =
                              _formatAmount(amount.toDouble());
                          _amountSliderValue = amount.toDouble();
                        });
                      },
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const SliderComponentThumbShape(
                          thumbRadius: 8,
                          borderThickness: 3,
                          borderColor: Colors.white,
                        ),
                        trackShape: DashedSliderTrackShape(
                          inactiveTrackColor: Colors.grey.shade300,
                          activeTrackColor:
                              const Color.fromRGBO(59, 180, 172, 0.9),
                        ),
                      ),
                      child: Slider(
                        value: _amountSliderValue < 1000
                            ? 1000
                            : (_amountSliderValue > 300000
                                ? 300000
                                : _amountSliderValue),
                        min: 1000,
                        max: 300000,
                        divisions: 299,
                        activeColor: const Color.fromRGBO(59, 180, 172, 0.9),
                        onChanged: (value) {
                          setState(() {
                            _amountController.text = _formatAmount(value);
                            _amountSliderValue = value;
                          });
                        },
                      ),
                    ),
                    // const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _maturityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorColor: const Color.fromRGBO(59, 180, 172, 0.9),
                      // cursorHeight: 22, ---> MIGHT BE ADJUSTED LATER
                      decoration: InputDecoration(
                        suffixText: _maturitySuffixText,
                        suffixStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(31, 93, 88, 0.9),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(157, 157, 157, 0.16),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(59, 180, 172, 0.9),
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                          child: Container(
                            width: 75,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(59, 180, 172, 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.shade500, width: 0.45)),
                            child: const Text(
                              'Vade',
                              style: TextStyle(
                                color: Color.fromRGBO(59, 180, 172, 0.9),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 70,
                          maxWidth: 70,
                          minHeight: 34,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NOT SUPPOSED TO BE EMPTY!';
                        } else {
                          final maturity = int.parse(value);
                          if (maturity < 1) {
                            return 'Girilen vade en az 1 ay olmalıdır.';
                          }
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          final maturity = value.isNotEmpty
                              ? (int.parse(value) >= 36 ? 36 : int.parse(value))
                              : 0;

                          _maturityController.text = maturity.toString();
                          _maturitySliderValue = maturity.toDouble();
                        });
                      },
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: const SliderComponentThumbShape(
                          thumbRadius: 8,
                          borderThickness: 3,
                          borderColor: Colors.white,
                        ),
                        trackShape: DashedSliderTrackShape(
                          inactiveTrackColor: Colors.grey.shade300,
                          activeTrackColor:
                              const Color.fromRGBO(59, 180, 172, 0.9),
                        ),
                      ),
                      child: Slider(
                        value: _maturitySliderValue < 1
                            ? 1
                            : (_maturitySliderValue > 36
                                ? 36
                                : _maturitySliderValue),
                        min: 1,
                        max: 36,
                        divisions:
                            100, // ---> LARGE NUMBER TO AVOID SLIDER AUTO DOTS ON TRACK SHAPE
                        activeColor: const Color.fromRGBO(59, 180, 172, 0.9),
                        onChanged: (value) {
                          setState(() {
                            _maturityController.text = value.toInt().toString();
                            _maturitySliderValue = value;
                          });
                        },
                      ),
                    ),
                    // const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final amount = _parseAmount(_amountController.text);
                          final maturity = int.parse(_maturityController.text);
                          final request =
                              LoanRequest(amount: amount, maturity: maturity);
                          BlocProvider.of<LoanBloc>(context)
                              .add(FetchLoanOffers(request));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ResultListingPage()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        backgroundColor:
                            const Color.fromRGBO(59, 180, 172, 0.9),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'TeklifimGelsin',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
