//
//  Parsing Functions.swift
//  PTVN to PF
//
//  Created by Fool on 12/11/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Foundation

//Cribbed from raywenderlich.com.  Updated for Swift 2.0
extension String {
	func stringByTrimmingLeadingAndTrailingWhitespace() -> String {
		let leadingAndTrailingWhitespacePattern = "\\s*\\n"
		//"(?:^\\s+)|(?:\\s+$)"
		
		do {
			let regex = try NSRegularExpression(pattern: leadingAndTrailingWhitespacePattern, options: .DotMatchesLineSeparators)
			let range = NSMakeRange(0, self.characters.count)
			let trimmedString = regex.stringByReplacingMatchesInString(self, options: .ReportProgress, range:range, withTemplate:"\n")
			
			return trimmedString
		} catch _ {
			return self
		}
	}
}


//Extract the text for the different sections from the complete text
func regexTheText(theText: String, startOfText: String, endOfText: String) -> String {
	var theResult = ""
	let regex = try! NSRegularExpression(pattern: "\(startOfText).*?\(endOfText)", options: NSRegularExpressionOptions.DotMatchesLineSeparators)
	let length = theText.characters.count
	
	if let match = regex.firstMatchInString(theText, options: [], range: NSRange(location: 0, length: length)) {
		theResult = (theText as NSString).substringWithRange(match.range)
	}
	return theResult
}

func processPTVNText(theText: String) -> (cc: String, subjective: String, problems: String, newPMH: String, assessment: String, plan: String, objective: String) {
	
	var cheifComplaint = ""
	var subjectiveText = ""
	var problemsText = ""
	var newPMHText = ""
	var assessmentText = ""
	var planText = ""
	var objectiveText = ""
	
	print("Getting the CC\n")
	cheifComplaint = regexTheText(theText, startOfText: ccBeginning, endOfText: ccEnding)
	cheifComplaint = cheifComplaint.stringByReplacingOccurrencesOfString("\nS:", withString: "")
	cheifComplaint = cheifComplaint.stringByTrimmingLeadingAndTrailingWhitespace()
	
	print("Getting subjective/n")
	subjectiveText = regexTheText(theText, startOfText: subjectiveBeginning, endOfText: subjectiveEnding)
	subjectiveText = subjectiveText.stringByReplacingOccurrencesOfString("\nProblems:", withString: "")
	subjectiveText = subjectiveText.stringByTrimmingLeadingAndTrailingWhitespace()
	
	print("Getting problems/n")
	problemsText = regexTheText(theText, startOfText: problemsBeginning, endOfText: problemsEnding)
	problemsText = problemsText.stringByReplacingOccurrencesOfString("\nNEW PMH:", withString: "")
	problemsText = problemsText.stringByTrimmingLeadingAndTrailingWhitespace()
	
	print("Getting new PMH/n")
	newPMHText = regexTheText(theText, startOfText: newPMHBeginning, endOfText: newPMHEnding)
	newPMHText = newPMHText.stringByReplacingOccurrencesOfString("\nA(Charge):", withString: "")
	newPMHText = newPMHText.stringByTrimmingLeadingAndTrailingWhitespace()
	
	print("Getting assessment/n")
	if theText.containsString("A(Charge):") {
		print("New assessment version")
	assessmentText = regexTheText(theText, startOfText: assessmentBeginning, endOfText: assessmentEnding)
	} else if theText.containsString("A (Chrg):") {
		print("Old assessment version")
		assessmentText = regexTheText(theText, startOfText: oldAssessmentBeginning, endOfText: assessmentEnding)
	}
	assessmentText = assessmentText.stringByReplacingOccurrencesOfString("\nP(lan):", withString: "")
	assessmentText = assessmentText.stringByTrimmingLeadingAndTrailingWhitespace()
	
	print("Getting plan/n")
	if theText.containsString("O(PE):") {
	planText = regexTheText(theText, startOfText: planBeginning, endOfText: planEnding)
	} else if theText.containsString("O (PE):") {
		planText = regexTheText(theText, startOfText: planBeginning, endOfText: oldPlanEnding)
	}
	planText = planText.stringByReplacingOccurrencesOfString("O(PE):", withString: "")
	planText = planText.stringByReplacingOccurrencesOfString("O (PE):", withString: "")
	planText = planText.stringByTrimmingLeadingAndTrailingWhitespace()
	
	print("Getting objective/n")
	if theText.containsString("O(PE):") {
	objectiveText = regexTheText(theText, startOfText: objectiveBeginning, endOfText: objectiveEnding)
	} else if theText.containsString("O (PE):") {
	objectiveText = regexTheText(theText, startOfText: oldObjectiveBeginning, endOfText: oldObjectiveEnding)
	}
	objectiveText = objectiveText.stringByReplacingOccurrencesOfString("\nCURRENT MEDICATIONS:", withString: "")
	objectiveText = objectiveText.stringByReplacingOccurrencesOfString("\nALLERGIES:", withString: "")
	objectiveText = objectiveText.stringByTrimmingLeadingAndTrailingWhitespace()
	
	print(cheifComplaint)
	print(subjectiveText)
	print(problemsText)
	print(newPMHText)
	print(assessmentText)
	print(planText)
	print(objectiveText)
	
	return (cheifComplaint, subjectiveText, problemsText, newPMHText, assessmentText, planText, objectiveText)
}

func getFileNameFromFilePath() {
	
}

