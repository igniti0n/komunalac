class Korisnik {
  String ime;
  String prezime;
  String sifra;
  String oIB;
  String mobitel;
  String email;
  String adresaUlica;
  String adresaKBR;
  int adresaId;
  String adresaJLS;
  String litraE;
  String barkodi;
  int pravoNaBrojTuristiKihKarti;

  Korisnik(
      {this.ime,
      this.prezime,
      this.sifra,
      this.oIB,
      this.mobitel,
      this.email,
      this.adresaUlica,
      this.adresaKBR,
      this.adresaId,
      this.adresaJLS,
      this.litraE,
      this.barkodi,
      this.pravoNaBrojTuristiKihKarti});

  Korisnik.fromJson(Map<String, dynamic> json) {
    ime = json['Ime'];
    prezime = json['Prezime'];
    sifra = json['Sifra'];
    oIB = json['OIB'];
    mobitel = json['Mobitel'];
    email = json['Email'];
    adresaUlica = json['AdresaUlica'];
    adresaKBR = json['AdresaKBR'];
    adresaId = json['AdresaId'];
    adresaJLS = json['AdresaJLS'];
    litraE = json['Litraže'];
    barkodi = json['Barkodi'];
    pravoNaBrojTuristiKihKarti = json['PravoNaBrojTurističkihKarti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Ime'] = this.ime;
    data['Prezime'] = this.prezime;
    data['Sifra'] = this.sifra;
    data['OIB'] = this.oIB;
    data['Mobitel'] = this.mobitel;
    data['Email'] = this.email;
    data['AdresaUlica'] = this.adresaUlica;
    data['AdresaKBR'] = this.adresaKBR;
    data['AdresaId'] = this.adresaId;
    data['AdresaJLS'] = this.adresaJLS;
    data['Litraže'] = this.litraE;
    data['Barkodi'] = this.barkodi;
    data['PravoNaBrojTurističkihKarti'] = this.pravoNaBrojTuristiKihKarti;
    return data;
  }
}

DateTime zadnjiLogin;

Korisnik g_korisnik; // login - register ako je logiran g_korisnik nije null

String g_tipNeReg = "MKO";

String g_OpenAfterLogin = "";

class Otpad {
  String mKODate;
  String recDate;
  String mobileRecDate;

  Otpad({this.mKODate, this.recDate, this.mobileRecDate});

  Otpad.fromJson(Map<String, dynamic> json) {
    mKODate = json['MKO_Date'];
    recDate = json['Rec_Date'];
    mobileRecDate = json['MobileRec_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MKO_Date'] = this.mKODate;
    data['Rec_Date'] = this.recDate;
    data['MobileRec_Date'] = this.mobileRecDate;
    return data;
  }
}

Otpad g_otpad;

class Ulica {
  String adresaJLS;
  String adresaUlica;
  String adresaKBR;
  int adresaID;

  Ulica({this.adresaJLS, this.adresaUlica, this.adresaKBR, this.adresaID});

  Ulica.fromJson(Map<String, dynamic> json) {
    adresaJLS = json['AdresaJLS'];
    adresaUlica = json['AdresaUlica'];
    adresaKBR = json['AdresaKBR'];
    adresaID = json['AdresaID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdresaJLS'] = this.adresaJLS;
    data['AdresaUlica'] = this.adresaUlica;
    data['AdresaKBR'] = this.adresaKBR;
    data['AdresaID'] = this.adresaID;
    return data;
  }
}

class Pogreb {
  String naziv;
  String imgUrl;
  String datum;

  Pogreb({this.naziv, this.imgUrl, this.datum});

  Pogreb.fromJson(Map<String, dynamic> json) {
    naziv = json['Naziv'];
    imgUrl = json['ImgUrl'];
    datum = json['Datum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Naziv'] = this.naziv;
    data['ImgUrl'] = this.imgUrl;
    data['Datum'] = this.datum;
    return data;
  }
}

class Nepravilnost {
  int tip;
  String opis;
  String userid;
  String slika;
  String dokument;
  bool notifyStatus;

  Nepravilnost(
      {this.tip,
      this.opis,
      this.userid,
      this.slika,
      this.dokument,
      this.notifyStatus});

  Nepravilnost.fromJson(Map<String, dynamic> json) {
    tip = json['Tip'];
    opis = json['Opis'];
    userid = json['userid'];
    slika = json['Slika'];
    dokument = json['Dokument'];
    notifyStatus = json['NotifyStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tip'] = this.tip;
    data['Opis'] = this.opis;
    data['userid'] = this.userid;
    data['Slika'] = this.slika;
    data['Dokument'] = this.dokument;
    data['NotifyStatus'] = this.notifyStatus;
    return data;
  }
}

class VrtNarudzba {
  String userid;
  String opis;
  String ime;
  String email;
  String tel;

  VrtNarudzba({
    this.userid,
    this.opis,
    this.ime,
    this.email,
    this.tel,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['Opis'] = this.opis;
    data['ime'] = this.ime;
    data['mob'] = this.tel;
    data['email'] = this.email;
    return data;
  }
}

class ParkingBO {
  String naziv;
  double latitude;
  double longitude;
  bool otvoreno;
  int mjestaTotal;
  int mjestaFree;

  ParkingBO(
      {this.naziv,
      this.latitude,
      this.longitude,
      this.otvoreno,
      this.mjestaTotal,
      this.mjestaFree});

  ParkingBO.fromJson(Map<String, dynamic> json) {
    naziv = json['Naziv'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    otvoreno = json['Otvoreno'];
    mjestaTotal = json['MjestaTotal'];
    mjestaFree = json['MjestaFree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Naziv'] = this.naziv;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Otvoreno'] = this.otvoreno;
    data['MjestaTotal'] = this.mjestaTotal;
    data['MjestaFree'] = this.mjestaFree;
    return data;
  }
}

class AdresaResp {
  String mkoDate;
  String recDate;
  String plastikaDate;

  AdresaResp({this.mkoDate, this.recDate, this.plastikaDate});

  AdresaResp.fromJson(Map<String, dynamic> json) {
    mkoDate = json['MkoDate'];
    recDate = json['RecDate'];
    plastikaDate = json['PlastikaDate'];
  }
}
