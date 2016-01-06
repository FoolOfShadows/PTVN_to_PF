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

let medsBeginning = "CURRENT MEDICATIONS:"
let medsEnding = "ALLERGIES:"

let allergiesBeginning = "ALLERGIES:"
let allergiesEnding = "PREVENTIVE CARE:"

let preventiveBeginning = "PREVENTIVE CARE:"
let preventiveEnding = "PAST MEDICAL HISTORY:"

let pmhBeginning = "PAST MEDICAL HISTORY:"
let pmhEnding = "PAST SURGICAL HISTORY:"

let pshBeginning = "PAST SURGICAL HISTORY:"
let pshEnding = "NUTRITION:"

let socialBeginning = "SOCIAL HISTORY:"
let socialEnding = "FAMILY HEALTH HISTORY:"

let nutritionBeginning = "NUTRITION:"
let nutritionEnding = "SOCIAL HISTORY:"

let fmhBeginning = "FAMILY HEALTH HISTORY:"
let fmhEnding = "DIAGNOSES:"
