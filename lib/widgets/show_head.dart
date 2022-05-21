import 'package:bbigfood/utility/my_constant.dart';
import 'package:bbigfood/widgets/show_title.dart';
import 'package:flutter/material.dart';

class ShowHead extends StatelessWidget {
  const ShowHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyConstant.light),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ShowTitle(
                title: 'ชื่อเมนู',
                textStyle: MyConstant().h3Whitew700Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'ราคา',
                textStyle: MyConstant().h3Whitew700Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'จำนวน',
                textStyle: MyConstant().h3Whitew700Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'รวม',
                textStyle: MyConstant().h3Whitew700Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}