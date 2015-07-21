Introduction
============
AmazonAds OpenFL Extension. (Adnroid only)

More info on Amazon Ads: https://developer.amazon.com/appsandservices/apis


Platforms
=========
Android (Kindle Fire)


License
=======
AmazonAds OpenFL Extension is free, open-source software under the [MIT license](LICENSE.md).


Installation
=======
You can easily install AmazonAds extension using haxelib:

	haxelib install extension-amazonads

To add it to a OpenFL project, add this to your project file:

	<haxelib name="extension-amazonads" />


Usage
=======
```haxe
import extension.amazonads.AmazonAds;
import extension.amazonads.AmazonAdsEvent;

...

_amazonAds = new AmazonAds();
_amazonAds.addEventListener(AmazonAdsEvent.INIT_OK, onAmazonAdsInit);
_amazonAds.addEventListener(AmazonAdsEvent.INTERSTITIAL_CACHE_OK, onAmazonAdsCache);
_amazonAds.init([APP ID]); //you can only use Amazon Ads after successful initialization
//_amazonAds.enableTesting(true); //only enable to see test ads
//_amazonAds.enableLogging(true); //enable to see extra debug information

...

function onAmazonAdsInit(aae:AmazonAdsEvent):Void
{
	_amazonAds.showAd(AmazonAds.SIZE_AUTO, AmazonAds.HALIGN_CENTER, AmazonAds.VALIGN_TOP);
	_amazonAds.cacheInterstitial();
}

...

private function onAmazonAdsCache(aae:AmazonAdsEvent):Void
{
	_amazonAds.showInterstitial();
}
```


Game with Amazon Ads extension
=======
Match Jong: http://www.amazon.com/Pozirk-Games-Match-Jong/dp/B00U6EKC9E/

Play level 2 in order to see interstitial ad.