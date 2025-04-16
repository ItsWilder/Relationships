//
//  ContactDetailView.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

struct ContactDetailView: View {
    
    let contact: Contact
    let onDelete: (Contact) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var showingEditSheet = false
    @StateObject private var viewModel = ContactsViewModel()
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer ()
                    Image(systemName: contact.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding(20)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                    Spacer ()
                }
                .listRowBackground(Color.clear)
            }
            
            Section("Contact Info") {
                LabeledContent("Name", value: contact.name)
                LabeledContent("Phone", value: contact.phoneNumber)
                LabeledContent("Email", value: contact.email)
            }
            
            Section {
                Button(action: {
                    if let url = URL(string: "tel:\(contact.phoneNumber)") {
                        UIApplication.shared.open(url)
                    }
                }){
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Call")
                    }
                    .foregroundColor(.green)
                }
                
                Button(action: {
                    if let url = URL(string: "mailto:\(contact.email)") {
                        UIApplication.shared.open(url)
                    }
                }){
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Send Email")
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Menu {
                    Button(action: { showingEditSheet = true }) {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button(role: .destructive, action: {
                        onDelete(contact)
                        dismiss()
                    }) {
                        Label("Trash", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            ContactEditView(
                mode: .edit(contact),
                onSave: viewModel.updateContact
            )
        }
    }
}

#Preview {
    ContactDetailView(
        contact: Contact(
            id: UUID(),
            name: "Jane Doe",
            phoneNumber: "123-456-7890",
            email: "jane@example.com",
            avatar: "person.crop.circle"
        ),
        onDelete: { _ in }
    )
}
