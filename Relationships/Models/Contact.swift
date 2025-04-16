//
//  Contact.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

struct Contact: Identifiable, Codable {
    let id: UUID
    let name: String
    let phoneNumber: String
    let email: String
    let avatar: String
    let notes: String
    
    init(id: UUID = UUID(), name: String, phoneNumber: String, email: String, avatar: String = "person.circle.fill", notes: String = "") {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.avatar = avatar
        self.notes = notes
    }
}
