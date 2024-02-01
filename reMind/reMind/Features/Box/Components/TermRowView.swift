//
//  TermRowView.swift
//  reMind
//
//  Created by Joel Lacerda on 01/02/24.
//

import SwiftUI

struct TermRowView: View {
    var term: Term
    
    var body: some View {
        Text(term.value ?? "Unknown")
            .padding(.vertical, 8)
            .fontWeight(.bold)
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    deleteTerm(term)
                } label: {
                    Image(systemName: "trash")
                }
            }
    }

    private func deleteTerm(_ term: Term) {
        guard let managedContext = term.managedObjectContext else {
            // Handle the case where the term doesn't belong to any context
            return
        }

        managedContext.delete(term)

        do {
            try managedContext.save()
        } catch {
            print("Error deleting term: \(error)")
        }
    }
}
