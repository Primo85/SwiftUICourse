//
//  XdissmissButton.swift
//  SwiftUICourse
//
//  Created by pbiskup on 26/10/2023.
//

import SwiftUI

struct XdissmissButton: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                isPresented = false
            } label: {
                Text("X").padding()
            }
        }.padding()
    }
}

struct XdissmissButton_Previews: PreviewProvider {
    static var previews: some View {
        XdissmissButton(isPresented: .constant(false))
    }
}
