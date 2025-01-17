//
//  ConnectionStatusView.swift
//  WeatherApp
//
//  Created by Mikołaj Myśliński on 04/01/2025.
//

import SwiftUI

struct ConnectionStatusView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: networkMonitor.isConnected ? "wifi" : "wifi.slash")
                .frame(maxWidth: .infinity)
                .padding()
                .background(networkMonitor.isConnected ? Color.green : Color.red)
                .foregroundColor(Color("DetailColor"))
                .font(.title)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ConnectionStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionStatusView()
            .environmentObject(NetworkMonitor())
    }
}
