// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pub {
  String id;
  final double? rating;
  String? title;
  String? address;
  String? description;
  final String? pubImage;
  String? category;
  final int? nb_likes;
  final String? state;
  String? duree;
  final int? pourcentage;
  

  Pub({
    required this.id,
    required this.rating,
    required this.title,
    required this.address,
    required this.description,
    required this.pubImage,
    required this.category,
    required this.nb_likes,
    required this.state,
    required this.duree,
    required this.pourcentage,
  });

  Pub copyWith({
    String? id,
    double? rating,
    String? title,
    String? address,
    String? description,
    String? pubImage,
    String? category,
    int? nb_likes,
    String? state,
    String? duree,
    int? pourcentage,
  }) {
    return Pub(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      address: address ?? this.address,
      description: description ?? this.description,
      pubImage: pubImage ?? this.pubImage,
      category: category ?? this.category,
      nb_likes: nb_likes ?? this.nb_likes,
      state: state ?? this.state,
      duree: duree ?? this.duree,
      pourcentage: pourcentage ?? this.pourcentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rating': rating,
      'title': title,
      'address': address,
      'description': description,
      'pubImage': pubImage,
      'category': category,
      'nb_likes': nb_likes,
      'state': state,
      'duree': duree,
      'pourcentage': pourcentage,
    };
  }

  factory Pub.fromJson(Map<String, dynamic> map) {
    double? parseDouble(dynamic value) {
      if (value is double) {
        return value;
      } else if (value is int) {
        return value.toDouble();
      } else if (value is String) {
        final parsedValue = double.tryParse(value);
        if (parsedValue != null) {
          return parsedValue;
        }
      }
      return null;
    }
    return Pub(
      id: map['_id'] as String,
      rating: parseDouble(map['rating']),
      title: map['title'] != null ? map['title'] as String : null,
      address: map['adress'] != null ? map['adress'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      pubImage: map['pubImage'] != null ? map['pubImage'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      nb_likes: map['nb_likes'] != null ? map['nb_likes'] as int : null,
      state: map['state'] != null ? map['state'] as String : null,
      duree: map['duree'] != null ? map['duree'] as String : null,
      pourcentage: map['pourcentage'] != null ? map['pourcentage'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Pub.fromJson(String source) =>
  //     Pub.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pub(id: $id, rating: $rating, title: $title, address: $address, description: $description, pubImage: $pubImage, category: $category, nb_likes: $nb_likes, state: $state, duree: $duree, pourcentage: $pourcentage)';
  }

  @override
  bool operator ==(covariant Pub other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rating == rating &&
        other.title == title &&
        other.address == address &&
        other.description == description &&
        other.pubImage == pubImage &&
        other.category == category &&
        other.nb_likes == nb_likes &&
        other.state == state &&
        other.duree == duree &&
        other.pourcentage == pourcentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rating.hashCode ^
        title.hashCode ^
        address.hashCode ^
        description.hashCode ^
        pubImage.hashCode ^
        category.hashCode ^
        nb_likes.hashCode ^
        state.hashCode ^
        duree.hashCode ^
        pourcentage.hashCode;
  }
}
/*
import 'dart:convert';

class Pub {
  String id;
  final double? rating;
  String? title;
  String? address;
  String? description;
  final String? pubImage;
  String? category;
  final String? state;
  String? duree;
  final int? pourcentage;

  ///
  Pub({
    required this.id,
    required this.rating,
    required this.title,
    required this.address,
    required this.description,
    required this.pubImage,
    required this.category,
    required this.state,
    this.duree,
    this.pourcentage,
  });
}

List<Pub> listOfIPubs = [
  Pub(
    id: "1",
    rating: 4,
    title: "El Mouradi Mahdia",
    address: "Mahdia",
    description: "Promo!!",
    pubImage: "assets/images/MouradiMahdia.jpg",
    category: "hotel",
    state: "offre",
   // duree: "3j",
   // pourcentage: 30,
  ),
  Pub(
    id: "2",
    rating: 4,
    title: "El Mouradi Mahdia",
    address: "Mahdia",
    description: "Promo!!",
    pubImage: "assets/images/MouradiMahdia.jpg",
    category: "hotel",
    state: "offre",
    //duree: "3j",
    //pourcentage: 30,
  ),
  Pub(
    id: "3",
    rating: 4.5,
    title: "LA CANTINE",
    address: "Sousse",
    description: "Promo sur tous les pizzas!!",
    pubImage: "assets/images/lacantine.jpg",
    category: "restaurant",
    state: "promo",
    duree: "24h",
    pourcentage: 50,
  ),
  Pub(
    id: "4",
    rating: 4.3,
    title: "Café Sidi Salem La Grotte",
    address: "Mahdia",
    description: "promo sur la pizza ",
    pubImage: "assets/images/sidisalem.jpg",
    category: "restaurant",
    state: "promo",
    duree: "2j",
    pourcentage: 50,
  ),
  Pub(
    id: "5",
    rating: 5,
    title: "Marina Cap Monastir- Appart'Hôtel",
    address: "hotel",
    description:
        "Located next to the marina and the beach, in a 5 minutes walk from the city center, the apart hotel Marina Cap Monastir is ideal for a relaxing stay.",
    pubImage: "assets/images/marina.png",
    category: "hotel",
    state: "offre",
    //duree: "DealDiscover",
    //pourcentage: 20,
  ),
  Pub(
    id: "6",
    rating: 4.3,
    title: "El Jem Amphitheater",
    address: "ElJem",
    description:
        "This vast, golden-stoned amphitheater, dating from the 2nd century CE, rises to 40 meters high and is the fourth largest in the world, as well as being one of the best preserved surviving examples of amphitheater architecture.",
    pubImage: 'assets/images/jem.jpg',
    category: "monument",
    state: "offre",
    //duree: "DealDiscover",
    //pourcentage: 20,
  ),
  Pub(
    id: "7",
    rating: 4,
    title: "Hergla",
    address: "Hergla",
    description:
        "It occupies the site of ancient Roman Horraca Caelia, which during the 2nd century CE lay directly on the boundary between the provinces of Byzacena and Zeugitana.",
    pubImage: "assets/images/hergla.jpg",
    category: "destination",
    state: "offre",
    // duree: "2j",
    //pourcentage: 50,
  ),
  Pub(
    id: "8",
    rating: 5,
    title: "Sousse Palace Hotel & Spa",
    address: "Sousse",
    description:
        "Sousse Palace Hotel & Spa is located in the center of Sousse near the Medina, with direct access to a private beach. discount in spa!!",
    pubImage: "assets/images/soussepalace.jpg",
    category: "hotel",
    state: "promo",
    duree: "7j",
    pourcentage: 20,
  ),
  Pub(
    id: "9",
    rating: 4,
    title: "El Mouradi Mahdia",
    address: "Mahdia",
    description: "Promo!!",
    pubImage: "assets/images/MouradiMahdia.jpg",
    category: "hotel",
    state: "promo",
    duree: "3j",
    pourcentage: 30,
  ),
  Pub(
    id: "10",
    rating: 5,
    title: "le pirate",
    address: "Monastir",
    description: "Promo sur tous les plats!!",
    pubImage: "assets/images/lepirate.jpg",
    category: "restaurant",
    state: "promo",
    duree: "24h",
    pourcentage: 25,
  ),
  Pub(
    id: "11",
    rating: 6,
    title: "BRUCHETTA",
    address: "Sousse",
    description: "Promo sur tous les pates!!",
    pubImage: "assets/images/bruscetta.jpg",
    category: "restaurant",
    state: "promo",
    duree: "24h",
    pourcentage: 30,
  ),
  Pub(
    id: "12",
    rating: 6.5,
    title: "Hotel Les Palmiers",
    address: "Monastir",
    description:
        "Hotel les Palmiers is located directly on Skanes beach, a 5-minute drive from Monastir city center. It offers rooms with views of the sea or the outdoor swimming pools and garden. ",
    pubImage: "assets/images/palmier.png",
    category: "hotel",
    state: "promo",
    duree: "3j",
    pourcentage: 20,
  ),
];
*/
