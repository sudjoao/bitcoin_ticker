import 'package:dio/dio.dart';

var dio = Dio();
class CoinAPI {
  final String apiUrl = 'https://rest.coinapi.io/';
  Future getBitCoinValue(String criptoCoin, String coin) async {
    var endpoint = apiUrl + 'v1/exchangerate/$criptoCoin/$coin?apikey=$insertTheKeyHere';
    try{
      var response = await dio.get(endpoint);
      return response.data["rate"];
    }catch(e){
      return  "?";
    }
  }
}

CoinAPI coinAPI = CoinAPI();
