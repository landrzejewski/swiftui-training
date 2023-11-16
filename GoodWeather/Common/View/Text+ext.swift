//
//  Text+ext.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 30/05/2023.
//

import SwiftUI

extension Text {
    
    func defaultStyle(size: CGFloat = 18, color: Color = .white) -> some View {
        font(.system(size: size, weight: .medium))
            .foregroundColor(color)
            .iOS { $0.padding(2) }
    }
    
}
