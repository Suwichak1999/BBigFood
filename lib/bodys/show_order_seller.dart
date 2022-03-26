import 'dart:convert';

import 'package:bbigfood/models/order_model.dart';
import 'package:bbigfood/widgets/list_order_detail.dart';
import 'package:bbigfood/widgets/show_progress.dart';
import 'package:bbigfood/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:bbigfood/models/user_model.dart';
import 'package:bbigfood/utility/my_constant.dart';

class ShowOrderSeller extends StatefulWidget {
  final UserModel userModel;
  const ShowOrderSeller({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  _ShowOrderSellerState createState() => _ShowOrderSellerState();
}

class _ShowOrderSellerState extends State<ShowOrderSeller> {
  bool load = true;
  bool? haveData;

  var orderModels = <OrderModel>[];

  @override
  void initState() {
    super.initState();
    readOrder();
  }

  Future<void> readOrder() async {
    if (orderModels.isNotEmpty) {
      orderModels.clear();
    }

    String pathAPI =
        '${MyConstant.domain}/bbigfood/getOrderWhereIdSeller.php/?isAdd=true&idSeller=${widget.userModel.id}';
    await Dio().get(pathAPI).then((value) {
      load = false;

      if (value.toString() == 'null') {
        haveData = false;
      } else {
        haveData = true;
        for (var item in json.decode(value.data)) {
          OrderModel orderModel = OrderModel.fromMap(item);
          orderModels.add(orderModel);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? Center(child: ShowProgress())
          : haveData!
              ? ListView.builder(
                  itemCount: orderModels.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListOrderDetail(
                            buyerbol: false,
                            orderModel: orderModels[index],
                            
                          ),
                        )).then((value) {
                      setState(() {
                        load = true;
                        readOrder();
                      });
                    }),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShowTitle(
                              title: orderModels[index].nameBuyer,
                              textStyle: MyConstant().h2Style(),
                            ),
                            ShowTitle(
                                title: 'Total : ${orderModels[index].total}'),
                            ShowTitle(
                                title: 'สถานะ : ${orderModels[index].status}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: ShowTitle(
                  title: 'No Order',
                  textStyle: MyConstant().h1Style(),
                )),
    );
  }
}
