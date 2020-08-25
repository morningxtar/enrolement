class Enrole {

  var id;
  String nom;
  String prenoms;
  String dateNaissance;
  String lieuNaissance;
  String nationalite;
  String contact;
  String email;

  Enrole({
    this.id,
    this.nom,
    this.prenoms,
    this.dateNaissance,
    this.lieuNaissance,
    this.nationalite,
    this.contact,
    this.email,
  });

  factory Enrole.fromJson(Map<String, dynamic> json) {
    return Enrole(
      id: json['id'],
      nom: json['nom'],
      prenoms: json['prenoms'],
      dateNaissance: json['dateNaissance'],
      lieuNaissance: json['lieuNaissance'],
      nationalite: json['nationalite'],
      contact: json['contact'],
      email: json['email'],
    );
  }
}