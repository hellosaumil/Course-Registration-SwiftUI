//
//  StudentInfo.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/30/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import Foundation

// A student has a name, email address and a red id. A course has number (CS 646), a title (iPad/iPhone Application Development), a room number (GC 1504) and a start time (7:00 pm).

struct StudentInfo: Hashable, Codable {
    
//    var id: String
    var studentName:String
    var studentEmail:String
    var studentRedID:String
    
    var courses = [CourseInfo]()
    
    init?(_ studentName:String, _ studentEmail:String, _ studentRedID:String, _ courses:[CourseInfo]) {
        
        if studentEmail.contains("@") && studentRedID.count == 9 {
            
//            self.id = studentRedID
            
            self.studentName = studentName
            self.studentEmail = studentEmail
            self.studentRedID = studentRedID
            
            self.courses = courses
            
        } else {
            
            return nil
        }
    }
    
    init?(fromStudent student:StudentInfoStructure) {
        self.init(student.studentName, student.studentEmail, student.studentRedID, student.courses)
    }
    
    func getStudentInfo() -> StudentInfoStructure {
        
        return StudentInfoStructure(self.studentName, self.studentEmail, self.studentRedID, self.courses)
    }
    
}

struct StudentInfoStructure: StudentInfoProtocol, Hashable, Codable {
    
    var studentName: String
    var studentEmail: String
    var studentRedID: String
    var courses: [CourseInfo]
    
    init(_ studentName:String, _ studentEmail:String, _ studentRedID:String, _ courses:[CourseInfo]) {

        self.studentName = studentName
        self.studentEmail = studentEmail
        self.studentRedID = studentRedID
        self.courses = courses
    }
    
}

protocol StudentInfoProtocol {
    
    var studentName: String { get set }
    var studentEmail: String { get set }
    var studentRedID: String { get set }
    var courses: [CourseInfo] { get set }
    
    //    init(_ courseNumber:String, _ courseRoomNumber:String, _ courseStartTime:String) {
    //
    //        self.courseNumber = courseNumber
    //        self.courseRoomNumber = courseRoomNumber
    //        self.courseStartTime = courseStartTime
    //    }
    
}
