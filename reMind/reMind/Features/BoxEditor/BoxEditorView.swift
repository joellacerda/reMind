//
//  BoxEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 29/06/23.
//


import SwiftUI

struct BoxEditorView: View {
    var box: Box?
    @StateObject var editorViewModel = BoxEditorViewModel()

    @EnvironmentObject var viewModel: BoxViewModel
    @Environment(\.dismiss)  var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Name", text: $editorViewModel.name)
                reTextField(title: "Keywords",
                            caption: "Separated by , (comma)",
                            text: $editorViewModel.keywords)
                
                reTextEditor(title: "Description",
                             text: $editorViewModel.boxDescription)

                reRadioButtonGroup(title: "Theme",
                                   currentSelection: $editorViewModel.theme)
                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle(editorViewModel.isEditingExistingBox ? "Edit Box" : "New Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(editorViewModel.isEditingExistingBox ? "Update" : "Save") {
                        if editorViewModel.isEditingExistingBox {
                           // Update existing box
                           editorViewModel.originalBox?.name = editorViewModel.name
                           editorViewModel.originalBox?.keywords = editorViewModel.keywords
                           editorViewModel.originalBox?.boxDescription = editorViewModel.boxDescription
                           editorViewModel.originalBox?.rawTheme = Int16(editorViewModel.theme)
                           CoreDataStack.shared.saveContext()
                       } else {
                           // Create new box
                           let newBox = Box(context: CoreDataStack.shared.managedContext)
                           newBox.name = editorViewModel.name
                           newBox.keywords = editorViewModel.keywords
                           newBox.boxDescription = editorViewModel.boxDescription
                           newBox.rawTheme = Int16(editorViewModel.theme)
                           viewModel.boxes.append(newBox)
                           CoreDataStack.shared.saveContext()
                       }
                       dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

struct BoxEditorView_Previews: PreviewProvider {
    static var newBox = Box(context: CoreDataStack.shared.managedContext)
    
    static var previews: some View {
        BoxEditorView(
            editorViewModel: BoxEditorViewModel(box: newBox)
        )
    }
}
