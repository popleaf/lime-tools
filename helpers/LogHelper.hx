package helpers;


import haxe.io.Bytes;
import helpers.PlatformHelper;
import neko.Lib;
import project.Platform;


class LogHelper {
	
	
	public static var mute:Bool;
	public static var verbose:Bool = false;
	
	private static var asciiCode:EReg = ~/\x1b\[[^m]+m/g;
	private static var sentWarnings:Map <String, Bool> = new Map <String, Bool> ();
	
	
	public static function error (message:String, verboseMessage:String = "", e:Dynamic = null):Void {
		
		if (message != "" && !mute) {
			
			var output;
			
			if (verbose && verboseMessage != "") {
				
				output = "Error: " + verboseMessage + "\n";
				
			} else {
				
				output = "Error: " + message + "\n";
				
			}
			
			Sys.stderr ().write (Bytes.ofString (output));
			
		}
		
		if (verbose && e != null) {
			
			Lib.rethrow (e);
			
		}
		
		Sys.exit (1);
		
	}
	
	
	public static function info (message:String, verboseMessage:String = ""):Void {
		
		if (!mute) {
			
			if (verbose && verboseMessage != "") {
				
				Sys.println (verboseMessage);
				
			} else if (message != "") {
				
				Sys.println (message);
				
			}
			
		}
		
	}
	
	
	public static function print (message:String):Void {
		
		if (PlatformHelper.hostPlatform == Platform.WINDOWS) {
			
			Sys.print (asciiCode.replace (message, ""));
			
		} else {
			
			Sys.print (message);
			
		}
		
	}
	
	
	public static function println (message:String):Void {
		
		if (PlatformHelper.hostPlatform == Platform.WINDOWS) {
			
			Sys.println (asciiCode.replace (message, ""));
			
		} else {
			
			Sys.println (message);
			
		}
		
	}
	
	
	public static function warn (message:String, verboseMessage:String = "", allowRepeat:Bool = false):Void {
		
		if (!mute) {
			
			var output = "";
			
			if (verbose && verboseMessage != "") {
				
				output = "Warning: " + verboseMessage;
				
			} else if (message != "") {
				
				output = "Warning: " + message;
				
			}
			
			if (!allowRepeat && sentWarnings.exists (output)) {
				
				return;
				
			}
			
			sentWarnings.set (output, true);
			Sys.println (output);
			
		}
		
	}

}
