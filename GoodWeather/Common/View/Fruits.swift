//
//  Fruits.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 17/11/2023.
//

import SwiftUI

struct Fruits: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Fruits()
}


class Data {
    static func getFruits() -> [Item] {
        return [
            Item(name: "Avocado", imageName: "Avocado"),
            Item(name: "Banana", imageName: "Banana"),
            Item(name: "Blackberries", imageName: "Blackberries"),
            Item(name: "Cherry", imageName: "Cherry"),
            Item(name: "Coconut", imageName: "Coconut"),
            Item(name: "Kiwi", imageName: "Kiwi"),
            Item(name: "Lemon", imageName: "Lemon"),
            Item(name: "Lime", imageName: "Lime"),
            Item(name: "Mango", imageName: "Mango"),
            Item(name: "Mangosteen", imageName: "Mangosteen"),
            Item(name: "Orange", imageName: "Orange"),
            Item(name: "Peach", imageName: "Peach"),
            Item(name: "Pineapple", imageName: "Pineapple"),
            Item(name: "Prune", imageName: "Prune"),
            Item(name: "Raspberry", imageName: "Raspberry")
        ]
    }
}

struct Item: Identifiable {
    let id = UUID()
    var name = ""
    var imageName = ""
    var isFavorite = false
    var details = ""
    var location = ""
}
