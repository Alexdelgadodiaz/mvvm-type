//
//  ItemListView.swift
//  sport-shooting
//
//  Created by AlexDelgado on 27/2/25.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var container: AppDependencyContainer
    
    @StateObject private var viewModel = ItemListViewModel()
    @State private var isSheetPresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView("Loading items...")
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3))
                        .ignoresSafeArea()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.items) { item in
                                NavigationLink {
                                    ItemDetailView(item: item)
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(item.title)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text(item.itemDescription)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Items")
            .accessibilityIdentifier("ItemsScrollView")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetView(isShowingSheet: $isSheetPresented) {
                    viewModel.logout()
                }
                .presentationDetents([.fraction(0.3)])
                .presentationDragIndicator(.visible)
            }
            .onAppear {
                viewModel.configure(itemService: container.itemService(token: userSession.currentUser?.token), userSession: userSession)
                Task {
                    await viewModel.fetchItems()
                }
            }
        }
    }
}

struct SheetView: View {
    @Binding var isShowingSheet: Bool // Controla la visibilidad del sheet
    let logoutAction: () -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Button("Logout") {
                    logoutAction()
                    isShowingSheet = false
                }
                .foregroundColor(.red)
                .padding()
                .frame(maxWidth: .infinity)
                // Color de fondo adaptable a dark/light mode
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                
                Button("Cancel") {
                    isShowingSheet = false
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            }
            .padding()
        }
    }
}
