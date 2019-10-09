struct CourseInfo: Hashable, Codable, CourseInfoProtocol {
    
    let courseTitle:String
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
    
}
