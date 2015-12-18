//
//  DragAndDropZone.swift
//  PTVN to PF
//
//  Created by Fool on 12/16/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Cocoa

class DragAndDropZone: NSView, NSWindowDelegate {

	
	let fileTypes = ["txt", "md"]
	var fileTypeIsOK = false
	var droppedFilePath: String = ""
	
	//Need this to avoid error of not calling the required intitializer for the frame
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		commonInit()
	}
	
	
	override func drawRect(dirtyRect: NSRect) {
		super.drawRect(dirtyRect)
    }
	
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
		//registerForDraggedTypes([NSFilenamesPboardType, NSURLPboardType])
	}
	
	func commonInit() {
		self.registerForDraggedTypes([/*NSPasteboardTypeString,*/ NSFilenamesPboardType, NSURLPboardType])
	}
	
	
	override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
		if checkExtension(sender) == true {
		self.fileTypeIsOK = true
		return .Copy
		} else {
			self.fileTypeIsOK = false
			return .None
		}
	}

	
	override func prepareForDragOperation(sender: NSDraggingInfo) -> Bool {
		return true
	}
	
	override func draggingUpdated(sender: NSDraggingInfo) -> NSDragOperation {
		if self.fileTypeIsOK {
			return .Copy
		} else {
			return .None
		}
	}
	

	
	override func performDragOperation(sender: NSDraggingInfo?) -> Bool {
		let board = sender!.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray
		if board != [] {
			MainWindowController.MWCStruct.mwcFileName = board![0] as! String
			Swift.print(MainWindowController.MWCStruct.mwcFileName)
			MainWindowController.MWCStruct.mwcSwitch = 0
			
		}
		//Swift.print(board)
		return true
//		if let board = sender!.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray {
//			if let filePath = board[0] as? String {
//				//This is where you get the path for the dropped file
//				self.droppedFilePath = filePath
//				let fileURL = board[0]
//				//textLabel.stringValue = filePath
//				return true
//				
//			}
//		}
//		return false
	}
	

	func checkExtension(drag: NSDraggingInfo) -> Bool {
		if let board = drag.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray,
			let path = board[0] as? String {
				let url = NSURL(fileURLWithPath: path)
				if let suffix = url.pathExtension {
					for ext in self.fileTypes {
						if ext.lowercaseString == suffix {
							return true
						}
					}
				}
		}
		return false
	}

}
