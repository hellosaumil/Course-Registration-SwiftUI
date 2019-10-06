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
// - Data Validation
//      - Red ID should only be 9 digits
//      - Email should contain @
//      - Check if Course Times Clash
//
// - Data Types should be other String
//      - Change Red ID to Int (Changing to Int will cause clash in techtfield binding)
//      - Change Course Start Time to Date & Time
//
// - File Persistance (Write Data to File)
//
