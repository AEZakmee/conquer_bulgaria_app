import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    //elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
      ),
      onPressed: () {
        //FirebaseAuth.instance.signOut();
        //Todo menu functionality
        // print('uploading data');
        // PlacesData().placesForUpload.forEach((element) {
        //   Firestore.instance
        //       .collection('places')
        //       .document(element.id.toString())
        //       .setData(element.toMap());
        // });
      },
    ),
    // actions: [
    //   userIcon(
    //       context, Provider.of<Data>(context).currentUser.picture ?? 'none'),
    // ],
  );
}

// Padding userIcon(context, String imageUrl) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//     child: GestureDetector(
//       onTap: () {
//         print(Provider.of<Data>(context, listen: false).currentUser.data());
//       },
//       child: Container(
//         width: 50,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: (imageUrl == 'none')
//                 ? AssetImage('assets/images/default_user_image.png')
//                 : NetworkImage(imageUrl),
//           ),
//         ),
//       ),
//     ),
//   );
// }
