//
//  DatePickerBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 02/10/2024.
//

import SwiftUI

struct DatePickerBootcamp: View {
    
    @State var selectDate: Date = Date()
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2018)) ?? Date() // we colud use !
    let endingDate: Date = Date()
    
    // formatter for our date
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack {
            Text("SELECTED DATE IS:")
            Text(dateFormatter.string(from: selectDate))
                .font(.title)
            //DatePicker("Select a date", selection: $selectDate)
            //DatePicker("Select a date", selection: $selectDate, displayedComponents: [.date, .hourAndMinute])
            DatePicker("Select a date", selection: $selectDate, in: startingDate...endingDate, displayedComponents: [.date])
                .tint(.red)
                .datePickerStyle(.compact)
        }
    }
}

struct DatePickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBootcamp()
    }
}
