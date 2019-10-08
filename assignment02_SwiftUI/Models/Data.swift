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


let courseListData: [CourseInfo] = loadCourseListData("courseList", "json")
let studentData: StudentInfo = loadStudentData("studentData", "json")

let courseSelection: Dictionary<CourseInfo, Bool> = Dictionary(uniqueKeysWithValues: courseListData.map({ ($0, false) }))


// MARK: User Defined Functinos
//
// User Defined Functions for Loading Student and Course Data
//

func loadStudentData(_ filename: String, _ ext:String? = nil) -> StudentInfo {
    
    let loadedStudentData: StudentInfo
    
    do {
        loadedStudentData = try load(filename, ext)
    } catch {
        
        let noRecordStudent:StudentInfo = StudentInfo("", "@", 000_000_000, [])!
        loadedStudentData = noRecordStudent
    }
    
    return loadedStudentData
}


func loadCourseListData(_ filename: String, _ ext:String? = nil) -> [CourseInfo] {
    
    let loadedCourseListData: [CourseInfo]
    
    do {
        loadedCourseListData = try load(filename, ext)
    } catch {
        
        let sampleCourseData = [CourseInfo]()
        loadedCourseListData = sampleCourseData
    }
    
    return loadedCourseListData
}

enum DataLoadSaveError: Error{
    
    case fileNotFound, coudlNotLoadFromBundle, coudlNotSaveToBundle, coudlNotParse
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

//
// Original Code of the load function has been modified.
//
// load function used from the following url:
// https://developer.apple.com/tutorials/swiftui/creating-and-combining-views
//
//
func load<T: Decodable>(_ filename: String, _ fileExtension:String? = nil, as type: T.Type = T.self) throws -> T {
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


func save<T: Encodable>(_ filename: String, data: T, _ fileExtension:String? = nil, as type: T.Type = T.self) throws {
    
    let jsonData: Data
    let jsonString:String = ""
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: fileExtension)
        else {
            print("Save: Couldn't find \(filename) in main bundle.")
            throw DataLoadSaveError.fileNotFound
    }
    
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        jsonData = try encoder.encode(data)
        
    } catch {
        print("Save: Couldn't parse \(filename) as \(T.self):\n\(error)")
        throw DataLoadSaveError.coudlNotParse
    }
    
    
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print("Save: jsonString: \n\(jsonString)")
        print("Attemting to Save at: \(file)...")
        
    } else {
        print("\tSave: Couldn't convert jsonData to jsonString :\n")
        throw DataLoadSaveError.coudlNotParse
    }
    
    
    do {
        try jsonString.write(to: file, atomically: true, encoding: .utf8)
        print("\tFile Saved at: \(file)")
        
    } catch {
        
        print("Save: Couldn't save \(filename) to main bundle:\n\(error)")
        throw DataLoadSaveError.coudlNotSaveToBundle
    }
    
}

func saveStudentData(UpdatedStudentInfo:StudentInfo) throws {
    
    do {
        try save("studentData.json", data: UpdatedStudentInfo)
        print("Data Saved.\n")
        
    } catch {
        print("\tCan't Save Student Data...\(error)\n")
        throw error
    }
    
}
