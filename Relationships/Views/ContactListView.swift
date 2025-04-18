//
//  ContactListView.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

struct ContactListView: View {
    
    let contacts: [Contact]
    let onDelete: (Contact) -> Void
    let onSave: (Contact) -> Void
    
    var body: some View {
        List {
            ForEach(contacts) { contact in
                NavigationLink(destination: ContactDetailView(contact: contact, onDelete: onDelete, onSave: onSave)) {
                    ContactRow(contact: contact)
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let contactToDelete = contacts[index]
                    onDelete(contactToDelete)
                }
            }
        }
    }
}

struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        HStack(spacing: 15) {
            if let image = contact.avatarImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .top)
                    .clipShape(Circle())
            } else {
                Image(systemName: contact.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(contact.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(contact.phoneNumber)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContactListView(
        contacts: [
            Contact(
                id: UUID(),
                name: "Jane Doe",
                phoneNumber: "123-456-7890",
                email: "jane@example.com",
                avatar: "sample_photo"
            )
        ],
        onDelete: { _ in },
        onSave: { _ in }
    )
}
