import 'package:bbigfood/utility/my_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:bbigfood/models/order_model.dart';
import 'package:bbigfood/utility/my_constant.dart';
import 'package:bbigfood/widgets/show_head.dart';
import 'package:bbigfood/widgets/show_title.dart';

class ListOrderDetail extends StatefulWidget {
  final bool buyerbol;
  final OrderModel orderModel;

  const ListOrderDetail({
    Key? key,
    required this.buyerbol,
    required this.orderModel,
  }) : super(key: key);

  @override
  _ListOrderDetailState createState() => _ListOrderDetailState();
}

class _ListOrderDetailState extends State<ListOrderDetail> {
  bool? buyerbol;
  OrderModel? orderModel;

  var nameFoods = <String>[];
  var priceFoods = <String>[];
  var amountFoods = <String>[];
  var sumFoods = <String>[];

  @override
  void initState() {
    super.initState();
    buyerbol = widget.buyerbol;
    orderModel = widget.orderModel;

    nameFoods = changeStringToArey(orderModel!.nameFood);
    priceFoods = changeStringToArey(orderModel!.priceFood);
    amountFoods = changeStringToArey(orderModel!.amountFood);
    sumFoods = changeStringToArey(orderModel!.sumFood);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buyerbol!
            ? ' ${orderModel!.nameSeller}'
            : 'ผู้ซื้อ :  ${orderModel!.nameBuyer}'),
      ),
      body: Column(
        children: [
          ShowHead(),
          newListOrder(),
          Divider(
            color: MyConstant.dart,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: nawTotal(),
          ),
          Divider(
            color: MyConstant.dart,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShowTitle(title: 'สถานะ : ${orderModel!.status}'),
              ),
              SizedBox(
                width: 36,
              ),
              buyerbol!
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        if (orderModel!.status == 'finish') {
                          MyDialog().normalDialog(context, 'Cannot Change',
                              'สถานะเป็น finish อยู่แล้ว');
                        } else {
                          processChangStatus();
                        }
                      },
                      child: Text('Change Status'),
                    ),
            ],
          )
        ],
      ),
    );
  }

  Row nawTotal() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(title: 'ทั้งหมด :    ',textStyle: MyConstant().h2Style(),),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ShowTitle(
            title: '${orderModel!.total}  บาท',
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }

  ListView newListOrder() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: nameFoods.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShowTitle(
                title: nameFoods[index],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShowTitle(
                title: priceFoods[index],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShowTitle(
                title: amountFoods[index],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ShowTitle(
              title: sumFoods[index],
            ),
          ),
        ],
      ),
    );
  }

  List<String> changeStringToArey(String string) {
    var results = <String>[];

    String result = string.substring(1, string.length - 1);
    results = result.split(',');
    for (var i = 0; i < results.length; i++) {
      results[i] = results[i].trim();
    }

    return results;
  }

  Future<void> processChangStatus() async {
    String pathAPIchangStatus = '${MyConstant.domain}/bbigfood/editStatusWhereId.php/?isAdd=true&id=${orderModel!.id}';
    await Dio().get(pathAPIchangStatus).then((value) => Navigator.pop(context));
  }
}
