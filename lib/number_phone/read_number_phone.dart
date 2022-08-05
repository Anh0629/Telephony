import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:telephony_demo/theme.dart';

class NumberPhone extends StatefulWidget {
  const NumberPhone({Key? key}) : super(key: key);
  static const routerName = '/NumberPhone';

  @override
  State<NumberPhone> createState() => _NumberPhoneState();
}

class _NumberPhoneState extends State<NumberPhone> {
  String _mobileNumber = '';
  List<SimCard> _simCard = [];

  @override
  void initState() {
    super.initState();

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    if (!mounted) return;

    setState(() {
      _mobileNumber = mobileNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: AssetImage('assets/image/gif_galaxy.gif'),
                            fit: BoxFit.fitWidth,
                            opacity: 0.6)),
                    child: Text('Só đang dùng: ${_mobileNumber.toString()}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6.h,
                      child: ListView.builder(
                          itemCount: _simCard.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = _simCard[index];
                            final slot = data.slotIndex! + 1;
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/image/giphy.gif'),
                                      fit: BoxFit.fitWidth,
                                      opacity: 0.6)),
                              padding: const EdgeInsets.all(8),
                              height: 100.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/image/love-message_1.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: 'Số Điện Thoại: ',
                                              style: textHeader.titleSmall,
                                              children: [
                                                TextSpan(
                                                    text:
                                                        ' ${data.number.toString()}',
                                                    style: textdata.bodyText2),
                                              ]),
                                          maxLines: 1,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Tên Sim: ',
                                              style: textHeader.titleSmall,
                                              children: [
                                                TextSpan(
                                                    text:
                                                        ' ${data.displayName.toString()}',
                                                    style: textdata.bodyText2),
                                              ]),
                                          maxLines: 1,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Vị Trí Sim: ',
                                              style: textHeader.titleSmall,
                                              children: [
                                                TextSpan(
                                                    text: slot.toString(),
                                                    style: textdata.bodyText2),
                                              ]),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '*Note:',
                          style: textdata.bodyText1,
                        ),
                        Text(
                          "Số điện thoại được ghi từ thẻ sim. Có 1 số di động không có sẵn từ thẻ sim sẽ không lấy được. *0# để kiểm tra trên điện thoại nhé !",
                          style: textdata.bodyText1,
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
