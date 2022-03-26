import 'dart:convert';

class OrderModel {
  final String id;
  final String idBuyer;
  final String nameBuyer;
  final String idSeller;
  final String nameSeller;
  final String idFood;
  final String nameFood;
  final String priceFood;
  final String amountFood;
  final String sumFood;
  final String total;
  final String status;
  OrderModel({
    required this.id,
    required this.idBuyer,
    required this.nameBuyer,
    required this.idSeller,
    required this.nameSeller,
    required this.idFood,
    required this.nameFood,
    required this.priceFood,
    required this.amountFood,
    required this.sumFood,
    required this.total,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idBuyer': idBuyer,
      'nameBuyer': nameBuyer,
      'idSeller': idSeller,
      'nameSeller': nameSeller,
      'idFood': idFood,
      'nameFood': nameFood,
      'priceFood': priceFood,
      'amountFood': amountFood,
      'sumFood': sumFood,
      'total': total,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      idBuyer: map['idBuyer'] ?? '',
      nameBuyer: map['nameBuyer'] ?? '',
      idSeller: map['idSeller'] ?? '',
      nameSeller: map['nameSeller'] ?? '',
      idFood: map['idFood'] ?? '',
      nameFood: map['nameFood'] ?? '',
      priceFood: map['priceFood'] ?? '',
      amountFood: map['amountFood'] ?? '',
      sumFood: map['sumFood'] ?? '',
      total: map['total'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
