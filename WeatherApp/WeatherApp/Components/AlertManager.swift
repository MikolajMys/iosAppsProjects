//
//  AlertManager.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 03/01/2025.
//

import Foundation

class AlertManager: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var title: String = ""
    @Published var message: String = ""
    
    func showAlert(title: String, message: String) {
        self.title = title
        self.message = message
        self.isPresented = true
    }
}
