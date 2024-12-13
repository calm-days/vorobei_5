//
//  ContentView.swift
//  vorobei_5
//
//  Created by Raman Liukevich on 13/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)

    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil

    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
    }

    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }

    var body: some View {

        ZStack {

            VStack(spacing: 0) {
                Color.black
                Color.white
                Color.black
                Color.white
            }

            VStack(spacing: 0) {
                Color.white
                Color.pink
                Color.yellow
                Color.black
            }
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .blendMode(.destinationOut)
                    .frame(width: 100, height: 100)
                    .position(location)
                    .gesture(simpleDrag.simultaneously(with: fingerDrag))
            }
            .compositingGroup()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
