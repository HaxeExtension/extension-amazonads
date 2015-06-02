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

package com.pozirk.ads;

//import android.util.Log;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import com.amazon.device.ads.*;

public class AmazonAds extends Extension
{
	protected static AdLayout _adView = null;
	protected static InterstitialAd _interstitial;
	protected static AdSize _adSize = AdSize.SIZE_AUTO;
	protected static RelativeLayout _parentView;
	protected static HaxeObject _callback = null;
	protected static AmazonAdsListener _listenerAd = null;
	protected static AmazonAdsListener _listenerInter = null;
	protected static int maxHeight = 0;
	
	public static void init(String appID, HaxeObject callback)
	{
		_callback = callback;
		_listenerAd = new AmazonAdsListener(_callback, "AD");
		_listenerInter = new AmazonAdsListener(_callback, "INTERSTITIAL");
		
		_parentView = new RelativeLayout(Extension.mainActivity);
		AdRegistration.setAppKey(appID);
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				Extension.mainActivity.addContentView(_parentView, new ViewGroup.LayoutParams(-1, -1));
				//Log.d("amazonads", "main activity: "+Extension.mainActivity);
				_callback.call("onStatus", new Object[] {"INIT_OK", ""});
			}
		});
		
		//Log.d("amazonads", "init: "+callback+" / "+_parentView);
	}

	public static void setMaxHeight(int height)
	{
		maxHeight = height;
	}
	
	public static void showAd(final int size, final int halign, final int valign)
	{
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				RelativeLayout.LayoutParams params;
				switch(size)
				{
				case 1:
					_adSize = AdSize.SIZE_1024x50;
					params = new RelativeLayout.LayoutParams(1024, 50);
					break;
				case 2:
					_adSize = AdSize.SIZE_300x250;
					params = new RelativeLayout.LayoutParams(300, 520);
					break;
				case 3:
					_adSize = AdSize.SIZE_300x50;
					params = new RelativeLayout.LayoutParams(300, 50);
					break;
				case 4:
					_adSize = AdSize.SIZE_320x50;
					params = new RelativeLayout.LayoutParams(320, 50);
					break;
				case 5:
					_adSize = AdSize.SIZE_600x90;
					params = new RelativeLayout.LayoutParams(600, 90);
					break;
				case 6:
					_adSize = AdSize.SIZE_728x90;
					params = new RelativeLayout.LayoutParams(728, 90);
					break;
				default:
					_adSize = AdSize.SIZE_AUTO;
					params = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, maxHeight>0?maxHeight:RelativeLayout.LayoutParams.WRAP_CONTENT);
				}
				
				_adView = new AdLayout(Extension.mainActivity, _adSize);

				_adView.setListener(_listenerAd);

				params.addRule(halign, -1);
				params.addRule(valign, -1);
				_parentView.addView(_adView, params);
				
				AdTargetingOptions adOptions = new AdTargetingOptions(); //use default, but could set age and gender
				_adView.loadAd(adOptions);
				
				//Log.d("amazonads", "showAd: "+size+" / "+halign+" / "+valign);
			}
		});
	}
	
	public static void hideAd()
  {
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				//Log.d("amazonads", "hideAd");
				if(_adView != null)
				{
					_parentView.removeView(_adView);
					_adView.destroy();
				}
				
				_adView = null;
			}
		});
  }
	
	public static void cacheInterstitial()
  {
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				//Log.d("amazonads", "cacheInterstitial");
				_interstitial = new InterstitialAd(Extension.mainActivity);
				
				// Set the listener to use the callbacks below.
				_interstitial.setListener(_listenerInter);

				// Load the interstitial.
				_interstitial.loadAd();
			}
		});
  }
  
  public static void showInterstitial()
  {
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				if(_interstitial != null)
					_interstitial.showAd();
			}
		});
  }
  
  public static void enableTesting(boolean enable)
  {
  	AdRegistration.enableTesting(enable);
		//Log.d("amazonads", "enableTesting: "+enable);
  }
  
  public static void enableLogging(boolean enable)
  {
  	AdRegistration.enableLogging(enable);
		//Log.d("amazonads", "enableLogging: "+enable);
  }
	
	@Override
	public void onDestroy()
	{
		if(_adView != null)
			_adView.destroy();
		
		super.onDestroy();
	}
}