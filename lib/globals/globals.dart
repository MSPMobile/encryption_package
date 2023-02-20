import 'package:flutter/material.dart';

String phase = "XOR Operation Step 1/4";
String operationResult = "- -";
String AADString = "- -";
String AESValue = "- -";
String AESbase64String = "- -";
String JWTValue = "- -";
String CertificateString =
    "MIIDkzCCAnugAwIBAgIJAPa22SR+Iz6AMA0GCSqGSIb3DQEBCwUAMFYxCzAJBgNVBAYTAklOMQswCQYDVQQIDAJUTjEKMAgGA1UEBwwBQzEOMAwGA1UECgwFRWFnbGUxCzAJBgNVBAsMAklUMREwDwYDVQQDDAhFYWdsZTAwMTAeFw0yMzAxMjQxMzUyNTBaFw0yMzA3MjMxMzUyNTBaMFQxCzAJBgNVBAYTAklOMQswCQYDVQQIDAJUTjEKMAgGA1UEBwwBQzENMAsGA1UECgwESGlsZDELMAkGA1UECwwCSVQxEDAOBgNVBAMMB0hpbGQwMDEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/9DVXzjjpyTve6dbpzR9ERRWPvpaP6LWwZbtwRzvOi52FwzozMuZ2uFLoQ4EQhhgGHp8UWeBeHFSj0PieL/BBzBJPf1/cthI3T1yuMAk2pLV2+Rmxt38yh6kb0N6yYNIzTO1aSSLcfGpNb/K3jnc4cp1RDKYFNGONYA2HjKGV4jtgOK9qwR+RyYOrQ0xY29vqRu70ZMyLhOo8cfYKqbHln+1Uye44ocqwjf/sLTDaLCldcf7KfhM1g4fUgMet9Z3h50g4tZB3JIYvYrHLDPVDqSgx6TQL69KOyUo3y+/h/EFP3uwkCISNNq1aAE9NRartmeodl5cHmRmkP9n5SmM9AgMBAAGjZjBkMB0GA1UdDgQWBBQjxnyWemT2nDO1VhFrWoU4P3SCVzAfBgNVHSMEGDAWgBSZFGKt5Vn2V9bt3YBq5iGPQNAaGjASBgNVHRMBAf8ECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBhjANBgkqhkiG9w0BAQsFAAOCAQEAar3rCZiDrblQoAp2rGIjiHbrf21QdyfI+rUCTfbcewcuoWffS32AUdqXRGo+HLE+0rk47pYxvEh5ZsTQLphONO2ozNljbmx87m5od1EDWuoJLWR/iAEBD0nnW040YfCcZVlhbaHvQCzsjwfPnlxSfCQp2xaeS+7xl+waYNBTzRUUO4rtsWCWHdxDuXKD0mlpWx58ootYOlWteIFuPYgm+meR7oVa4pvqclboOfSG2DbAyxPs6jISOr341XBH2ANS78ZeC8WFXK0MXCaWbEL7ZCuhj6pb694WeBBnUmo7mKt1DZN08TMX9bALY7TtluDCJ95paiYjZLY8EEUntv9f/Q==";
String firstJWT = "";
String AESsample =
    "A4lGo1p5tarCBuvk94swmTJQMA6Oxahlyho0nd-tV4iMbjgQeS90VmWqyHmdgCauOWY9aLn9TA4-82XTsS9JUVF9q0ngaCek34f2QCwzjgE5GxH0Nrya4ENqYAHHCnY-bV-3VHvhl8NkDLthyLhwWKptZ5yIjScvdhze06W-K4rNl1IU8oGdTA9-03th5bj7MpX5Z7XONtbdKy8AEYlAXAc9kGumShOA5aOl2VLSsW2crHdxfghdhxdh1ud6BSp7WZzsta2VfekyByBldcZHWx-jHW-niQqn00hNiKNsl8rbjLoDpIzTrlXLTIE0bnGFANafj-gBZ-zQKXWjPUm6K9Zdh7zWwE6Q";
String aesHEX = "- -";

String IVString = "- -";
List<int> XORBytes = <int>[];
List<int> AAD = <int>[];
List<int> IV = <int>[];

// ================================= List ======================================
Map<String, String> jwtInnerPayLoad = {
  "deviceSubType": "Single",
  "model": "SM-91M",
  "type": "Face",
  "make": "MIAXIS",
  "serialNo": "2210000002",
  "deviceProvider": "NPrime Technologies Pvt. Ltd.",
  "deviceProviderId": "NPrimeDPS",
};

Map<String, String> jwtPayLoad = {
  "digitalId": firstJWT,
  "deviceCode": "2310000002",
  "env": "Staging",
  "transactionId": "4560504288",
  "domainUri": "https://api.apps-external.ocp.mspsandbox.com",
  "bioType": "Face",
  "deviceServiceVersion": "0.9.5.1.5",
  "bioSubType": "",
  "qualityScore": "54",
  "requestedScore": "40",
  "bioValue": "QGw1npKzLyYqHpCgRiDlSdeBofHaMtfWtbJS",
  "timestamp": "2023-02-07T08:17:23.697Z",
};
//==============================================================================
//================================== Colors ====================================
Color primaryColorXor = Color.fromARGB(255, 239, 121, 4);
Color SecondaryColorXor = Color.fromARGB(255, 38, 113, 0);
Color primaryColorAEs = Color.fromARGB(255, 0, 4, 134);
Color primaryColorJWT = Color.fromARGB(255, 98, 1, 113);

class Colorspallette {
  MaterialColor customPallette = MaterialColor(0xffe55f48, <int, Color>{});
}
//==============================================================================
// String extractString(String string) 
// {
//   String extract = base64.deco
// }
