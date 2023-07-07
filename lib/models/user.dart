class User {
  int id;
  String email;
  String username;
  Name name;
  Address address;
  String phone;

  User(this.id, this.email, this.username, this.name, this.address, this.phone);

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      parsedJson['id'],
      parsedJson['email'],
      parsedJson['username'],
      Name.fromJson(parsedJson['name']),
      Address.fromJson(parsedJson['address']),
      parsedJson['phone'].toString(),
    );
  }
}

class Name {
  String firstname;
  String lastname;

  Name(this.firstname, this.lastname);

  factory Name.fromJson(Map<String, dynamic> parsedJson){
  return Name(
    parsedJson['firstname'],
    parsedJson['lastname']
  );
}
}

class Address {
  String city;
  String street;
  int number;
  String zipcode;

  Address(this.city, this.street, this.number, this.zipcode);

  factory Address.fromJson(Map<String, dynamic> parsedJson) {
    return Address(
      parsedJson['city'],
      parsedJson['street'],
      parsedJson['number'],
      parsedJson['zipcode'],
    );
  }
}
