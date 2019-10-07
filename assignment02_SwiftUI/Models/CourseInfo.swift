struct CourseInfo: Hashable, Codable, CourseInfoProtocol {
    
//    let id: String
    let courseTitle:String
    let courseNumber: String
    let courseRoomNumber: String
    let courseStartTime: String
    
    
    init(_ courseTitle:String, _ courseNumber:String, _ courseRoomNumber:String, _ courseStartTime:String) {
//        self.id = courseNumber
        
        self.courseTitle = courseTitle
        self.courseNumber = courseNumber
        self.courseRoomNumber = courseRoomNumber
        self.courseStartTime = courseStartTime
    }
    
    init(fromCourse course:CourseInfoStructure) {
        
        self.init(course.courseTitle, course.courseNumber, course.courseRoomNumber, course.courseStartTime)
        
        //for course in courseInfoStructureData {
        //    courseListData.append(CourseInfo(course.courseNumber, course.courseRoomNumber, course.courseStartTime))
    }
    
}

struct CourseInfoStructure: CourseInfoProtocol, Hashable, Codable {
    
    let courseTitle: String
    let courseNumber: String
    let courseRoomNumber: String
    let courseStartTime: String
    
    init(_ courseTitle:String, _ courseNumber:String, _ courseRoomNumber:String, _ courseStartTime:String) {
        
        self.courseTitle = courseTitle
        self.courseNumber = courseNumber
        self.courseRoomNumber = courseRoomNumber
        self.courseStartTime = courseStartTime
    }
}

protocol CourseInfoProtocol {
    
    var courseTitle:String { get }
    var courseNumber:String { get }
    var courseRoomNumber:String { get }
    var courseStartTime:String { get }
    
    //    init(_ courseNumber:String, _ courseRoomNumber:String, _ courseStartTime:String) {
    //
    //        self.courseNumber = courseNumber
    //        self.courseRoomNumber = courseRoomNumber
    //        self.courseStartTime = courseStartTime
    //    }
    
}
