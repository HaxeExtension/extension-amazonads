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

import openfl.events.Event;

/**
 * Ad events
 * @author Pozirk Games (http://www.pozirk.com)
 */
class AmazonAdsEvent extends Event
{
	public static inline var INIT_OK:String = "INIT_OK";
	public static inline var AD_LOADED:String = "AD_LOADED"; //and shown
	public static inline var AD_EXPANDED:String = "AD_EXPANDED"; //user clicked banner
	public static inline var AD_COLLAPSED:String = "AD_COLLAPSED"; //user closed rich media ad
	public static inline var AD_FAILED_TO_LOAD:String = "AD_FAILED_TO_LOAD"; //shit happens
	public static inline var AD_DISMISSED:String = "AD_DISMISSED"; //most likely interstitial was closed by user
	public static inline var INTERSTITIAL_CACHE_FAIL:String = "INTERSTITIAL_CACHE_FAIL";
	public static inline var AD_SHOW_FAIL:String = "AD_SHOW_FAIL";
	
	public var _data:String; //extra info about event
	
	public function new(type:String, data:String = null)
	{
		super(type, false, false);
		_data = data;
	}
}