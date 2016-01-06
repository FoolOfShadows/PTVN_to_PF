//
//  Parsing Functions.swift
//  PTVN to PF
//
//  Created by Fool on 12/11/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Foundation
import AppKit

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

func processPTVNText(theText: String) -> (cc: String, subjective: String, problems: String, newPMH: String, assessment: String, plan: String, objective: String, meds: String, allergies: String, preventive: String, pmh: String, psh: String, social: String, nutrition: String, fmh: String) {
	
	var cheifComplaint = ""
	var subjectiveText = ""
	var problemsText = ""
	var newPMHText = ""
	var assessmentText = ""
	var planText = ""
	var objectiveText = ""
	var medsText = ""
	var allergiesText = ""
	var preventiveText = ""
	var pmhText = ""
	var pshText = ""
	var socialText = ""
	var nutritionText = ""
	var fmhText = ""
	
	print("Getting the CC\n")
	cheifComplaint = regexTheText(theText, startOfText: ccBeginning, endOfText: ccEnding)
	cheifComplaint = cleanUpText(cheifComplaint, theWords: ["\nS:"])
	
	print("Getting subjective/n")
	subjectiveText = regexTheText(theText, startOfText: subjectiveBeginning, endOfText: subjectiveEnding)
	subjectiveText = cleanUpText(subjectiveText, theWords: ["\nProblems:"])
	
	print("Getting problems/n")
	problemsText = regexTheText(theText, startOfText: problemsBeginning, endOfText: problemsEnding)
	problemsText = cleanUpText(problemsText, theWords: ["\nNEW PMH:"])
	
	print("Getting new PMH/n")
	newPMHText = regexTheText(theText, startOfText: newPMHBeginning, endOfText: newPMHEnding)
	newPMHText = cleanUpText(newPMHText, theWords: ["\nA(Charge):"])
	
	print("Getting assessment/n")
	if theText.containsString("A(Charge):") {
		print("New assessment version")
	assessmentText = regexTheText(theText, startOfText: assessmentBeginning, endOfText: assessmentEnding)
	} else if theText.containsString("A (Chrg):") {
		print("Old assessment version")
		assessmentText = regexTheText(theText, startOfText: oldAssessmentBeginning, endOfText: assessmentEnding)
	}
	assessmentText = cleanUpText(assessmentText, theWords: ["\nP(lan):"])
	
	print("Getting plan/n")
	if theText.containsString("O(PE):") {
	planText = regexTheText(theText, startOfText: planBeginning, endOfText: planEnding)
	} else if theText.containsString("O (PE):") {
		planText = regexTheText(theText, startOfText: planBeginning, endOfText: oldPlanEnding)
	}
	planText = cleanUpText(planText, theWords: ["O(PE):", "O (PE):"])
	
	print("Getting objective/n")
	if theText.containsString("O(PE):") {
	objectiveText = regexTheText(theText, startOfText: objectiveBeginning, endOfText: objectiveEnding)
	} else if theText.containsString("O (PE):") {
	objectiveText = regexTheText(theText, startOfText: oldObjectiveBeginning, endOfText: oldObjectiveEnding)
	}
	objectiveText = cleanUpText(objectiveText, theWords: ["\nCURRENT MEDICATIONS:", "\nALLERGIES:"])
	
	medsText = regexTheText(theText, startOfText: medsBeginning, endOfText: medsEnding)
	medsText = cleanUpText(medsText, theWords: ["\(medsBeginning)", "\(medsEnding)"])
	
	allergiesText = regexTheText(theText, startOfText: allergiesBeginning, endOfText: allergiesEnding)
	allergiesText = cleanUpText(allergiesText, theWords: ["\(allergiesBeginning)", "\(allergiesEnding)"])
	
	preventiveText = regexTheText(theText, startOfText: preventiveBeginning, endOfText: preventiveEnding)
	preventiveText = cleanUpText(preventiveText, theWords: ["\(preventiveBeginning)", "\(preventiveEnding)"])
	
	pmhText = regexTheText(theText, startOfText: pmhBeginning, endOfText: pmhEnding)
	pmhText = cleanUpText(pmhText, theWords: ["\(pmhBeginning)", "\(pmhEnding)"])
	
	pshText = regexTheText(theText, startOfText: pshBeginning, endOfText: pshEnding)
	pshText = cleanUpText(pshText, theWords: ["\(pshBeginning)", "\(pshEnding)"])
	
	socialText = regexTheText(theText, startOfText: socialBeginning, endOfText: socialEnding)
	socialText = cleanUpText(socialText, theWords: ["\(socialBeginning)", "\(socialEnding)"])
	
	nutritionText = regexTheText(theText, startOfText: nutritionBeginning, endOfText: nutritionEnding)
	nutritionText = cleanUpText(nutritionText, theWords: ["\(nutritionBeginning)", "\(nutritionEnding)"])
	
	fmhText = regexTheText(theText, startOfText: fmhBeginning, endOfText: fmhEnding)
	fmhText = cleanUpText(fmhText, theWords: ["\(fmhBeginning)", "\(fmhEnding)"])
	
	print(cheifComplaint)
	print(subjectiveText)
	print(problemsText)
	print(newPMHText)
	print(assessmentText)
	print(planText)
	print(objectiveText)
	print(medsText)
	
	return (cheifComplaint, subjectiveText, problemsText, newPMHText, assessmentText, planText, objectiveText, medsText, allergiesText, preventiveText, pmhText, pshText, socialText, nutritionText, fmhText)
}

func wordIsSpelledCorrect(word: String) -> Bool {
	let checker = NSSpellChecker()
	//let range = NSMakeRange(0, word.characters.count)
	let wordRange = checker.checkSpellingOfString(word, startingAt: 0)
	return wordRange.location == NSNotFound
}

func cleanUpText(theString:String, theWords:[String]) -> String {
	var returnString = theString
	for word in theWords {
		returnString = returnString.stringByReplacingOccurrencesOfString(word, withString: "")
	}
	
	returnString = returnString.stringByTrimmingLeadingAndTrailingWhitespace()
	
	return returnString
}

