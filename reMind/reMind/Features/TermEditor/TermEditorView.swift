//
//  TermEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct TermEditorView: View {
    let box: Box
    @State var term: String
    @State var meaning: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Term", text: $term)
                reTextEditor(title: "Meaning", text: $meaning)
                
                Spacer()
              
                Button(action: {
//                    saveTerm()
                    dismiss()
                }, label: {
                    Text("Add Term")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(reButtonStyle())
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Term")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        print("Cancel")
//                    }
//                    .fontWeight(.bold)
//                }
            }
        }
    }
    
//    func saveTerm() {
//        let newTerm: Term = Term(context: CoreDataStack.shared.managedContext)
//        newTerm.value = term
//        newTerm.meaning = meaning
//        box.addToTerms(newTerm)
//        CoreDataStack.shared.saveContext()
//    }
}

struct TermEditorView_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreDataStack.inMemory.managedContext
        let box = Box(context: context)
        box.name = "Box 1"
        return TermEditorView(box: box, term: "", meaning: "")
    }
}
