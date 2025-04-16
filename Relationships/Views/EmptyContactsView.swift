//
//  EmptyContactsView.swift
//  Relationships
//
//  Created by David Wilder on 4/16/25.
//

import SwiftUI

struct EmptyContactsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue.opacity(0.8))
            Text("No Contacts")
                .font(.title2)
                .foregroundColor(.gray)
            Text("Tap + to add a new contact")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    EmptyContactsView()
}
