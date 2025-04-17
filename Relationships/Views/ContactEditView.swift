//
//  ContactEditView.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

enum ContactEditMode {
    case new
    case edit(Contact)
}

struct ContactEditView: View {
    
    @Environment(\.dismiss) private var dismiss
    let mode: ContactEditMode
    let onSave: (Contact) -> Void
    
    @StateObject private var viewModel: ContactEditViewModel
    
    init(mode: ContactEditMode, onSave: @escaping (Contact) -> Void) {
        self.mode = mode
        self.onSave = onSave
        
        let contact: Contact?
        if case let .edit(existingContact) = mode {
            contact = existingContact
        } else {
            contact = nil
        }
    
        _viewModel = StateObject(wrappedValue: ContactEditViewModel(contact: contact))
        
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("About") {
                    ZStack(alignment: .topLeading) {
                        if viewModel.about.isEmpty {
                            Text("Add some info about this person")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.top, 8)
                                .padding(.horizontal, 5)
                        }
                        TextEditor(text: $viewModel.about)
                            .frame(minHeight: 100)
                            .foregroundColor(.primary)
                    }
                }
                
                Section("Contact Info") {
                    TextField("Name", text: $viewModel.name)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        TextField("Phone Number", text: $viewModel.phoneNumber)
                            .keyboardType(.phonePad)
                           .onChange(of: viewModel.phoneNumber) {
                                viewModel.validatePhoneNumber()
                            }
                        
                        if viewModel.showingPhoneError {
                            Text("Invalid phone number format")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Notes") {
                    ZStack(alignment: .topLeading) {
                        if viewModel.notes.isEmpty {
                            Text("Add some notes about this person")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.top, 8)
                                .padding(.horizontal, 5)
                        }
                        TextEditor(text: $viewModel.notes)
                            .frame(minHeight: 100)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle(mode.isNew ? "New Contact" : "Edit Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss()}
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let existingId: UUID?
                        if case let .edit(contact) = mode {
                            existingId = contact.id
                        } else {
                            existingId = nil
                        }
                        
                        let contact = viewModel.createContact(existingId: existingId)
                        onSave(contact)
                        dismiss()
                    }
                    .disabled(!viewModel.isFormValid)
                }
            }
        }
    }
}

private extension ContactEditMode {
    var isNew: Bool {
        if case .new = self { return true }
        return false
    }
}

#Preview {
    ContactEditView(
        mode: .edit(Contact(
            id: UUID(),
            name: "Jane Wilder",
            phoneNumber: "123-456-7890",
            email: "jane@example.com",
            notes: "Notes will go here and can wrap if you have multiple lines of text you want to add."
        )),
        onSave: { _ in }
    )
}
