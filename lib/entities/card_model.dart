class CardModel {
  // _linearGradient=linearGradient[value['gradient']];
  // cardNumber.text = value['cardNumber'];
  // cardExpired.text = value['cardExpired'];
  // cardType.text = value["cardType"];
  // cardName.text = value["cardName"];
  // cardOwner.text = value["cardOwner"];
  String? cardExpired;
  String? cardName;
  String? cardOwner;
  String? cardType;
  String? cardNumber;
  String? cardId;
  String? userId;
  int? gradient;

  CardModel({this.cardExpired, this.userId, this.cardId, this.gradient, this.cardOwner, this.cardName, this.cardType, this.cardNumber});

  CardModel.fromJson(Map<String, dynamic> json) {
    cardExpired = json['cardExpired'];
    cardId = json['cardId'];
    userId = json['userId'];
    gradient = json['gradient'];
    cardOwner = json['cardOwner'];
    cardName = json['cardName'];
    cardType = json['cardType'];
    cardNumber = json['cardNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardExpired != null) {
      data['cardExpired'] = cardExpired!;
      data['cardId'] = cardId!;
      data['userId'] = userId!;
      data['gradient'] = gradient!;
      data['cardOwner'] = cardOwner!;
      data['cardName'] = cardName!;
      data['cardType'] = cardType!;
      data['cardNumber'] = cardNumber!;
    }
    return data;
  }
}
