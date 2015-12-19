//
//  MainWindowController.swift
//  PTVN to PF
//
//  Created by Fool on 12/9/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSDraggingDestination {
	
	@IBOutlet weak var dragAndDropZone: DragAndDropZone!
	@IBOutlet weak var originLabel: NSTextField!
	@IBOutlet var ccTextView: NSTextView!
	@IBOutlet var subjectiveTextView: NSTextView!
	@IBOutlet var problemsTextView: NSTextView!
	@IBOutlet var newPMHTextView: NSTextView!
	@IBOutlet var assessmentTextView: NSTextView!
	@IBOutlet var planTextView: NSTextView!
	@IBOutlet var objectiveTextView: NSTextView!
	

	var theFileURL:String = ""
	var readInText = ""

	struct MWCStruct {
		static var mwcFileName = String()
		static var mwcFileURL = NSURL()
		static var mwcSwitch: Int = 1 {
			didSet {
				if mwcSwitch == 0 {
					print("Switch accepted")
					do {
						var dadText = GlobalVars()
						dadText.ptvnText = try String(contentsOfFile: mwcFileName, encoding: NSUTF8StringEncoding)
						dadText.ptvnURL = mwcFileName
						print(dadText.ptvnText)
						let processedText = processPTVNText(dadText.ptvnText)
						//getFileNameFromFilePath()
					} catch {
						print("Try failed again")
					}
				}
					
				}
			}
		}

	var theFilePath: String {return dragAndDropZone.droppedFilePath}
	
    override func windowDidLoad() {
        super.windowDidLoad()
		originLabel.stringValue = "Choose a file"
		MWCStruct.mwcSwitch = 1
		

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
	
	
	
	@IBAction func takeClear(sender: AnyObject) {
		ccTextView.string = ""
		subjectiveTextView.string = ""
		problemsTextView.string = ""
		newPMHTextView.string = ""
		assessmentTextView.string = ""
		planTextView.string = ""
		objectiveTextView.string = ""
	}


	
	@IBAction func selectFile(sender: AnyObject) {
		
		//Create a panel for the user to find the file they want to work on
		let panel = NSOpenPanel()
		panel.canChooseDirectories = false
		panel.canChooseFiles = true
		
		panel.beginSheetModalForWindow(self.window!, completionHandler: { (returnCode) -> Void in
			if returnCode == NSModalResponseOK {
				//The returned URL array should only have one item in it
				//Grab that item and put it in a variable
				var message = panel.URLs[0]
				//Get the name of the file from URL by breaking the URL
				//into path components and grabbing the last item
				//which should be the file name
				self.originLabel.stringValue = (message.pathComponents?.last)!
				//Set the global variable theFileURL to the string value of the
				//chosen file's URL
				self.theFileURL = message.path!
				
				//Read the text contents of the chosen file into the global
				//variable readInText
				do {
					self.readInText = try String(contentsOfFile: self.theFileURL, encoding: NSUTF8StringEncoding)
					print("Read in the text\n")
				} catch {
					print("Try failed\n")
				}

				print(self.readInText)
			}
			})
		
		
		
	}
	
	@IBAction func takeMoreProcessing(sender: AnyObject) {
		do {
			self.readInText = try String(contentsOfFile: MWCStruct.mwcFileName, encoding: NSUTF8StringEncoding)
		} catch {
			print("Try failed again")
		}
		print(self.readInText)
	}
	
	
	@IBAction func takeProcess(sender: AnyObject) {
		//var theCC = "initial value"
		if readInText != "" {
			print("Processing the text\n")
			let processedText = processPTVNText(readInText)
			ccTextView.string = processedText.cc
			subjectiveTextView.string = processedText.subjective
			problemsTextView.string = processedText.problems
			newPMHTextView.string = processedText.newPMH
			assessmentTextView.string = processedText.assessment
			planTextView.string = processedText.plan
			objectiveTextView.string = processedText.objective
		}
	}

    
}
