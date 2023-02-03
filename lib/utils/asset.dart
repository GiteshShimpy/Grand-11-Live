import 'package:flutter/material.dart';

class Asset{

static Widget  imageAsset(String assetName)
 {
  return Image.asset("asset/images/$assetName");
 }
static Widget networkAsset(String  assetName)
 {
  return Image.network(assetName);
 }

}
