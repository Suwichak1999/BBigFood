import 'package:bbigfood/states/show_all_food.dart';
import 'package:bbigfood/utility/my_constant.dart';
import 'package:bbigfood/widgets/show_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:bbigfood/models/user_model.dart';
import 'package:bbigfood/widgets/show_title.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowShopSeller extends StatelessWidget {
  final UserModel userModel;
  const ShowShopSeller({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('Menu'),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowAllFood(
              userModel: userModel,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(userModel.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              displayTitle(head: 'เบอร์โทร :  ', detail: userModel.phone),
              displayTitle(head: 'รูปภาพ :', detail: ''),
              SizedBox(
                  width: 300,
                  height: 280,
                  child: CachedNetworkImage(
                    imageUrl: '${MyConstant.domain}${userModel.avatar}',
                    placeholder: (context, url) => const ShowProgress(),
                  )),
              displayTitle(head: 'ตำแหน่งที่ตั้ง :', detail: ''),
              SizedBox(
                width: 300,
                height: 250,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.parse(userModel.lat),
                      double.parse(userModel.lng),
                    ),
                    zoom: 16,
                  ),
                  markers: <Marker>[
                    Marker(
                        infoWindow: InfoWindow(title: userModel.name),
                        markerId: MarkerId('id'),
                        position: LatLng(
                          double.parse(userModel.lat),
                          double.parse(userModel.lng),
                        ))
                  ].toSet(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding displayTitle({required String head, required String detail}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ShowTitle(
            title: '$head $detail',
            textStyle: MyConstant().h2Style(),
          ),
        ],
      ),
    );
  }
}
