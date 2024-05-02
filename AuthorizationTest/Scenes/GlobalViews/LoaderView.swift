//
//  LoaderView.swift
//  AuthorizationTest
//
//  Created by Евгений on 02.05.2024.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 70)
                .foregroundStyle(.universalGray)
                .opacity(0.1)
            
            
            ProgressView()
        }
    }
}

#Preview {
    LoaderView()
}
