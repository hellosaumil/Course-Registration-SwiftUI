//
//  CourseInfoView.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 10/4/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import SwiftUI

struct CourseInfoView: View {
    
    @State var courseInformation: CourseInfo
    
    private func displayText(_ txtMsg:String = "Empty Text Message", _ fontStyle: Font.TextStyle = .body, _ fontDesign: Font.Design = .default) -> Text {
        
        return Text(txtMsg)
            .font(.system(fontStyle, design: fontDesign))
    }
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            VStack(alignment: .leading, spacing: 4) {
                
                displayText("\(courseInformation.courseNumber)", .title, .serif)
                    .bold()
                    .lineLimit(1)
                    .truncationMode(.middle)
                
                Divider()
                
                displayText("\(courseInformation.courseTitle)", .body, .rounded)
                    .lineLimit(3)
                    .truncationMode(.middle)
                    .frame(height: 45)
                //                    .frame(width:200)
                
                
            }
                .frame(width:UIScreen.main.bounds.width * 0.45, alignment: .leading)
            
            Divider()
            Spacer().frame(width: UIScreen.main.bounds.width * 0.045)
            
            
            VStack(alignment: .leading, spacing: 4) {
                
                displayText("\(courseInformation.courseStartTime)", .body, .monospaced)
                    .bold()
                    .lineLimit(1)
                
                Divider()
                
                displayText("\(courseInformation.courseRoomNumber)", .body, .monospaced)
                    .lineLimit(2)
                    .frame(height: 32.33)
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.30, alignment: .leading)
            
        }
        .contextMenu {
                Text("Course Number: \(self.courseInformation.courseNumber)")
                Text("Course Name: \(self.courseInformation.courseTitle)")
                Text("Location: \(self.courseInformation.courseRoomNumber)")
                Text("Time: \(self.courseInformation.courseStartTime)")
        }
    }
}

let someCourse = CourseInfo("Some Very Unecessary Long Needs to be Truncated Course Name", "CS 123", "GMCS 456", "09:59 PM")

struct CourseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CourseInfoView(courseInformation: someCourse)
            .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
            .previewDisplayName("iPhone XS")
    }
}
