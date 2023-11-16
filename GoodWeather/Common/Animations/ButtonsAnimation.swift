//
//  ButtonsAnimation.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 19/05/2022.
//

import SwiftUI

struct ButtonsAnimation: View {
    
    @State
    var show = false
    
    var body: some View {
        Spacer()
        ZStack {
            Group {
                Button(action: { show.toggle() }) {
                    Image(systemName: "bag.badge.plus")
                        .padding(24)
                        .rotationEffect(Angle.degrees(show ? 0 : -90))
                        .background(
                            Circle()
                                .fill(Color.mainColor)
                                .shadow(radius: 8, x: 4, y: 4)
                        )
                        .opacity(show ? 1 : 0)
                        .offset(x: 0, y: show ? -130 : 0)
                }
                Button(action: { show.toggle() }) {
                    Image(systemName: "cart")
                        .padding(24)
                        .rotationEffect(Angle.degrees(show ? 0 : 90))
                        .background(
                            Circle()
                                .fill(Color.mainColor)
                                .shadow(radius: 8, x: 4, y: 4)
                        )
                        .opacity(show ? 1 : 0)
                        .offset(x: show ? -90 : 0, y: show ? -90 : 0)
                }
                Button(action: { show.toggle() }) {
                    Image(systemName: "list.dash")
                        .padding(24)
                        .rotationEffect(Angle.degrees(show ? 0 : 90))
                        .background(
                            Circle()
                                .fill(Color.mainColor)
                                .shadow(radius: 8, x: 4, y: 4)
                        )
                        .opacity(show ? 1 : 0)
                        .offset(x: show ? -130 : 0, y: 0)
                }
                Button(action: { show.toggle() }) {
                    Image(systemName: "plus")
                        .padding(24)
                        .background(
                            Circle()
                                .fill(Color.mainColor)
                                .shadow(radius: 8, x: 4, y: 4)
                        )
                }
            }
        }
        .padding(10)
        .accentColor(.white)
        .animation(.default, value: show)
    }
}

struct ButtonsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsAnimation()
    }
}
