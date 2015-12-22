//
//  GlobalVariables.swift
//  PTVN to PF
//
//  Created by Fool on 12/19/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Foundation

class GlobalVars {
	var ptvnText = String()
	var ptvnURL = String()
	
	init(ptvnText: String = "", ptvnURL: String = "") {
		self.ptvnText = ptvnText
		self.ptvnURL = ptvnURL
	}
}

struct MWCStruct {
	static var mwcFileName = String()
	//static var mwcFileURL = NSURL()
	//static var mwcFileNameFromURL = (MWCStruct.mwcFileURL.pathComponents?.last)! as String
	
	static var mwcSwitch: Int = 1 //{
//		didSet {
//			if mwcSwitch == 0 {
//				print("Switch accepted")
//				do {
//					var dadText = GlobalVars()
//					dadText.ptvnText = try String(contentsOfFile: mwcFileName, encoding: NSUTF8StringEncoding)
//					dadText.ptvnURL = mwcFileName
//					print(dadText.ptvnText)
//					let processedText = processPTVNText(dadText.ptvnText)
//					//getFileNameFromFilePath()
//				} catch {
//					print("Try failed again")
//				}
//			}
//			
//		}
	//}
}