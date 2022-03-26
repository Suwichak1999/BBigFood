import 'package:bbigfood/widgets/show_head.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:bbigfood/models/sqlite_model.dart';
import 'package:bbigfood/models/user_model.dart';
import 'package:bbigfood/utility/my_constant.dart';
import 'package:bbigfood/utility/sqlite_helper.dart';
import 'package:bbigfood/widgets/show_progress.dart';
import 'package:bbigfood/widgets/show_title.dart';

class ShowShoppingCart extends StatefulWidget {
  final UserModel userModel;
  const ShowShoppingCart({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  _ShowShoppingCartState createState() => _ShowShoppingCartState();
}

class _ShowShoppingCartState extends State<ShowShoppingCart> {
  bool load = true;
  bool? haveData; // มีของในตะกร้า

  var sqlModels = <SQLiteModel>[];
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllCart();
  }

  Future<void> readAllCart() async {
    if (sqlModels.isNotEmpty) {
      sqlModels.clear();
      total = 0;
    }

    await SQLiteHelper().readData().then((value) {
      print('value ===> $value');
      load = false;
      if (value.isEmpty) {
        haveData = false;
      } else {
        haveData = true;
        sqlModels = value;
        for (var item in sqlModels) {
          int sumInt = int.parse(item.sum);
          total = total + sumInt;
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Cart'),
      ),
      body: load
          ? const ShowProgress()
          : haveData!
              ? Column(
                  children: [
                    ShowTitle(
                      title: sqlModels[0].nameSeller,
                      textStyle: MyConstant().h1Style(),
                    ),
                    ShowHead(),
                    newListCart(),
                    Divider(color: MyConstant.dart),
                    newTotal(),
                    Divider(color: MyConstant.dart),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            processOrder();
                          },
                          child: Text('Order'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await SQLiteHelper()
                                  .clearDatabase()
                                  .then((value) => readAllCart());
                            },
                            child: Text('Clear Cart'),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: ShowTitle(
                    title: 'ไม่มีของใน ตะกร้า',
                    textStyle: MyConstant().h1Style(),
                  ),
                ),
    );
  }

  Row newTotal() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'Totat : ',
                textStyle: MyConstant().h2Style(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ShowTitle(
            title: total.toString(),
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }

  ListView newListCart() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqlModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 3,
            child: ShowTitle(title: sqlModels[index].nameMenu),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(title: sqlModels[index].price),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(title: sqlModels[index].amount),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(title: sqlModels[index].sum),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                await SQLiteHelper()
                    .deleteWhereId(sqlModels[index].id!)
                    .then((value) => readAllCart());
              },
              icon: Icon(Icons.delete_forever),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> processOrder() async {
    var idFoods = <String>[];
    var nameFoods = <String>[];
    var priceFoods = <String>[];
    var amountFoods = <String>[];
    var sumFoods = <String>[];

    for (var item in sqlModels) {
      idFoods.add(item.idMenu);
      nameFoods.add(item.nameMenu);
      priceFoods.add(item.price);
      amountFoods.add(item.amount);
      sumFoods.add(item.sum);
    }

    String pathAPIorder =
        '${MyConstant.domain}/bbigfood/insertOrder.php?isAdd=true&idBuyer=${widget.userModel.id}&nameBuyer=${widget.userModel.name}&idSeller=${sqlModels[0].idSeller}&nameSeller=${sqlModels[0].nameSeller}&idFood=${idFoods.toString()}&nameFood=${nameFoods.toString()}&priceFood=${priceFoods.toString()}&amountFood=${amountFoods.toString()}&sumFood=${sumFoods.toString()}&total=$total&status=order';

    print('pathAPIorder ==>>> $pathAPIorder');

    await Dio().get(pathAPIorder).then((value) async {
      await SQLiteHelper()
          .clearDatabase()
          .then((value) => Navigator.pop(context));
    });
  }
}
