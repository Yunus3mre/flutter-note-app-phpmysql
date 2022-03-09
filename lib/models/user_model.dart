class User {
  final String? name;
  final String? email;
  final String? password;
 

  User({this.name, this.email, this.password});

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        
      };

  factory User.fromMap(Map map) =>
      User(name: map["name"], email: map["email"], password: map["password"]);
}
