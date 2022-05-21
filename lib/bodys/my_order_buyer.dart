import 'dart:convert';

import 'package:bbigfood/models/order_model.dart';
import 'package:bbigfood/widgets/list_order_detail.dart';
import 'package:bbigfood/widgets/show_progress.dart';
import 'package:bbigfood/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:bbigfood/models/user_model.dart';
import 'package:bbigfood/utility/my_constant.dart';

class MyOrderBuyer extends StatefulWidget {
  final UserModel userModel;
  const MyOrderBuyer({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  _MyOrderBuyerState createState() => _MyOrderBuyerState();
}

class _MyOrderBuyerState extends State<MyOrderBuyer> {
  bool load = true;
  bool? haveData;

  var orderModels = <OrderModel>[];

  @override
  void initState() {
    super.initState();
    readMyOrder();
  }

  Future<void> readMyOrder() async {
    if (orderModels.isNotEmpty) {
      orderModels.clear();
    }

    String pathAPI =
        '${MyConstant.domain}/bbigfood/getOrderWhereIdBuyer.php/?isAdd=true&idBuyer=${widget.userModel.id}';

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
                            buyerbol: true,
                            orderModel: orderModels[index],
                          ),
                        )),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShowTitle(
                              title: orderModels[index].nameSeller,
                              textStyle: MyConstant().h2Style(),
                            ),
                            ShowTitle(
                              title: 'สถานะ :  ${orderModels[index].status}',
                              textStyle: orderModels[index].status == 'order'
                                  ? MyConstant().h3redStyle()
                                  : MyConstant().h3Style(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: ShowTitle(
                  title: 'ไม่มีประวัติการซื้อ',
                  textStyle: MyConstant().h1Style(),
                )),
    );
  }
}
