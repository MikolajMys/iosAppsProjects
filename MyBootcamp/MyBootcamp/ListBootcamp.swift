//
//  ListBootcamp.swift
//  MyBootcamp
//
//  Created by Mikołaj Myśliński on 21/09/2024.
//

import SwiftUI

struct ListBootcamp: View {
    
    @State var fruits: [String] = [
        "apple",
        "orange",
        "bannana",
        "peach"
    ]
    @State var veggies: [String] = [
        "tomato",
        "potato",
        "carrot",
        "cabbage"
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit.capitalized)
                            .font(.callout)
                            .foregroundColor(.white)
                            .padding(.vertical)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .background(Color.pink)
//                            .cornerRadius(20)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    // longer version:
//                    .onMove { IndexSet, Int in
//                        move(indexSet: IndexSet, int: Int)
//                    }
                    .listRowBackground(Color.blue)
                } header: {
                    HStack {
                        Text("Fruits")
                        Image(systemName: "flame.fill")
                    }
                    .font(.headline)
                    .foregroundColor(.orange)
                }
                Section {
                    ForEach(veggies, id: \.self) { veggie in
                        Text(veggie.capitalized)
                    }
                } header: {
                    Text("Veggies")
                }

            }
            .tint(.purple)
            .listStyle(SidebarListStyle())
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
        }
        .tint(.red)
    }
    
    var addButton: some View {
        Button("Add") {
            add()
        }
    }
    
    func delete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    func move(indexSet: IndexSet, int: Int) {
        fruits.move(fromOffsets: indexSet, toOffset: int)
    }
    func add() {
        fruits.append("Coconut")
    }
}

struct ListBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ListBootcamp()
    }
}
