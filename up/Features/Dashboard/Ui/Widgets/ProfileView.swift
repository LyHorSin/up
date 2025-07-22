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
    
    @State private var isExpanded:Bool = false
    
    init(url: String? = nil, name: String? = nil, description: String? = nil) {
        self.url = url
        self.name = name
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 0) {
                AnimatedImage(url: URL(string: url ?? "")) {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .borderCornerRadius(22, color: .white, width: 1)
                .padding(2)
                .clipCircle()
                
                SizedBox(width: 8.pxw, height: 8)
                
                ESText(name ?? "", style: .h6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SizedBox(width: 8.pxw, height: 8.pxh)
            
            ScrollView(.vertical, showsIndicators: false) {
                ExpandableText(
                    text: description ?? "",
                    isExpanded: $isExpanded
                )
                .introspectScrollView { scrollView in
                    scrollView.bounces = false
                }
            }
            .frame(maxHeight: screenHeight * 0.7)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(24.px)
        .background(
            GeometryReader { geo in
                Rectangle()
                    .fill(isExpanded ? Color.black90 : Color.clear)
                    .cornerRadius(20)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
        )
    }
}
