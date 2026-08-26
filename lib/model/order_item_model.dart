class OrderItemModel{
  final int productId;
  final String productName;
  final String productImage;
  final int bgColor;
  final double price;
  final int quantity;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.bgColor,
    required this.price,
    required this.quantity,
  });

  Map<String , dynamic> toJson(){
    return {
      'productId' : productId,
      'productName' :productName,
      'productImage' : productImage,
      'bgColor' : bgColor,
      'price' : price,
      'quantity' : quantity
    };
  }

  factory OrderItemModel.fromJson(Map<String, dynamic>json){
    return OrderItemModel(
        productId: json['productId'],
        productName: json['productName'],
        productImage : json['productImage'],
        bgColor : json['bgColor'] ?? 0xFFFFFFFF,
        price: json['price'],
        quantity: json['quantity']);
  }

}