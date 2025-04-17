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
    let onSave: (Contact) -> Void
    
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
            
            HStack(spacing: 12) {
                Button(action: {
                    if let url = URL(string: "tel:\(contact.phoneNumber)") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    VStack (spacing:8){
                        Image(systemName: "phone.fill")
                        Text("Call")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: {
                    if let url = URL(string: "mailto:\(contact.email)") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    VStack (spacing:8){
                        Image(systemName: "envelope.fill")
                        Text("Email")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: {
                    if let url = URL(string: "sms:\(contact.phoneNumber)") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    VStack (spacing:8){
                        Image(systemName: "message.fill")
                        Text("Text")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: {
                    if let url = URL(string: "facetime:\(contact.phoneNumber)") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: "video.fill")
                        Text("Video")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .listRowBackground(Color.clear)
            
            Section("About") {
                if contact.about.isEmpty {
                    Text("Tell me about \(contact.name.split(separator: " ").first ?? "")")
                        .foregroundColor(Color(UIColor.placeholderText))
                } else {
                    Text(contact.about)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Section("Contact Info") {
                LabeledContent {
                    Text(contact.name)
                        .foregroundColor(.primary)
                } label: {
                    Text("Name")
                        .foregroundColor(.secondary)
                }
                
                LabeledContent {
                    Text(contact.phoneNumber)
                        .foregroundColor(.primary)
                } label: {
                    Text("Phone")
                        .foregroundColor(.secondary)
                }
                
                LabeledContent {
                    Text(contact.email)
                        .foregroundColor(.primary)
                } label: {
                    Text("Email")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Notes") {
                if contact.notes.isEmpty {
                    Text("Add some notes about \(contact.name.split(separator: " ").first ?? "")")
                        .foregroundColor(Color(UIColor.placeholderText))
                } else {
                    Text(contact.notes)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
                onSave: onSave
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
            avatar: "person.crop.circle",
            notes: "",
            about: ""
        ),
        onDelete: { _ in },
        onSave: { _ in }
    )
}
