//
//  Parsing Variables.swift
//  PTVN to PF
//
//  Created by Fool on 12/14/15.
//  Copyright © 2015 Fulgent Wake. All rights reserved.
//

import Foundation

let ccBeginning = "CC:"
let ccEnding = "S:"

let subjectiveBeginning = "S:"
let subjectiveEnding = "Problems:"

let problemsBeginning = "Problems:"
let problemsEnding = "NEW PMH:"

let newPMHBeginning = "NEW PMH:"
let newPMHEnding = "A\\(Charge\\):"
let oldNewPMHEnding = "A \\(Chrg\\):"

let assessmentBeginning = "A\\(Charge\\):"
let oldAssessmentBeginning = "A \\(Chrg\\):"
let assessmentEnding = "P\\(lan\\):"

let planBeginning = "P\\(lan\\):"
let planEnding = "O\\(PE\\):"
let oldPlanEnding = "O \\(PE\\):"

let objectiveBeginning = "O\\(PE\\):"
let oldObjectiveBeginning = "O \\(PE\\)"
let objectiveEnding = "CURRENT MEDICATIONS:"
let oldObjectiveEnding = "ALLERGIES:"