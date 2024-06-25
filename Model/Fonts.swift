//
//  Fonts.swift
//  Bites
//
//  Created by Диас Сайынов on 19.05.2024.
//

import Foundation

enum AppFont {
    case regular
    case bold
    case medium
    // Add more font styles as needed
    
    var fontName: String {
        switch self {
        case .regular:
            return "SF Pro Display Regular"
        case .bold:
            return "SF Pro Display Bold"
        case .medium:
            return "SF Pro Display Medium"
        }
    }
}
