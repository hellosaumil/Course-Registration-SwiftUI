//
//  StudentInfo.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/30/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import Foundation

// A student has a name, email address and a red id. A course has number (CS 646), a title (iPad/iPhone Application Development), a room number (GC 1504) and a start time (7:00 pm).


func validateStudentValues(_ studentName:String, _ studentEmail:String, _ studentRedID:Int) -> Bool {
    
    guard studentEmail.contains("@") && (String(studentRedID).count == 9 || studentRedID == 0) else {
        return false
    }
    print("Valid Student")
    return true
}

struct StudentInfo: StudentInfoProtocol, Hashable, Codable, Equatable {
    
    var studentName:String
    var studentEmail:String
    var studentRedID:Int
    var courses = [CourseInfo]()
    
    
    init?(_ studentName:String, _ studentEmail:String, _ studentRedID:Int, _ courses:[CourseInfo]) {
        
        guard validateStudentValues(studentName, studentEmail, studentRedID) else {
            print("Invalid Values : \(studentName), \(studentEmail), \(studentRedID)")
            return nil
        }

        self.studentName = studentName
        self.studentEmail = studentEmail
        self.studentRedID = studentRedID
        self.courses = courses
    }
    
    
     mutating func updateBasicStudentInfo(_ studentName:String, _ studentEmail:String, _ studentRedID:Int) -> Bool {

        guard validateStudentValues(studentName, studentEmail, studentRedID) else {
            return false
        }

        self.studentName = studentName
        self.studentEmail = studentEmail
        self.studentRedID = studentRedID
        
        return true
    }
    
}


protocol StudentInfoProtocol {
    
    var studentName: String { get set }
    var studentEmail: String { get set }
    var studentRedID: Int { get set }
    var courses: [CourseInfo] { get set }
    
}
