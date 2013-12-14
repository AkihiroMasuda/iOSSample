package com.example.adtest56_phonegap;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import org.apache.cordova.*;

public class MainActivity extends DroidGap {

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		super.loadUrl("file:///android_asset/www/top.html");
//		super.loadUrl("file:///android_asset/www/pgMedia.html");
//		super.loadUrl("file:///android_asset/www/pgFilePicker.html");
//		super.loadUrl("file:///android_asset/www/file.html");
//		super.loadUrl("file:///android_asset/www/accelerometer.html");
//		super.loadUrl("file:///android_asset/www/compass.html");
	}
}
