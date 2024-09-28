//
//  PickerBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 28/09/2024.
//

import SwiftUI

struct PickerBootcamp: View {
    
    @State var selection: String = "Most Recent"
    let filterOptions: [String] = [
        "Most Recent", "Most Popular", "Most Liked"
    ]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.red
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        // I
//        VStack {
//            HStack {
//                Text("Age:")
//                Text(selection)
//            }
//
//            Picker(
//                selection: $selection) {
//                    ForEach(18..<100) { number in
//                        Text("\(number)")
//                            .font(.headline)
//                            .foregroundColor(.red)
//                            .tag("\(number)")
//                    }
//                } label: {
//                    Text("Picker")
//                }
//                //.background(Color.gray.opacity(0.3))
//                .pickerStyle(WheelPickerStyle())
//        }
        // II
//        Menu {
//            Picker("", selection: $selection) {
//                ForEach(filterOptions, id: \.self) { option in
//                    HStack {
//                        Text(option)
//                        Image(systemName: "heart.fill")
//                    }
//                    .tag(option)
//                }
//            }
//        } label: {
//            HStack {
//                //Text("Filter: \(selection)")
//                Text("Filter:")
//                Text(selection)
//            }
//            .font(.headline)
//            .foregroundColor(.white)
//            .padding()
//            .padding(.horizontal)
//            .background(Color.blue)
//            .cornerRadius(10)
//            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
//        }
        // III
        Picker(selection: $selection) {
            // WRONG
//            ForEach(filterOptions.indices) { index in
//                Text(filterOptions[index])
//                    .tag(filterOptions[index])
//            }
            ForEach(filterOptions, id: \.self) { option in
                Text(option)
                    .tag(option)
            }
        } label: {
            Text("Picker")
        }
        .pickerStyle(SegmentedPickerStyle())
        //.background(Color.red)
    }
}

struct PickerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PickerBootcamp()
    }
}
