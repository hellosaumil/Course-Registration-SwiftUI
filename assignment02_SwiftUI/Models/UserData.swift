//
//  UserData.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/30/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import Combine
import Foundation

final class UserData: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()

    @Published var currentStudent:StudentInfo = studentData {
        willSet {
            willChange.send()
        }
    }
    
    @Published var availableCourses:[CourseInfo] = courseListData {
        willSet {
            willChange.send()
        }
    }
    
    @Published var isCourseSelected:Dictionary<CourseInfo, Bool> = courseSelection {
        willSet {
            willChange.send()
        }
    }
}



// TODO:
//
// - Save Data onDisappear of Course Selction in AvailableCoursesView
//
// - Data Validation
//      - Red ID should only be 9 digits (􀆅)
//      - Email should contain @ (􀆅)
//      - Update Profile should display corresponding error message (--)
//      - Check if Course Times Clash (optional)
//
// - Create Project-wide Contraints
//      - Create reusable validaton values for different properties
//      - To avoid re-writing @ or 9-digit
//
// - Data Types should be other than String
//      - Change Red ID to Int (􀆅)
//      - Change Course Start Time to Date & Time
//      - Write getters to provide formatted data (--)
//
// - File Persistance (Write Data to File)
//      - Not Working (Saves file in Simulator, but not on Physical Device)
//
// - OnDisappear NOT WORKING
//
// - Modify enroll / unenroll functions to compare courses or add == Equatable
