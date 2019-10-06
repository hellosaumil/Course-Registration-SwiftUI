struct CourseInfo: Hashable, Codable, Identifiable, CourseInfoProtocol {
    
    let id: String
    let courseNumber: String
    let courseRoomNumber: String
    let courseStartTime: String
    
    
    //    init() {
    //        self.id = super.courseNumber
    //    }
    //
    //    required init(from decoder: Decoder) throws {
    //        fatalError("init(from:) has not been implemented")
    //    }
    
    //    let courseNumber:String
    //    let courseRoomNumber:String
    //    let courseStartTime:String
    //
    
    init(_ courseNumber:String, _ courseRoomNumber:String, _ courseStartTime:String) {
        self.id = courseNumber
        self.courseNumber = courseNumber
        self.courseRoomNumber = courseRoomNumber
        self.courseStartTime = courseStartTime
    }
    
    init(fromCourse course:CourseInfoStructure) {
        
        self.init(course.courseNumber, course.courseRoomNumber, course.courseStartTime)
        
        //for course in courseInfoStructureData {
        //    courseListData.append(CourseInfo(course.courseNumber, course.courseRoomNumber, course.courseStartTime))
    }
    
}

struct CourseInfoStructure: CourseInfoProtocol, Hashable, Codable {
    
    let courseNumber: String
    let courseRoomNumber: String
    let courseStartTime: String
    
    init(_ courseNumber:String, _ courseRoomNumber:String, _ courseStartTime:String) {
        
        self.courseNumber = courseNumber
        self.courseRoomNumber = courseRoomNumber
        self.courseStartTime = courseStartTime
    }
}

protocol CourseInfoProtocol {
    
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
