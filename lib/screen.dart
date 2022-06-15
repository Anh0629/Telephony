// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:telephony_demo/theme.dart';

// class Screen extends StatefulWidget {
//   const Screen({Key? key}) : super(key: key);

//   @override
//   State<Screen> createState() => _ScreenState();
// }

// class _ScreenState extends State<Screen> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//        Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           color: Colors.black,
//           image: DecorationImage(
//               image: AssetImage(
//                 "assets/image/giphy.gif",
//               ),
//               fit: BoxFit.cover,
//               opacity: 0.3),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               _msgBody.isEmpty
//                   ? Container()
//                   :
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.all(8),
//                 height: MediaQuery.of(context).size.height * 0.15.h,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Tên: ${smsController.sms.address}', style: textHeader.titleMedium),
//                       Text('Nội dung tới: ', style: textHeader.titleMedium),
//                       Text(
//                         ' ${smsController.sms.body}',
//                         maxLines:3,
//                         style: textdata.bodyText1,
//                       )
//                     ]),
//               ),
//              Container(
//                 height: MediaQuery.of(context).size.height * 0.6,
//                 padding: const EdgeInsets.all(10.0),
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   itemCount: _list.length,
//                   itemBuilder: (BuildContext context, int i) {
//                     final item = _list[i];

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.address ?? "",
//                           style: const TextStyle(
//                               color: Colors.red,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         Text(item.body ?? ""),
//                         const Divider(
//                           thickness: 2,
//                           color: Colors.grey,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
    
//   }
// }
