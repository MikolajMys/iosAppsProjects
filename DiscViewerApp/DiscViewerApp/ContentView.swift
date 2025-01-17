//
//  ContentView.swift
//  DiscViewerApp
//
//  Created by Mikołaj Myśliński on 06/11/2024.
//

import SwiftUI

enum ViewType {
    case list
    case grid
}

struct ContentView: View {
    @State private var fileData: FileData?
    @State private var viewType: ViewType = .list

    var body: some View {
        NavigationView {
            VStack {
                Picker("Wybierz widok", selection: $viewType) {
                    Text("Lista").tag(ViewType.list)
                    Text("Gród").tag(ViewType.grid)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if viewType == .list {
                    ListView(files: fileData?.results ?? [])
                } else {
                    GridView(files: fileData?.results ?? [])
                }
            }
            .navigationTitle("Lista plików")
            .onAppear {
                self.fileData = loadMockData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
