//
//  DataLoader.swift
//  DiscViewerApp
//
//  Created by Mikołaj Myśliński on 06/11/2024.
//

import Foundation

func loadMockData() -> FileData? {
    guard let url = Bundle.main.url(forResource: "mock", withExtension: "geojson") else {
        print("Plik nie został znaleziony")
        return nil
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let fileData = try decoder.decode(FileData.self, from: data)
        return fileData
    } catch {
        print("Błąd wczytywania pliku JSON: \(error)")
        return nil
    }
}
