//
//  AppDelegate.swift
//  PTVN to PF
//
//  Created by Fool on 12/9/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	var mainWindowController: MainWindowController?


	func applicationDidFinishLaunching(aNotification: NSNotification) {
		//Create an instance of the MainWindowController class pointing to the name of the
		//XIB file
		let mainWindowController = MainWindowController(windowNibName: "MainWindowController")
		//Show the new instance on the screen
		mainWindowController.showWindow(self)
		//Pass the fully instantiated instance back to the top level of AppDelegate
		self.mainWindowController = mainWindowController
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}

	func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
	}


}

