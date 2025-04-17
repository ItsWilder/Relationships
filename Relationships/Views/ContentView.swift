//
//  ContentView.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContactsViewModel()
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.contacts.isEmpty {
                    EmptyContactsView()
                } else {
                    ContactListView(contacts: viewModel.contacts,
                                    onDelete: viewModel.deleteContact,
                                    onSave: viewModel.updateContact)
                }
            }
            .navigationTitle(Text("Contacts"))
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet){
                ContactEditView (
                    mode: .new,
                    onSave: viewModel.addContact
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
