//
//  BasicAnimations.swift
//  GoodWeather
//
//  Created by Łukasz Andrzejewski on 02/06/2023.
//

import SwiftUI

struct BasicAnimations: View {
    
    @State
    var start = false
    @State
    var width: CGFloat = 100
    @State
    var height: CGFloat = 100
    
    var body: some View {
//        RoundedRectangle(cornerRadius: start ? 50 : 10)
//            .frame(width: 100, height: 100)
//            .foregroundColor(start ? .mainColor : .activeColor)
//            .hueRotation(Angle.degrees(start ? 50 : 0))
//            .scaleEffect(start ? 0.2 : 1)
//            .rotationEffect(Angle.degrees(start ? 90 : 0))
//            //.animation(.easeInOut(duration: 3).delay(3), value: start)
//            //.animation(.easeInOut.repeatCount(2, autoreverses: true), value: start)
//            .animation(Animation.easeIn(duration: 1).repeatCount(3, autoreverses: true), value: start)
        
//        RoundedRectangle(cornerRadius: 10)
//            .size(width: width, height: height)
//            .foregroundColor(.mainColor)
//            .scaleEffect(start ? 1 : 0.01)
//            .animation(.spring(dampingFraction: 0.5), value: start)
        
        if start {
            RoundedRectangle(cornerRadius: 10)
                .size(width: width, height: height)
                .foregroundColor(.mainColor)
                //.transition(.scale.combined(with: .opacity))
                .transition(.asymmetric(insertion: .slide, removal: .opacity))
        }
        Spacer()
        Button(action: {
            withAnimation {
                start.toggle()
//                if start == true {
//                    width = 200
//                    height = 200
//                } else {
//                    width = 100
//                    height = 100
//                }
            }
        }) {
            Text("Start")
                .frame(width: 200, height: 40)
                .foregroundColor(.white)
                .background(Color.mainColor)
        }
        .cornerRadius(8)
    }
    
}

struct BasicAnimations_Previews: PreviewProvider {
    static var previews: some View {
        BasicAnimations()
    }
}
