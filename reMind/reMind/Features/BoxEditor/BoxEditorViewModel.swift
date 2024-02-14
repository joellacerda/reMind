//
//  BoxEditorViewModel.swift
//  reMind
//
//  Created by Joel Lacerda on 14/02/24.
//

import Foundation

class BoxEditorViewModel: ObservableObject {
    // State variables for editable fields
    @Published var name: String = ""
    @Published var boxDescription: String = ""
    @Published var keywords: String = ""
    @Published var theme: Int = 0

    // Flag to differentiate between creating and editing
    @Published var isEditingExistingBox: Bool = false

    // Reference to the original box for editing (optional)
    var originalBox: Box?

    // Initialize with optional existing box
    init(box: Box? = nil) {
        name = box?.name ?? ""
        boxDescription = box?.boxDescription ?? ""
        keywords = box?.keywords ?? ""
        theme = Int(box?.rawTheme ?? 0)
        isEditingExistingBox = box != nil
        originalBox = box ?? nil
    }
}

