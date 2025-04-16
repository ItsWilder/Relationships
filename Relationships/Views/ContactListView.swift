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
    
    var body: some View {
        List(contacts) { contact in
            NavigationLink(destination: ContactDetailView(contact: contact, onDelete: onDelete)) {
                ContactRow(contact: contact)
            }
        }
    }
}

struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        HStack (spacing: 15){
            Image(systemName: contact.avatar)
                .resizable ()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
                
            VStack (alignment: .leading, spacing: 4){
                Text(contact.name)
                    .font(.system(size: 16, weight: .medium))
            Text(contact.phoneNumber)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
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
                avatar: "person.crop.circle"
            )
        ],
        onDelete: { _ in }
    )
}
