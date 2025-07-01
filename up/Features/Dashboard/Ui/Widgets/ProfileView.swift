//
//  VideoView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI

struct ProfileView: View {
    
    let url:String?
    let name:String?
    let description:String?
    
    init(url: String? = nil, name: String? = nil, description: String? = nil) {
        self.url = url
        self.name = name
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .padding(2)
                    .borderCornerRadius(22, color: .white, width: 2)
                    .clipCircle()
                
                SizedBox(width: 8.pxw, height: 8)
                
                ESText(name ?? "", style: .h6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SizedBox(width: 8.pxw, height: 8.pxh)
            
            ExpandableText(description ?? "")
        }
        .padding(24.px)
        .padding(.bottom, 22.pxh)
    }
}
