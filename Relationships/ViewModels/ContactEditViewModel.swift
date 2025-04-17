//
//  ContactEditViewModel.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

@MainActor
class ContactEditViewModel: ObservableObject {
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var email = ""
    @Published var notes: String = ""
    @Published var about: String = ""
    @Published var showingPhoneError = false
    
    init(contact: Contact? = nil) {
        if let contact = contact {
            self.name = contact.name
            self.phoneNumber = contact.phoneNumber
            self.email = contact.email
            self.notes = contact.notes
            self.about = contact.about
        }
    }
    
    var isFormValid: Bool {
        !name.isEmpty && !phoneNumber.isEmpty && isValidPhone
    }
    
    private var isValidPhone: Bool {
        let phoneRegex = #"^\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}$"#
        return phoneNumber.range(of: phoneRegex, options: .regularExpression) != nil
    }
    
    func validatePhoneNumber() {
        showingPhoneError = !phoneNumber.isEmpty && !isValidPhone
    }
    
    func createContact(existingId: UUID? = nil) -> Contact {
        Contact(
            id: existingId ?? UUID(),
            name: name,
            phoneNumber: formatPhoneNumber(phoneNumber),
            email: email,
            notes: notes,
            about: about
        )
    }
    
    private func formatPhoneNumber(_ number: String) -> String {
        let cleaned = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if cleaned.count >= 10 {
            let area = cleaned.prefix(3)
            let prefix = cleaned.dropFirst(3).prefix(3)
            let number = cleaned.dropFirst(6).prefix(4)
            return "(\(area)) \(prefix)-\(number)"
        }
        return number
    }
}
