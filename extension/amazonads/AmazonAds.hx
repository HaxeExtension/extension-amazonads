/* Copyright (c) 2015 Pozirk Games
 * http://www.pozirk.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package extension.amazonads;

import openfl.events.EventDispatcher;
#if android
import openfl.utils.JNI;
#end

/**
 * Main AmazonAds class
 * @author Pozirk Games (http://www.pozirk.com)
 */
class AmazonAds extends EventDispatcher
{
	public static inline var SIZE_1024x50:Int = 1; //1024x50
	public static inline var SIZE_300x250:Int = 2; //300x250
	public static inline var SIZE_300x50:Int = 3; //300x50
	public static inline var SIZE_320x50:Int = 4; //320x50
	public static inline var SIZE_600x90:Int = 5; //600x90
	public static inline var SIZE_728x90:Int = 6; //728x90
	public static inline var SIZE_AUTO:Int = 7; //auto
	
	//> from: http://developer.android.com/reference/android/widget/RelativeLayout.html
	public static inline var HALIGN_LEFT:Int = 9;
	public static inline var HALIGN_CENTER:Int = 14;
	public static inline var HALIGN_RIGHT:Int = 11;
	
	public static inline var VALIGN_TOP:Int = 10;
	public static inline var VALIGN_MIDDLE:Int = 15;
	public static inline var VALIGN_BOTTOM:Int = 12;
	//<
	
	private static inline var EXT_AMAZONADS:String = "com.pozirk.ads.AmazonAds";
	
#if android
	public var _inited(default, null):Int = 0;
	private var _initFunc:Dynamic;
	private var _showAdFunc:Dynamic;
	private var _hideAdFunc:Dynamic;
	private var _cacheInterstitialFunc:Dynamic;
	private var _showInterstitialFunc:Dynamic;
	private var _enableTestingFunc:Dynamic;
	private var _enableLoggingFunc:Dynamic;
	
	public function init(appID:String, maxHeight:Int = 0)
	{
		if(_initFunc == null)
			_initFunc = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "init", "(Ljava/lang/String;Lorg/haxe/lime/HaxeObject;)V");
			
		_initFunc(appID, this);

		if(maxHeight>0) {
			trace("maxHeight: "+maxHeight);
			var setMaxHeight:Int->Void = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "setMaxHeight", "(I)V");
			setMaxHeight(maxHeight);
		}
	}

	/**
	 * Show ad
	 * @param	size - one of the constants from AdParams
	 * @param	halign - left, center, right,  from AdParams
	 * @param	valign - from AdParams
	 */
	public function showAd(size:Int, halign:Int, valign:Int):Void
	{
		if(_inited == 1)
		{
			if(_showAdFunc == null)
				_showAdFunc = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "showAd", "(III)V");
			
			_showAdFunc(size, halign, valign);
		}
		else
			onStatus(AmazonAdsEvent.AD_SHOW_FAIL, "Amazon Ads not initialized!");
	}
	
	public function hideAd():Void
	{
		if(_hideAdFunc == null)
			_hideAdFunc = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "hideAd", "()V");
			
		_hideAdFunc();
	}
	
	/**
	 * Cache interstitial ad, listen for AmazonAdsEvent.INTERSTITIAL_CACHE_OK before showing it
	 */
	public function cacheInterstitial():Void
	{
		if(_inited == 1)
		{
			if(_cacheInterstitialFunc == null)
				_cacheInterstitialFunc = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "cacheInterstitial", "()V");
			
			_cacheInterstitialFunc();
		}
		else
			onStatus(AmazonAdsEvent.INTERSTITIAL_CACHE_FAIL, "Amazon Ads not initialized!");
	}

	/**
	 * Show interstitial ad, if it is not cached yet, nothing will be shown
	 */
	public function showInterstitial():Void
	{
		if(_showInterstitialFunc == null)
			_showInterstitialFunc = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "showInterstitial", "()V");
			
		_showInterstitialFunc();
	}
	
	public function enableTesting(enable:Bool):Void
	{
		if(_enableTestingFunc == null)
			_enableTestingFunc = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "enableTesting", "(Z)V");
			
		_enableTestingFunc(enable);
	}
	
	public function enableLogging(enable:Bool):Void
	{
		if(_enableLoggingFunc == null)
			_enableLoggingFunc = openfl.utils.JNI.createStaticMethod(EXT_AMAZONADS, "enableLogging", "(Z)V");
			
		_enableLoggingFunc(enable);
	}

	public function onStatus(code:String, reason:String):Void
	{
		//trace("onStatus: "+code+": "+reason);
		var aae:AmazonAdsEvent = null;
		switch(code)
		{
			case "INIT_OK":
				_inited = 1;
				aae = new AmazonAdsEvent(AmazonAdsEvent.INIT_OK, "");
			
			case "AD_LOADED":
				aae = new AmazonAdsEvent(AmazonAdsEvent.AD_LOADED, reason);
			
			case "AD_EXPANDED":
				aae = new AmazonAdsEvent(AmazonAdsEvent.AD_EXPANDED, reason);
			
			case "AD_COLLAPSED":
				aae = new AmazonAdsEvent(AmazonAdsEvent.AD_COLLAPSED, reason);
			
			case "AD_FAILED_TO_LOAD":
				aae = new AmazonAdsEvent(AmazonAdsEvent.AD_FAILED_TO_LOAD, reason);
			
			case "AD_DISMISSED":
				aae = new AmazonAdsEvent(AmazonAdsEvent.AD_DISMISSED, reason);
		}
		
		if(aae != null)
			this.dispatchEvent(aae);
	}
#end
}