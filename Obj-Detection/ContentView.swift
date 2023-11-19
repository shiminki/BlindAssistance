//
//  ContentView.swift
//  Obj-Detection
//
//  Created by Adonis Serrano on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center) {
                Text("N.O.D")
                    .font(.custom(
                        "AmericanTypewriter",
                        fixedSize: 36)
                        .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.size.width, height: 0.05*UIScreen.main.bounds.size.height, alignment: .center)
                    .background(.white)
                ZStack {
                    HostedViewController()
                        .ignoresSafeArea()
                }
                
                HStack {
                    // insert here
                }.frame(width: UIScreen.main.bounds.size.width, height: 0.05*UIScreen.main.bounds.size.height, alignment: .center)
                    .background(.white)
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
