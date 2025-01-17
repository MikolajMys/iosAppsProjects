//
//  GridView.swift
//  DiscViewerApp
//
//  Created by Mikołaj Myśliński on 15/11/2024.
//

import SwiftUI

struct GridView: View {
    let files: [File]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(files) { file in
                    HStack {
                        Image(systemName: "folder")
                        VStack(alignment: .leading) {
                            Text(file.name)
                                .font(.headline)
                            Text("Typ: \(file.type)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            if let description = file.description, !description.isEmpty {
                                Text(description)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                    }
                    .frame(width: 150, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}
