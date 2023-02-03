import 'dart:async';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  String adBannerUnitId = 'ca-app-pub-3940256099942544/6300978111';
  String adInterstitialUnitId = 'ca-app-pub-3940256099942544/1033173712';

   BannerAd? myBanner, myMediumBanner;

   bool isNotSubscribed = false;

  @override
  void onInit() {
    if(isNotSubscribed) {
      createBannerAd();
      createMediumBannerAd();
    }
    super.onInit();

  }

  BannerAd createBannerAd() {
    myBanner = BannerAd(
      adUnitId: adBannerUnitId,
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: listener,
    );

    myBanner?.load();
    return myBanner!;
  }

  BannerAd createMediumBannerAd() {
    myMediumBanner = BannerAd(
      adUnitId: adBannerUnitId,
      size: AdSize.mediumRectangle,
      request: const AdRequest(),
      listener: listener,
    );

    myMediumBanner?.load();
    return myMediumBanner!;
  }

  AdWidget? get adWidget {
    return isNotSubscribed ? AdWidget(ad: myBanner!) : null;
  }

  AdWidget? get adMediumWidget {
    return isNotSubscribed ? AdWidget(ad: myMediumBanner!) : null;
  }

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
      print('Ad failed to load: ${error.message}');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  //...
  InterstitialAd? interstitialAd;
  Timer? timer;
  void getInterstitialAd() {
    if(isNotSubscribed) {
      InterstitialAd.load(
          adUnitId: adInterstitialUnitId,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              // Keep a reference to the ad so you can show it later.
              interstitialAd = ad;
              interstitialAd?.fullScreenContentCallback =
                  FullScreenContentCallback(
                    onAdShowedFullScreenContent: (InterstitialAd ad) =>
                        print('%ad onAdShowedFullScreenContent.'),
                    onAdDismissedFullScreenContent: (InterstitialAd ad) {
                      print('$ad onAdDismissedFullScreenContent.');
                      ad.dispose();
                    },
                    onAdFailedToShowFullScreenContent:
                        (InterstitialAd ad, AdError error) {
                      print('$ad onAdFailedToShowFullScreenContent: $error');
                      ad.dispose();
                    },
                    onAdImpression: (InterstitialAd ad) =>
                        print('$ad impression occurred.'),
                  );
              interstitialAd?.show();
            },
            onAdFailedToLoad: (LoadAdError error) {
              print('InterstitialAd failed to load: $error');
            },
          ));
      timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
        if (interstitialAd == null) {
          InterstitialAd.load(
              adUnitId: adInterstitialUnitId,
              request: AdRequest(),
              adLoadCallback: InterstitialAdLoadCallback(
                onAdLoaded: (InterstitialAd ad) {
                  // Keep a reference to the ad so you can show it later.
                  interstitialAd = ad;
                  interstitialAd?.fullScreenContentCallback =
                      FullScreenContentCallback(
                        onAdShowedFullScreenContent: (InterstitialAd ad) =>
                            print('%ad onAdShowedFullScreenContent.'),
                        onAdDismissedFullScreenContent: (InterstitialAd ad) {
                          print('$ad onAdDismissedFullScreenContent.');
                          interstitialAd == null;
                          ad.dispose();
                        },
                        onAdFailedToShowFullScreenContent:
                            (InterstitialAd ad, AdError error) {
                          print(
                              '$ad onAdFailedToShowFullScreenContent: $error');
                          interstitialAd == null;
                          ad.dispose();
                        },
                        onAdImpression: (InterstitialAd ad) =>
                            print('$ad impression occurred.'),
                      );
                  interstitialAd?.show();
                },
                onAdFailedToLoad: (LoadAdError error) {
                  interstitialAd == null;
                  print('InterstitialAd failed to load: $error');
                },
              )).onError((error, stackTrace) => interstitialAd == null);
        }
      });
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
