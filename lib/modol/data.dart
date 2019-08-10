class Data{
  String name;
  dynamic price;
  Data(this.name, this.price);

  Data.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      price = json['price'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
  };
}