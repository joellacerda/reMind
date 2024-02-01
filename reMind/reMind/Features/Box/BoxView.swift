//
//  BoxView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct BoxView: View {
    var box: Box
    @State private var boxName: String = ""
    @State private var boxDescription: String = ""
    
    @State private var searchText: String = ""
    @State private var isCreatingNewTerm = false

    private var filteredTerms: [Term] {
        let termsSet = box.terms as? Set<Term> ?? []
        let terms = Array(termsSet).sorted { lhs, rhs in
            (lhs.value ?? "") < (rhs.value ?? "")
        }
        
        if searchText.isEmpty {
            return terms
        } else {
            return terms.filter { ($0.value ?? "").contains(searchText) }
        }
    }
    
    var body: some View {
        List {
            Text(boxDescription)
            TodaysCardsView(numberOfPendingCards: 0,
                            theme: box.theme)
            Section {
                ForEach(filteredTerms, id: \.self) { term in
                    TermRowView(term: term)
                }
            } header: {
                Text("All Cards")
                    .textCase(.none)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Palette.label.render)
                    .padding(.leading, -16)
                    .padding(.bottom, 16)
            }
            
        }
        .onChange(of: box.name) { newName in
            // Update the navigation title and save the new name
            boxName = newName ?? "Unnamed Box"
            boxDescription = box.boxDescription ?? ""
        }
        .onAppear {
            // Set initial values for the title and description
            boxName = box.name ?? "Unnamed Box"
            boxDescription = box.boxDescription ?? ""
        }
        .scrollContentBackground(.hidden)
        .background(reBackground())
        .navigationTitle(boxName)
        .searchable(text: $searchText, prompt: "")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink(destination: BoxEditorView(box: box)) {
                    Image(systemName: "square.and.pencil")
                }
                
                Button {
                    isCreatingNewTerm.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .sheet(isPresented: $isCreatingNewTerm) {
//            TermEditorView(box: box)
        }
    }
}

struct BoxView_Previews: PreviewProvider {
    static let box: Box = {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.name = "Box 1"
        box.rawTheme = 0
        BoxView_Previews.terms.forEach { term in
            box.addToTerms(term)
        }
        return box
    }()

    static let terms: [Term] = {
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Term 1"

        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Term 2"

        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
        term3.value = "Term 3"

        return [term1, term2, term3]
    }()
    

    static var previews: some View {
        NavigationStack {
            BoxView(box: BoxView_Previews.box)
        }
    }
}
