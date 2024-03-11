import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teklifimgelsin_feature/models/loan_offer.dart';

const resultInfoTextStyle = TextStyle(
  fontSize: 13,
  fontFamily: 'arial',
  fontWeight: FontWeight.w400,
);

const resultValueTextStyle = TextStyle(
  fontSize: 13,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.bold,
);

String _formattedInterestRate(double interestRate) {
  String formattedInterestRate = interestRate.toStringAsFixed(2);
  return formattedInterestRate.replaceAll('.', ',');
}

void advertisementPopup(
  BuildContext context,
  LoanOffer offer,
  String advertisementText,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,

        insetPadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),

        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicHeight(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8.0),
                        SizedBox(
                          height: 66,
                          child: Container(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/${offer.bankId}.svg',
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Banka Adı',
                                    style: resultInfoTextStyle),
                                Text(
                                  offer.bankName,
                                  style: resultValueTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      size: 14,
                                      color: Colors.black,
                                    ),
                                    Text(' Oran', style: resultInfoTextStyle),
                                  ],
                                ),
                                Text(
                                  '%${_formattedInterestRate(offer.interestRate)}',
                                  style: resultValueTextStyle,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Tutar', style: resultInfoTextStyle),
                                Text(
                                  '₺${(offer.amount)}',
                                  style: resultValueTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(advertisementText,
                              style: resultInfoTextStyle),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: const Text('Close'),
        //   ),
        // ],
      );
    },
  );
}
