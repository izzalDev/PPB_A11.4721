class BookModel {
  final String judul;
  final int halaman;
  final bool isBestSeller;
  BookModel({
    required this.judul,
    required this.halaman,
    required this.isBestSeller,
  });
  factory BookModel.fromJSON(Map<String, dynamic> json) => BookModel(
        judul: json['judul'],
        halaman: json['halaman'],
        isBestSeller: json['best_seller'],
      );
}
