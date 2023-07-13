//
//  SwiftUIView.swift
//  FixMe
//
//  Created by Alex Antonyuk on 13.07.2023.
//

import SwiftUI

struct SwiftUIView: View {
    @State var counter: Int

    init(counter: Int) {
        self.counter = counter
    }

    var body: some View {
        HStack {
            Button("-") {
                counter -= 1
            }
            Text("\(counter)")
            Button("+") {
                counter += 1
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(counter: 1)
    }
}
