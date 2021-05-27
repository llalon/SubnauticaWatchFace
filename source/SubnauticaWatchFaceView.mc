 import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Activity;
import Toybox.Time;

class SubnauticaWatchFaceView extends WatchUi.WatchFace {

	hidden var cx;
    hidden var cy;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        
        // Set bounds
        cx = dc.getWidth() / 2;
        cy = dc.getHeight() / 2;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
    
    	//Set displays
    	setClockDisplay();
    	setBatteryDisplay();
    	setAltDisplay();
    	setDateDisplay();
    	setPulseDisplay();
    	setNotifyDisplay();
    	

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

	// Displays
	hidden function setAltDisplay() {
		var alt = Activity.getActivityInfo().altitude;
		var units;
		
		if (System.getDeviceSettings().elevationUnits == System.UNIT_METRIC) {
			units = "M";
		} else {
			units = "ft";
		}
		
		var altDisplay = View.findDrawableById("AltDisplay");
		
		var altString = alt.format("%01d") + " " + units;
		//altString = "10 M";
		
		altDisplay.setText(altString);
	}
	
	hidden function setClockDisplay() {
		var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var clockDisplay = View.findDrawableById("TimeDisplay");
	
        clockDisplay.setText(timeString);
    }
    
    hidden function setBatteryDisplay() {
    	var battery = System.getSystemStats().battery;		
    	var batteryString = battery.format("%d");		
		var batteryDisplay = View.findDrawableById("BatteryDisplay");
		      
		batteryDisplay.setText(batteryString);	
    }
    
    hidden function setDateDisplay() {
    	var now = Time.now();
		var info = Time.Gregorian.info(now, Time.FORMAT_SHORT);
    	var dateString = Lang.format("$1$/$2$", [info.day, info.month]);
    	var dateDisplay = View.findDrawableById("DateDisplay");
    	
    	dateDisplay.setText(dateString);
    }
    
    hidden function setPulseDisplay() {
    	var pulse = Activity.getActivityInfo().currentHeartRate;
    	var pulseString = pulse + "";
    	var pulseDisplay = View.findDrawableById("PulseDisplay");
    	
    	pulseDisplay.setText(pulseString);
    }
    
    hidden function setNotifyDisplay() {
    	var now = Time.now();
		var info = Time.Gregorian.info(now, Time.FORMAT_LONG);
    	var dateString = Lang.format("$1$", [info.day_of_week]);
    	var dateDisplay = View.findDrawableById("NotifyDisplay");
    	
    	dateDisplay.setText(dateString);
    } 
}
