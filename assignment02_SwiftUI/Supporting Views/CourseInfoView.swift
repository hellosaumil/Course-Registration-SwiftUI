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
    
    var body: some View {

        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                
                Text("\(courseInformation.courseNumber)")
                    .font(.system(.headline, design: .serif))
                    .bold()
                
                Text("\(courseInformation.courseRoomNumber)")
                    .font(.system(.subheadline, design: .monospaced))
            }
            Spacer()
            
            Text("\(courseInformation.courseStartTime)")
                .font(.system(.callout, design: .rounded))
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
}

let someCourse = CourseInfo("CS 123", "GMCS 456", "09:59 PM")

struct CourseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CourseInfoView(courseInformation: someCourse)
    }
}
