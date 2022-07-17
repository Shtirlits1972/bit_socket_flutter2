class channel {
  String name = '';
  List<String> product_ids = [];

  channel(this.name, this.product_ids);

  @override
  String toString() {
    return ' name = $name, product_ids = $product_ids ';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'product_ids': product_ids,
    };
  }
}
