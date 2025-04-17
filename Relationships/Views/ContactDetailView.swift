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
        
        ScrollView {
            ZStack(alignment: .bottom) {
                if UIImage(named: contact.avatar) != nil {
                    Image(contact.avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400, alignment: .top)
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 400)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .ignoresSafeArea(edges: .top)
                }
                
                VStack(spacing: 18) {
                    if UIImage(named: contact.avatar) == nil {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 110, height: 110)
                            
                            Image(systemName: contact.avatar)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Text(contact.name.split(separator: " ").first.map(String.init) ?? contact.name)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(UIImage(named: contact.avatar) != nil ? .white : .primary)
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            if let url = URL(string: "sms:\(contact.phoneNumber)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            VStack(spacing: 10) {
                                Image(systemName: "message.fill")
                                Text("Text")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((UIImage(named: contact.avatar) != nil ? Color.white : Color.blue).opacity(0.15))
                            .foregroundColor(UIImage(named: contact.avatar) != nil ? .white : .blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        Button(action: {
                            if let url = URL(string: "tel:\(contact.phoneNumber)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            VStack(spacing: 10) {
                                Image(systemName: "phone.fill")
                                Text("Call")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((UIImage(named: contact.avatar) != nil ? Color.white : Color.blue).opacity(0.15))
                            .foregroundColor(UIImage(named: contact.avatar) != nil ? .white : .blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        Button(action: {
                            if let url = URL(string: "facetime:\(contact.phoneNumber)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            VStack(spacing: 10) {
                                Image(systemName: "video.fill")
                                Text("Video")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((UIImage(named: contact.avatar) != nil ? Color.white : Color.blue).opacity(0.15))
                            .foregroundColor(UIImage(named: contact.avatar) != nil ? .white : .blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        Button(action: {
                            if let url = URL(string: "mailto:\(contact.email)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            VStack(spacing: 10) {
                                Image(systemName: "envelope.fill")
                                Text("Email")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((UIImage(named: contact.avatar) != nil ? Color.white : Color.blue).opacity(0.15))
                            .foregroundColor(UIImage(named: contact.avatar) != nil ? .white : .blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("ABOUT")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                    if contact.about.isEmpty {
                        Text("Tell me about \(contact.name.split(separator: " ").first ?? "")")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .font(.body)
                    } else {
                        Text(contact.about)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 14) {
                    Text("CONTACT INFO")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Name")
                            .font(.subheadline)
                        Text(contact.name)
                            .foregroundColor(.blue)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Phone")
                            .font(.subheadline)
                        Text(contact.phoneNumber)
                            .foregroundColor(.blue)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.subheadline)
                        Text(contact.email)
                            .foregroundColor(.blue)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("NOTES")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                    if contact.notes.isEmpty {
                        Text("Add some notes about \(contact.name.split(separator: " ").first ?? "")")
                            .foregroundColor(Color(UIColor.placeholderText))
                    } else {
                        Text(contact.notes)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .ignoresSafeArea(edges: .top)
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
            name: "Hogan Wilder",
            phoneNumber: "123-456-7890",
            email: "hogiebear@example.com",
            avatar: "sample_photo",
            notes: "",
            about: ""
        ),
        onDelete: { _ in },
        onSave: { _ in }
    )
}
