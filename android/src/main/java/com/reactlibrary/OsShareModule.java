package com.reactlibrary;

import android.content.Intent;
import android.net.Uri;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import java.io.File;

public class OsShareModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public OsShareModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "OsShare";
    }

    @ReactMethod
    public void share(ReadableMap options, Promise promise) {
        if (!options.hasKey("url")) {
            Error e = new Error("Must provide url");
            promise.reject("No URL", e);
            return;
        }

        String url = options.getString("url");

        Intent intentShareFile = new Intent(Intent.ACTION_SEND);
        File fileWithinMyDir = new File(url);

        if(fileWithinMyDir.exists()) {
            intentShareFile.putExtra(Intent.EXTRA_STREAM, Uri.parse("file://"+url));
            intentShareFile.putExtra(Intent.EXTRA_SUBJECT, "Sharing File...");
            intentShareFile.putExtra(Intent.EXTRA_TEXT, "Sharing File...");
            this.reactContext.startActivity(Intent.createChooser(intentShareFile, "Share"));
        }
    }
}
