//
//  ContactsViewModel.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

@MainActor
class ContactsViewModel: ObservableObject {
    @Published private(set) var contacts: [Contact] = []
    @Published var searchText = ""
    
    private let userDefaults = UserDefaults.standard
    private let contactsKey = "savedContacts"
    
    init() {
        loadContacts()
    }
    
    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        }
        return contacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
        saveContacts()
    }
    
    func updateContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id}) {
            contacts[index] = contact
            saveContacts()
        }
    }
    
    func deleteContact(_ contact: Contact) {
        contacts.removeAll { $0.id == contact.id }
        saveContacts()
    }
    
    private func saveContacts() {
        do {
            let encodedData = try JSONEncoder().encode(contacts)
            userDefaults.set(encodedData, forKey: contactsKey)
        } catch {
            print("Error saving contacts: \(error)")
        }
    }
    
    private func loadContacts() {
        guard let data = userDefaults.data(forKey: contactsKey) else {return}
        
        do  {
            contacts = try JSONDecoder().decode([Contact].self, from: data)
        } catch {
            print("Error loading contacts: \(error)")
        }
    }
}
