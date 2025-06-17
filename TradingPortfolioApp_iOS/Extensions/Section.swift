//
//  Section.swift
//  Rathish Kannan
//

import UIKit

internal struct Section<Type, Row> {

    /// Section title, if nil, section header won't be visible.
    var attributedTitle: NSAttributedString?

    /// Section action button, if nil, button won't be visible
    let actionButtonTitle: String?
    
    /// Type of section to distinguish them when needed
    var type: Type?
    
    /// Rows to be visible in a particular section.
    var rows: [Row]

    /// Convenience method to tell whether title is nil and section header should be visible.
    var isSectionHeaderVisible: Bool {
        return attributedTitle != nil && !rows.isEmpty
    }

    /// Creates a new instance of Section. It's a wrapper class to handle rows in static table views.
    ///
    /// - Parameters:
    ///   - type: custom section type
    ///   - attributedTitle: a title that should be present in section header.
    ///   - actionButtonTitle: a button title that should be present in section header.
    ///   - rows: all rows to be contained in the section.
    init(type: Type? = nil, attributedTitle: NSAttributedString? = nil, actionButtonTitle: String? = nil, rows: [Row]) {
        self.type = type
        self.attributedTitle = attributedTitle
        self.actionButtonTitle = actionButtonTitle
        self.rows = rows
    }
    
    /// Adding rows to an existing rows array
    mutating func append(rows: [Row]) {
        self.rows.append(contentsOf: rows)
    }
}
