import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teklifimgelsin_feature/blocs/loan_bloc.dart';
import 'package:teklifimgelsin_feature/models/loan_offer.dart';
import 'package:teklifimgelsin_feature/widgets/advertisement_card.dart';

import 'package:teklifimgelsin_feature/widgets/detailed_offer_pop_up.dart';

class ResultListingPage extends StatefulWidget {
  const ResultListingPage({super.key});

  @override
  State<ResultListingPage> createState() => _ResultListingPageState();
}

class _ResultListingPageState extends State<ResultListingPage> {
  String _formatAmount(double amount) {
    final formattedAmount = amount.toStringAsFixed(2);
    final parts = formattedAmount.split('.');
    final integerPart = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(0)}.',
    );
    final decimalPart = parts[1].replaceAll('.', ',');
    return '$integerPart,$decimalPart';
  }

  String _formattedInterestRate(double interestRate) {
    String formattedInterestRate = interestRate.toStringAsFixed(2);
    return formattedInterestRate.replaceAll('.', ',');
  }

  final String advertisementText_1 =
      'Mobilden Akbanklı Olanlara Toplam 10.000 TL’ye Varan %0 Faiz!\n\n10.000 TL 6 ay vadeli ihtiyaç kredisini %0 faizle kullanmak için hemen şimdi mobilden Akbanklı ol.\n\nKampanya Koşulları\n- Kampanyadan 22 Ocak 2024 – 15 Mart 2024 tarihleri arasında Akbank Mobil’i indirip “Akbanklı olmak istiyorum” adımından ilerleyerek yalnızca ilk defa ve uzaktan müşterimi edinimi* sürecini tamamlayan müşteriler faydalanabilir.\n- Kredi başvurusu Akbanklı Ol sürecinin tamamlanması ardından Akbank Mobil üzerinden gerçekleştirilebilir.\n- Mobilden Akbanklı olan yeni müşterilerimiz, müşteri olduktan sonra 10 gün içinde hayat sigortalı ve %0 faizli ihtiyaç kredisine başvurabilir.\n- Kurye süreci ile işlemlerini tamamlayacak olan ve ilk defa Akbanklı olacak müşteriler, belge işlemleri tamamlandıktan sonra 10 gün içerisinde Akbank Mobile girerek krediye başvurabilirler.\n- Söz konusu kredi talepleri Akbank tarafından değerlendirilerek olumlu bulunursa karşılanacaktır.\n- Başvuruların olumlu değerlendirilmesi sonrası onaylanan kredi Akbank Mobil, Akbank İnternet, Müşteri İletişim Merkezi ve Şubelerimiz aracılığı ile kullanılabilir.\n- Kampanya kapsamında kullanılacak minimum kredi tutarı 1.000 TL, maksimum kredi tutarı 10.000 TL, maksimum vade ise 6 aydır.\n- Kampanyadan yalnızca gerçek kişi müşteriler faydalanacak olup kullanılabilecek kredi türü bireysel tüketici / ihtiyaç kredisidir.\n- Mobilden Akbanklı olan müşterilerimiz avantajlı kredi kampanyasından sadece bir kere yararlanabilir.\n- Sigortalı kredilerde müşterinin yaş ile kredi vadesinin toplamı 65i aşamaz.\n- Kredi masrafını içeren örnek ödeme planı ve yıllık maliyet oranı aşağıdaki tabloda belirtilmiştir. Hayat sigortası prim tutarı; kredi tutarı, kredi vadesi, faiz oranı ve müşterinin yaşına göre değişiklik göstereceğinden toplam geri ödeme tutarına dahil edilmemiştir.\n- Daha önce mobilden Akbanklı olup %0 veya %0,99 faizli avantajlı kredi kampanyalarımızdan yararlanan müşterilerimiz bu kampanyadan faydalanamaz.\n- Akbank, kredi koşullarını değiştirme, ek bilgi ve belge talebinde bulunma veya kampanyayı durdurma hakkını saklı tutar.';
  final String advertisementText_2 =
      'Enpara.comdan Yeni Hesap Açanlara Özel 2.000 TLye Varan Bonus Fırsatı!\n\n- Bonus Tutarı: 2.000 TLye kadar\n- Kampanya Koşulları: Enpara.com internet sitesi veya mobil uygulama üzerinden yeni hesap açan müşterilerimize özel 2.000 TLye varan bonus fırsatı! Detaylar için enpara.comu ziyaret edin veya Enpara Mobili indirin.\n- Kampanya Süresi: Kampanya 1 Ocak 2024 - 31 Mart 2024 tarihleri arasında geçerlidir.\n- Bonus Kazanma Şartı: 30 gün içinde hesabınızı aktif hale getirerek, aylık maaşınızı veya aylık gelirinizi en az 1 defa hesabınıza alın. Hesap aktivasyonundan itibaren 1 yıl içinde 3 adet aylık maaş veya aylık gelir alım işlemi gerçekleştirilmesi durumunda 2.000 TLye kadar bonus kazanabilirsiniz.\n- Bonus Ödemesi: Bonuslar, kampanya bitimini takiben 30 gün içerisinde müşterilerin hesaplarına otomatik olarak yatırılacaktır.\n- Diğer Koşullar: Kampanyadan yalnızca bireysel bireysel ve 18 yaşını doldurmuş gerçek kişiler faydalanabilir. Kampanya, Enpara tarafından önceden haber verilmeksizin sonlandırılabilir veya değiştirilebilir.';
  final String advertisementText_3 =
      'QNB Mobilden Yeni Müşteri Olanlara Özel %0 Faizli Anında 30.000 TL\n\n- Kredi Tutarı: 10.000 TL\n- Vade: 6 Ay\n- Aylık Taksit: 1.666,67 TL\n- Faiz Oranı: %0\n- Toplam Maliyet: 10.000 TL\n\nKampanya detayları:\n\n- 29 Şubata kadar aşağıdaki formdan CardFinans veya CardFinans Xtra kredi kartı başvurunuzu tamamlayın, %0 faiz oranlı 20.000 TL tutarında 6 ay vade ile Anında Kredi fırsatından hemen yararlanın!\n- Şubat Ayı sonuna kadar ilk kez CardFinans veya CardFinans Xtra bireysel kredi kartı alan müşterilerimiz QNB Finansbank Şubelerinden veya qnbfinansbank.com üzerinden başvurdukları Anında Kredi fırsatından yararlanabilirler.\n- QNB Finansbank bireysel kredi kartı sahibi olmayan, 18 yaşını doldurmuş ve kredi skoru uygun olan müşterileri kabul eder.\n- Başvuru onayı ve limit bilgisi, kart teslim edildikten sonra SMS ile müşteriye bildirilecektir.\n- Bu kampanya diğer kampanyalarla birleştirilemez.\n- QNB Finansbank, kampanya süresini ve kampanya kapsamındaki işleyiş şartlarını değiştirme hakkını saklı tutar.\n- Detaylı bilgi için 0850 222 0 900’ü arayabilirsiniz.';

  final LoanOffer advertisement_1 = LoanOffer(
    bankName: 'Akbank',
    annualExpenseRate: 99.99,
    bankId: 400100046,
    bankType: 'Ozel',
    productName: 'İhtiyaç Kredisi',
    interestRate: 0,
    url: 'https://www.example.com',
    maturity: 12,
    amount: 10000,
  );

  final LoanOffer advertisement_2 = LoanOffer(
    bankName: 'Enpara.com',
    annualExpenseRate: 99.99,
    bankId: 400101111,
    bankType: 'Ozel',
    productName: 'İhtiyaç Kredisi',
    interestRate: 0,
    url: 'https://www.example.com',
    maturity: 12,
    amount: 10000,
  );

  final LoanOffer advertisement_3 = LoanOffer(
    bankName: 'QNB Finansbank',
    annualExpenseRate: 99.99,
    bankId: 400100111,
    bankType: 'Ozel',
    productName: 'İhtiyaç Kredisi',
    interestRate: 0,
    url: 'https://www.example.com',
    maturity: 12,
    amount: 30000,
  );

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        title: const Text('İhtiyaç Kredileri'),
      ),
      backgroundColor: Colors.grey.shade200,
      body: BlocBuilder<LoanBloc, LoanState>(
        builder: (context, state) {
          if (state is LoanLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoanLoaded) {
            final offers = state.offers;

            return ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                // print(offer.bankName);
                // print(offer.bankId);
                return Column(
                  children: [
                    if (index == 0)
                      AdvertisementCard(
                          offer: advertisement_1,
                          advertisementText: advertisementText_1,
                          formattedAmount: _formatAmount,
                          formattedInterestRate: _formattedInterestRate),
                    if (index == 0)
                      AdvertisementCard(
                          offer: advertisement_2,
                          advertisementText: advertisementText_2,
                          formattedAmount: _formatAmount,
                          formattedInterestRate: _formattedInterestRate),
                    if (index == 0)
                      AdvertisementCard(
                          offer: advertisement_3,
                          advertisementText: advertisementText_3,
                          formattedAmount: _formatAmount,
                          formattedInterestRate: _formattedInterestRate),
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
                              detailedOfferPopup(context, offer);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 66,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: SvgPicture.asset(
                                            'assets/images/${offer.bankId}.svg',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Detaylar',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              )),
                                          Icon(
                                            Icons.chevron_right,
                                            size: 14,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text('Taksit',
                                              style: resultInfoTextStyle),
                                          Text(
                                            '₺${_formatAmount(offer.monthlyPayment)}',
                                            style: resultValueTextStyle,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.info_outline_rounded,
                                                size: 14,
                                                color: Colors.black,
                                              ),
                                              Text(' Oran',
                                                  style: resultInfoTextStyle),
                                            ],
                                          ),
                                          Text(
                                            '%${_formattedInterestRate(offer.interestRate)}',
                                            style: resultValueTextStyle,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text('Toplam Ödeme',
                                              style: resultInfoTextStyle),
                                          Text(
                                            '₺${_formatAmount(offer.totalCost)}',
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
                                      foregroundColor: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      backgroundColor: const Color.fromRGBO(
                                          59, 180, 172, 0.9),
                                      minimumSize:
                                          const Size(double.infinity, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
              },
            );
          } else if (state is LoanError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
