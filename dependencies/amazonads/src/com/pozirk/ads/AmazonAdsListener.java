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
import com.amazon.device.ads.*;
import org.haxe.lime.HaxeObject;

public class AmazonAdsListener implements AdListener
{
	protected HaxeObject _callback = null;
	protected String _who = null;
	
	public AmazonAdsListener(HaxeObject callback, String who)
	{
		_callback = callback;
		_who = who;
	}
	
   public void onAdLoaded(Ad ad, AdProperties adProperties)
	 {
		//Log.d("amazonads", "onAdLoaded");
		_callback.call("onStatus", new Object[] {"AD_LOADED", _who, "type: "+_who});
   }

   public void onAdFailedToLoad(Ad ad, AdError error)
   {
		//Log.d("amazonads", "onAdFailedToLoad: "+error.getMessage());
		_callback.call("onStatus", new Object[] {"AD_FAILED_TO_LOAD", _who, "type: "+_who+", "+error.getCode()+": "+error.getMessage()});
   }

   public void onAdExpanded(Ad ad)
  {
    _callback.call("onStatus", new Object[] {"AD_EXPANDED", _who, "type: "+_who});
  }

  public void onAdCollapsed(Ad ad)
  {
  	_callback.call("onStatus", new Object[] {"AD_COLLAPSED", _who, "type: "+_who});
  }
  
  public void onAdDismissed(Ad ad)
  {
  	_callback.call("onStatus", new Object[] {"AD_DISMISSED", _who, "type: "+_who});
  }
}