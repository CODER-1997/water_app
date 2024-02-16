class OrderData {
  final int count;
  final String day;
  final String from;
  final String to;
  final String where;
  final String phone;
  final int price;
  final int bonus;
  final String user;
  final String when;
  final String companyId;
  final String companyPhone;
  final String status;
  final String courierName;
  final String courierId;
  final String customerId;
  final String courierPhone;

  OrderData({
    required this.count,
    required this.day,
    required this.from,
    required this.to,
    required this.where,
    required this.phone,
    required this.price,
    required this.user,
    required this.when,
    required this.companyId,
    required this.status,
    required this.bonus,
    required this.courierName,
    required this.courierId,
    required this.customerId,
    required this.courierPhone,
    required this.companyPhone,
  });

// Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'day': day,
      'from': from,
      'to': to,
      'where': where,
      'phone': phone,
      'price': price,
      'user': user,
      'when': when,
      'companyId': companyId,
      'status': status,
      'bonus': bonus,
      'courierName':courierName,
      'courierId':courierId,
      'customerId':customerId,
      'courierPhone':courierPhone,
      'companyPhone':companyPhone,
    };
  }
}
