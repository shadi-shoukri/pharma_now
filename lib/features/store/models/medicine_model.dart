class MedicineModel {
  final String id ;
  final String name ;
  final double price ;
  final int  stock ;
  final String description ;
  final String  imageUrl  ;
  final String  category  ;

  final bool? requiresPrescription;

  MedicineModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.requiresPrescription,
  });
 factory MedicineModel.fromJson(Map<String, dynamic>json){
   return MedicineModel(
     id:  json['id']  as String,
     name:   json['name']  as String,
     price:   (json['price'] as num).toDouble(),
     stock:  json['stock']  as int,
     description:   json['description'] as String,
     imageUrl:   json['image_url'] as String,
     category: json['category'] as String,
     requiresPrescription:   json['requires_prescription'] as bool,
  )
}

































}
