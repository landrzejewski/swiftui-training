//
//  validators.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 01/06/2023.
//

import Foundation
import Combine

func emailIsValid(_ email: Published<String>.Publisher) -> AnyPublisher<String, Never> {
    email
        .map { $0.contains("@") && $0.contains(".") }
        .map { $0 ? "" : "Invalid email" }
        .eraseToAnyPublisher()
}

func passwordIsValid(_ password: Published<String>.Publisher) -> AnyPublisher<String, Never> {
    password
        .map { $0.count > 6 }
        .map { $0 ? "" : "Password is too short" }
        .eraseToAnyPublisher()
}
