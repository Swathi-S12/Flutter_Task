class Plant {
  final String id;
  final String commonName;
  final String botanicalName;
  final String category;
  final String uses;
  final double price;
  final String imageUrl;

  Plant({
    required this.id,
    required this.commonName,
    required this.botanicalName,
    required this.category,
    required this.uses,
    required this.price,
    required this.imageUrl,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['_id'],
      commonName: json['commonName'],
      botanicalName: json['botanicalName'],
      category: json['category'],
      uses: json['uses'],
      price: (json['price']).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commonName': commonName,
      'botanicalName': botanicalName,
      'category': category,
      'uses': uses,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
