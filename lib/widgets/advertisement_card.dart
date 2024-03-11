import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teklifimgelsin_feature/models/loan_offer.dart';
import 'package:teklifimgelsin_feature/widgets/advertisement_pop_up.dart';

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

class AdvertisementCard extends StatelessWidget {
  final LoanOffer offer;
  final String advertisementText;
  final String Function(double) formattedAmount;
  final String Function(double) formattedInterestRate;

  const AdvertisementCard({
    super.key,
    required this.offer,
    required this.advertisementText,
    required this.formattedAmount,
    required this.formattedInterestRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: IntrinsicHeight(
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                hoverColor: Colors.white,
                highlightColor: Colors.white,
                splashColor: Colors.white,
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.black.withOpacity(0.1)),
                focusColor: Colors.white,
                onTap: () {
                  advertisementPopup(context, offer, advertisementText);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.verified,
                                size: 12,
                                color: Colors.lightGreen,
                              ),
                              Text(' Reklam',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.lightGreen,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Tutar', style: resultInfoTextStyle),
                              Text(
                                '₺${formattedAmount(offer.amount.toDouble())}',
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
                                '%${formattedInterestRate(offer.interestRate)}',
                                style: resultValueTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          backgroundColor:
                              const Color.fromRGBO(59, 180, 172, 0.9),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.launch,
                              size: 21,
                              color: Colors.white,
                            ),
                            Text(
                              '  Başvur',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
