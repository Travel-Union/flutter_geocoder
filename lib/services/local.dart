import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoder/model.dart';
import 'package:geocoder/services/base.dart';


/// Geocoding and reverse geocoding through built-lin local platform services.
class LocalGeocoding implements Geocoding {
  static const MethodChannel _channel = MethodChannel('github.com/aloisdeniel/geocoder');

  Future<List<Address>> findAddressesFromCoordinates(Coordinates coordinates, { String locale = "en_US" }) async  {
    final request = coordinates.toMap();
    request["locale"] = locale; //iOS only
    Iterable addresses = await (_channel.invokeMethod('findAddressesFromCoordinates', request) as FutureOr<Iterable<dynamic>>);
    return addresses.map((x) => Address.fromMap(x)).toList();
  }

  Future<List<Address>> findAddressesFromQuery(String address) async {
    Iterable coordinates = await (_channel.invokeMethod('findAddressesFromQuery', { "address" : address }) as FutureOr<Iterable<dynamic>>);
    return coordinates.map((x) => Address.fromMap(x)).toList();
  }
}