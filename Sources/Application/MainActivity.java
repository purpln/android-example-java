package org.company.app;

import android.util.Log;
import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity {
    
    static {
        System.loadLibrary("Library");
    }
    
    public native String message();
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        TextView textView = new TextView(this);
        
        try {
            String message = message();
            
            String text = String.format(
                "from Swift in Java: %s",
                message
            );
            
            Log.i("java", message);
            
            textView.setText(text);
        } catch (Exception e) {
            Log.e("java", e.getMessage());
            textView.setText("Error: " + e.getMessage());
        }
        
        setContentView(textView);
    }
    
    String string() {
        return "hello world!";
    }
    
    @Override
    public void onBackPressed() {
        toggle();
    }
    
    public native void toggle();
}
