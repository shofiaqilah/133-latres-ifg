// mau ambil data apa aja dari API
class Character {
  final String fullName;
  final String nickname;
  final String hogwartsHouse;
  final String interpretedBy;
  final List<String> children;
  final String image;
  final String birthdate;

  Character({
    required this.fullName,
    required this.nickname,
    required this.hogwartsHouse,
    required this.interpretedBy,
    required this.children,
    required this.image,
    required this.birthdate,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      fullName: json['fullName'] ?? '',
      nickname: json['nickname'] ?? 'no nickname',
      hogwartsHouse: json['hogwartsHouse'] ?? '',
      interpretedBy: json['interpretedBy'] ?? '',
      children:
          (json['children'] as List<dynamic>?)
              ?.map((child) => child.toString())
              .toList() ??
          [],
      image: json['image'] ?? '',
      birthdate: json['birthdate'] ?? '',
    );
  }
}
