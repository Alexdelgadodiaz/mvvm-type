//
//  ItemDetailView.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//


import SwiftUI

struct ItemDetailView: View {
    var item: Item

    var body: some View {
        ZStack {
            // Fondo que se adapta a dark/light mode
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(item.title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 8)
                    
                    Text(item.itemDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding()
                // Se utiliza un fondo dinámico para el contenedor
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                .padding()
            }
        }
        .navigationTitle("Item Details")
        .accessibilityIdentifier("ItemDetailView")

    }

}
