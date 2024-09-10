// Language Response Model
class LRM {
  final String code;
  final String name;
  final List<String> targets;

  LRM({required this.code, required this.name, required this.targets});

  factory LRM.fromJson(Map<String, dynamic> json) {
    return LRM(
      code: json['code'],
      name: json['name'],
      targets: List<String>.from(json['targets']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'targets': targets,
    };
  }
}
