//
//  Data.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/30/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//
// Abstract: Helpers for loading data.
//

import UIKit
import SwiftUI
import Foundation

let noRecordStudent:StudentInfo = StudentInfo("", "@", 000_000_000, [])!

let studentDataFileName:String = "studentData.json"
let courseListDataFileName:String = "courseList.json"

let courseListData: [CourseInfo] = loadCourseListData(courseListDataFileName)
let studentData: StudentInfo = loadStudentData(studentDataFileName)

// Loaded Previous Enrolled Courses, if any
var courseSelection: Dictionary<CourseInfo, Bool> {
    
    var prevCourseSelection:Dictionary<CourseInfo, Bool> = Dictionary(uniqueKeysWithValues: courseListData.map({ ($0, false) }))
   
    for course in studentData.courses {
        prevCourseSelection[course]?.toggle()
    }
    
    return prevCourseSelection
}


// MARK: User Defined Functinos
//
// User Defined Functions for Loading Student and Course Data
//
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}


func loadCourseSelections(_ studentData:StudentInfo, courseSelection:inout Dictionary<CourseInfo, Bool>) {

    for course in studentData.courses {
        courseSelection[course]?.toggle()
    }
    
}


func loadFromAppDirectory<T: Decodable>(_ filename: String, as type: T.Type = T.self) throws -> T {
    
    let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
    
    let data: Data
    let loadedData: T
    
    do {
        
        let fileData = try String(contentsOf: fileURL, encoding: .utf8)
        print("Data Read From File : \(fileData)")
        
        do {
            
            data = try Data(contentsOf: fileURL)
            
            do {
                
                let decoder = JSONDecoder()
                loadedData = try decoder.decode(T.self, from: data)
                
            } catch {
                
                print("Load: Couldn't parse \(fileURL) as \(T.self).\n\(error)")
                throw DataLoadSaveError.coudlNotParse
                
            }
            
        } catch {
            
            print("Load: Couldn't load \(filename).\n\(error)")
            throw DataLoadSaveError.coudlNotLoadFromBundle
        }
        
    } catch {
        
        print("ReadError: \(error)")
        throw error
    }
    
    
    return loadedData
}


func saveAnother<T: Encodable>(_ filename: String, data: T, as type: T.Type = T.self) throws {
    
    let jsonData: Data
    let jsonString:String
    
    let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
    
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        jsonData = try encoder.encode(data)
        
        if let validJsonString = String(data: jsonData, encoding: .utf8) {
            print("Save: jsonString: \n\(validJsonString)")
            print("Attempting to Save at: \(fileURL)...")
            
            jsonString = validJsonString
            
            do {
                
                try jsonString.write(to: fileURL, atomically: false, encoding: .utf8)
                print("\tFile Saved at: \(fileURL)")
                
            } catch {
                
                print("Save: Couldn't save \(fileURL).\n\(error)")
                throw DataLoadSaveError.coudlNotSaveToBundle
            }
            
        } else {
            print("\tSave: Couldn't convert jsonData to jsonString :\n")
            throw DataLoadSaveError.coudlNotParse
        }
        
    } catch {
        print("Save: Couldn't parse \(fileURL) as \(T.self):\n\(error)")
        throw DataLoadSaveError.coudlNotParse
    }
    
}


enum DataLoadSaveError: Error{
    case fileNotFound, coudlNotLoadFromBundle, coudlNotSaveToBundle, coudlNotParse
}


func storeUpdatedUser(_ updatedUser: UserData) -> Bool {
    
    // MARK: Store Updated Student Courses
    let UpdatedStudentInfo = updatedUser.currentStudent
    
    do {
        try saveStudentData(UpdatedStudentInfo)
        return true
        
    } catch {
        
        print("\nError while saving updated Courses\(error.localizedDescription)...\n")
        return false
    }
}


func saveStudentData(_ updatedStudentInfo:StudentInfo) throws {
    
    do {
        try saveAnother(studentDataFileName, data: updatedStudentInfo)
        print("Data Saved.\n")
        
    } catch {
        print("\tCan't Save Student Data...\(error)\n")
        throw error
    }
    
}


func loadStudentData(_ filename: String, _ ext:String? = nil) -> StudentInfo {
    
    let loadedStudentData: StudentInfo
    
    do {
        loadedStudentData = try loadFromAppDirectory(filename)
    } catch {
        loadedStudentData = noRecordStudent
    }
    
    return loadedStudentData
}

func loadCourseListData(_ filename: String) -> [CourseInfo] {
    
    let loadedCourseListData: [CourseInfo]
    
    do {
        loadedCourseListData = try loadFromBundle(filename)
    } catch {
        
        let sampleCourseData = [CourseInfo]()
        loadedCourseListData = sampleCourseData
    }
    
    return loadedCourseListData
}


//
// Original Code of the load function has been modified.
//
// load function used from the following url:
// https://developer.apple.com/tutorials/swiftui/creating-and-combining-views
//
//
func loadFromBundle<T: Decodable>(_ filename: String, _ fileExtension:String? = nil, as type: T.Type = T.self) throws -> T {
    let data: Data
    let loadedData: T
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: fileExtension)
        else {
            print("Load: Couldn't find \(filename) in main bundle.")
            throw DataLoadSaveError.fileNotFound
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        print("Load: Couldn't load \(filename) from main bundle:\n\(error)")
        throw DataLoadSaveError.coudlNotLoadFromBundle
    }
    
    do {
        let decoder = JSONDecoder()
        loadedData = try decoder.decode(T.self, from: data)
    } catch {
        print("Load: Couldn't parse \(filename) as \(T.self):\n\(error)")
        throw DataLoadSaveError.coudlNotParse
    }
    
    return loadedData
}
