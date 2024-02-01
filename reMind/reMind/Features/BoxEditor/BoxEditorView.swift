//
//  BoxEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 29/06/23.
//


import SwiftUI

struct BoxEditorView: View {
    var box: Box?
    @StateObject var viewModel = BoxEditorViewModel()

    @EnvironmentObject var boxViewModel: BoxViewModel
    @Environment(\.dismiss)  var dismiss
    
    init(box: Box? = nil) {
        _viewModel = StateObject(wrappedValue: BoxEditorViewModel(box: box))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Name", text: $viewModel.name)
                reTextField(title: "Keywords",
                            caption: "Separated by , (comma)",
                            text: $viewModel.keywords)
                
                reTextEditor(title: "Description",
                             text: $viewModel.boxDescription)

                reRadioButtonGroup(title: "Theme",
                                   currentSelection: $viewModel.theme)
                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle(viewModel.isEditingExistingBox ? "Edit Box" : "New Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.isEditingExistingBox ? "Update" : "Save") {
                        if viewModel.isEditingExistingBox {
                           // Update existing box
                           viewModel.originalBox?.name = viewModel.name
                           viewModel.originalBox?.keywords = viewModel.keywords
                           viewModel.originalBox?.boxDescription = viewModel.boxDescription
                           viewModel.originalBox?.rawTheme = Int16(viewModel.theme)
                       } else {
                           // Create new box
                           let newBox = Box(context: CoreDataStack.shared.managedContext)
                           newBox.name = viewModel.name
                           newBox.keywords = viewModel.keywords
                           newBox.boxDescription = viewModel.boxDescription
                           newBox.rawTheme = Int16(viewModel.theme)
                           boxViewModel.boxes.append(newBox)
                       }
                        do {
                            try CoreDataStack.shared.saveContext()
                            dismiss()
                        } catch {
                            print("Error saving context: \(error)")
                        }
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
        BoxEditorView(box: newBox)
            .environmentObject(BoxViewModel())
    }
}
