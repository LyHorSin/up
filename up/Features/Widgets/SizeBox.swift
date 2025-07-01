//
//  SizeBox.swift
//  up
//
//  Created by Ly Hor Sin on 28/6/25.
//

import SwiftUI

struct SizedBox: View {
    var width: CGFloat? = nil
    var height: CGFloat? = nil

    var body: some View {
        Color.clear
            .frame(width: width, height: height)
    }
}
