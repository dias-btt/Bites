//
//  CategoriesCell.swift
//  Bites
//
//  Created by Диас Сайынов on 08.04.2024.
//
import SwiftUI

struct CategoryCell: View {
    let categoryText: String
    let isSelected: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(isSelected ? Color("NavBack") : .gray)
            .frame(width: 112, height: 38)
            .overlay(
                Text(categoryText)
                    .foregroundColor(isSelected ? Color("Primary") : .white)
                    .font(.custom(isSelected ? "SF Pro Display Medium" : "SF Pro Display Regular", size: 20))
            )
    }
}

