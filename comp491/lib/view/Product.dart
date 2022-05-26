class Product {
  final int productId;
  final String title;
  final String price;
  final String image1;
  final String image2;
  final String image3;
  final String image4;

  Product({required this.productId,required this.title, required this.price, required this.image1,required this.image2,required this.image3,required this.image4,});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Pid'],
      title: json['Pname'],
      price: json['Pprice'],
      image1: json['Pimages']['image1'],
      image2: json['Pimages']['image2'],
      image3: json['Pimages']['image3'],
      image4: json['Pimages']['image4'],
    );
  }
}