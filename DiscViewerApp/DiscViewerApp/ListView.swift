//
//  ListView.swift
//  DiscViewerApp
//
//  Created by Mikołaj Myśliński on 15/11/2024.
//

import SwiftUI

struct ListView: View {
    let files: [File]
    
    var body: some View {
        List(files) { file in
            LazyHStack {
                Image(systemName: "folder")
                //Spacer ()
                VStack() {
                    Text(file.name)
                        .font(.headline)
                    Text("Typ: \(file.type)")
                        .font(.subheadline)
                    if let description = file.description, !description.isEmpty {
                        Text(description)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
            }
            .padding(.vertical, 20)
        }
    }
}
