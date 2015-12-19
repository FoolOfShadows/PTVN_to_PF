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