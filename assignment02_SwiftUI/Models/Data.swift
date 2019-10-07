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


let courseInfoStructureData: [CourseInfoStructure] = loadCourseListData("courseList.json")
let courseListData: [CourseInfo] = loadCourseList(courseInfoStructureData)

let someStudent:StudentInfo = StudentInfo("", "@", "---------", [])!
let StudentInfoStructureData: StudentInfoStructure = loadStudentData("studentData.json")
let studentData: StudentInfo = StudentInfo(fromStudent: StudentInfoStructureData) ?? someStudent


let courseSelection: Dictionary<CourseInfo, Bool> = Dictionary(uniqueKeysWithValues: courseListData.map({ ($0, false) }))



// MARK: User Defined Functino
//
// User Defined Functions for Loading Student and Course Data
//

func loadStudentData(_ filename: String) -> StudentInfoStructure {
    
    let loadedStudentData: StudentInfoStructure
    
    do {
        loadedStudentData = try load(filename)
    } catch {
        
        let sampleStudentInfoStruct = StudentInfoStructure("", "@", "---------", [])
        loadedStudentData = sampleStudentInfoStruct
    }
    
    return loadedStudentData
}


func loadCourseListData(_ filename: String) -> [CourseInfoStructure] {
    
    let loadedCourseListData: [CourseInfoStructure]
    
    do {
        loadedCourseListData = try load(filename)
    } catch {
        
        let sampleCourseData = [CourseInfoStructure]()
        loadedCourseListData = sampleCourseData
    }
    
    return loadedCourseListData
}

func loadCourseList(_ courses: [CourseInfoStructure]) -> [CourseInfo] {
    
    var coursesList = [CourseInfo]()
    
    for courseInfoStruct in courses {
        coursesList.append(CourseInfo(fromCourse: courseInfoStruct))
    }
    
    return coursesList
}

enum LoaderError: Error {
    case fileNotFound, coudlNotLoadFromBundle, coudlNotSaveToBundle, coudlNotParse
}


//
// Original Code of the load function has been modified.
//
// load function used from the following url:
// https://developer.apple.com/tutorials/swiftui/creating-and-combining-views
//
//
func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) throws -> T {
    let data: Data
    let loadedData: T
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            print("Couldn't find \(filename) in main bundle.")
            throw LoaderError.fileNotFound
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        print("Couldn't load \(filename) from main bundle:\n\(error)")
        throw LoaderError.coudlNotLoadFromBundle
    }
    
    do {
        let decoder = JSONDecoder()
        loadedData = try decoder.decode(T.self, from: data)
    } catch {
        print("Couldn't parse \(filename) as \(T.self):\n\(error)")
        throw LoaderError.coudlNotParse
    }
    
    return loadedData
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func save<T: Encodable>(_ filename: String, data: T, as type: T.Type = T.self) throws {
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            print("Couldn't find \(filename) in main bundle.")
            throw LoaderError.fileNotFound
    }
    
//    let file = getDocumentsDirectory().appendingPathComponent(filename)
    
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try encoder.encode(data)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            
            print("Attemting to Save at: \(file)...")
            
            do {
                try jsonString.write(to: file, atomically: false, encoding: .utf8)
                print("\tFile Saved at: \(file)")
                
            } catch {
            
                print("Couldn't save \(filename) to main bundle:\n\(error)")
                throw LoaderError.coudlNotSaveToBundle
            }
            
        } else {
            print("\tCouldn't convert jsonData to jsonString :\n")
            throw LoaderError.coudlNotSaveToBundle
        }
        
    } catch {
        print("Couldn't parse \(filename) as \(T.self):\n\(error)")
        throw LoaderError.coudlNotParse
    }
    
}
