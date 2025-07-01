//
//  ESView+Ex.swift
//  up
//
//  Created by SINN SOKLYHOR on 26/4/24.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI
import Introspect

public let screenWidth = UIScreen.main.bounds.width

public let screenHeight = UIScreen.main.bounds.height

public let screenHeightSafe = screenHeight - navBarHeight - tabBarHeight

public var navBarHeight: CGFloat {
    let safeTop = safeArea.top
    let navController = UIApplication.topNavigationController()
    let navigationBarHeight = navController?.navigationBar.frame.height ?? .zero
    
    return navigationBarHeight + safeTop
}

var statusBarHeight: CGFloat {
    UIApplication.shared.windows
        .first?
        .windowScene?
        .statusBarManager?
        .statusBarFrame
        .height ?? 0
}

public func sizing(pixels: CGFloat) -> (width: CGFloat, height: CGFloat) {
    let sampleWidth = 375.00 // 100%
    let sampleHeight = 812.00 // 100%
    
    let widthPercentage = pixels*100.00/sampleWidth
    let heightPercentage = pixels*100.00/sampleHeight
    
    let width = widthPercentage/100 * screenWidth
    let height = heightPercentage/100 * screenHeight

    return (width,height)
}

public func responsiveWidthBased(rawPixels: CGFloat) -> CGFloat {
    let figmaDeviceWidth: CGFloat = 375.00
    let currentDeviceWidth = screenWidth
    let widthScaleFactor = currentDeviceWidth / figmaDeviceWidth
    let scaledPixels = widthScaleFactor * rawPixels
    return scaledPixels
}

public var tabBarHeight: CGFloat {
    let window = UIApplication.shared.windows.first
    let tabBarController = window?.rootViewController?.tabBarController
    let height = tabBarController?.tabBar.frame.height ?? .zero
    let safeTop = safeArea.bottom
    return height + safeTop
}

public var dynamicBottomSafeAreaPadding: CGFloat {
    safeArea.bottom.isZero ? 0 : 12
}

public var safeArea: UIEdgeInsets {
    let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    return keyWindow?.safeAreaInsets ?? .zero
}

public var isSmallTopSafeArea: Bool {
    let screenHeight = UIScreen.main.bounds.height
    /// IP 6 - 8 height
    return screenHeight == 667 || screenHeight == 736
}

public var isNoneBottomSafeArea: Bool {
    safeArea.bottom.isZero
}

extension UIView {
    
    @discardableResult
    func chainableBackgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    public func addCornerRadius(_ radius: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.frame, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setCustomCornerRadii(topLeft: CGFloat, topRight: CGFloat, bottomRight: CGFloat, bottomLeft: CGFloat) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + topLeft, y: bounds.minY))
        path.addArc(withCenter: CGPoint(x: bounds.minX + topLeft, y: bounds.minY + topLeft),
                    radius: topLeft,
                    startAngle: CGFloat.pi,
                    endAngle: 3 * CGFloat.pi / 2,
                    clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.maxX - topRight, y: bounds.minY + topRight),
                    radius: topRight,
                    startAngle: 3 * CGFloat.pi / 2,
                    endAngle: 0,
                    clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.maxX - bottomRight, y: bounds.maxY - bottomRight),
                    radius: bottomRight,
                    startAngle: 0,
                    endAngle: CGFloat.pi / 2,
                    clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.minX + bottomLeft, y: bounds.maxY - bottomLeft),
                    radius: bottomLeft,
                    startAngle: CGFloat.pi / 2,
                    endAngle: CGFloat.pi,
                    clockwise: true)
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    public func addLayout(layout: UIView, spacing: EdgeInsets = EdgeInsets()) {
        self.addSubview(layout)
        layout.translatesAutoresizingMaskIntoConstraints = false
        layout.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(spacing.leading)
            make.top.equalToSuperview().offset(spacing.top)
            make.bottom.equalToSuperview().offset(-spacing.bottom)
            make.trailing.equalToSuperview().offset(-spacing.trailing)
        }
    }
    
    public func addLayout(
        layout: UIView,
        spacing: EdgeInsets = EdgeInsets(),
        customConstraints: ((_ make: ConstraintMaker) -> Void)? = nil // Optional custom constraints
    ) {
        self.addSubview(layout)
        layout.translatesAutoresizingMaskIntoConstraints = false
        layout.snp.makeConstraints { make in
            // Apply spacing
            make.leading.equalToSuperview().offset(spacing.leading)
            make.top.equalToSuperview().offset(spacing.top)
            make.bottom.equalToSuperview().offset(-spacing.bottom)
            make.trailing.equalToSuperview().offset(-spacing.trailing)
            
            // Apply custom constraints if provided
            customConstraints?(make)
        }
    }
}

extension View {
    
    public var toUIKitView: UIView {
        UIHostingController(rootView: self).view
    }
    
    public var controller: UIViewController? {
        let root = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
        
        func findViewController(from root: UIViewController?) -> UIViewController? {
            if let nav = root as? UINavigationController {
                return findViewController(from: nav.visibleViewController)
            } else if let tab = root as? UITabBarController {
                return findViewController(from: tab.selectedViewController)
            } else if let presented = root?.presentedViewController {
                return findViewController(from: presented)
            } else {
                return root
            }
        }
        
        return findViewController(from: root)
    }
    
    public func rectangleContentShape() -> some View {
        contentShape(Rectangle())
    }
    
    public func defaultShadow() -> some View {
        self.shadow(color: Color(red: 95/255, green: 90/255, blue: 247/255, opacity: 0.03), radius: 10, x: 0, y: 10)
    }
    
    public func dismissKeyboardWhenInteractively() -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollDismissesKeyboard(.immediately)
        } else {
            return self.onAppear {
                UIScrollView.appearance().keyboardDismissMode = .onDrag
            }
        }
    }
    
    public func stickyHeader() -> some View {
        return self.introspectScrollView { scrollView in
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.bounces = false
            scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    public func dismissKeyboardWhenTap(completation: (()->Void)? = nil) -> some View {
        self.onTapGesture {
            UIApplication.shared.endEditing()
            completation?()
        }
    }
    
    public func dismissKeyboardWhenScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollDismissesKeyboard(.interactively)
        } else {
            return self.onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
    
    public func readSize(size: @escaping (CGSize) -> Void) -> some View {
        return overlay(GeometryReader { geo in
            Color.clear.onAppear {
                size(geo.size)
            }
        })
    }
    
    public func readOrigin(origin: @escaping (CGPoint) -> Void) -> some View {
        return overlay(GeometryReader { geo in
            Color.clear.onAppear {
                let frame = geo.frame(in: .named("scrollView")).origin
                origin(frame)
            }
        })
    }
    
    public func readMinMaxY(minMax: @escaping (_ minY: CGFloat,_ maxY: CGFloat) -> Void) -> some View {
        return overlay(GeometryReader { geo in
            Color.clear.onAppear {
                let frame = geo.frame(in: .named("scrollView"))
                let minY = frame.minY
                let maxY = frame.maxY
                minMax(minY, maxY)
            }
        })
    }
    
    @ViewBuilder
    func conditionalPresentation<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        if #available(iOS 14.0, *) {
            fullScreenCover(isPresented: isPresented, content: content)
        } else {
            sheet(isPresented: isPresented, content: content)
        }
    }
    
    @ViewBuilder
    func test(enable: Bool) -> some View {
        if enable {
            self.borderCornerRadius(10, color: .darkBlue, width: 3)
            
        } else {
            self
        }
    }
    
    @ViewBuilder
    public func ignoreKeyboard() -> some View {
        if #available(iOS 14.0, *) {
            ignoresSafeArea(.keyboard)
        } else {
        }
    }
    
    public func borderCornerRadius(_ radius: CGFloat, color: Color, width: CGFloat) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(color, lineWidth: width)
        )
    }
    
    public func onTapGestureShareLink(link: String?) -> some View {
        self.onTapGesture {
            if let link = link, let presenting = UIApplication.topViewController() {
                let share = UIActivityViewController(activityItems: [link], applicationActivities: nil)
                presenting.present(share, animated: true)
            }
        }
    }
}

extension View {
    
    // MARK: - Appearance
    
    public func clipCircle() -> some View {
        self.clipShape(Circle())
    }
    
    public func backgroundColor(_ color: Color) -> some View {
        self.background(color)
    }
    
    // MARK: - Size
    
    public func size(_ size: CGFloat) -> some View {
        self.size(size, size)
    }
    
    public func size(_ width: CGFloat, _ height: CGFloat) -> some View {
        self.frame(
            width: width.isFinite && width >= 0 ? width : nil,
            height: height.isFinite && height >= 0 ? height : nil
        )
    }
    
    public func width(_ width: CGFloat) -> some View {
        self.frame(width: width)
    }
    
    public func minHeight(_ height: CGFloat) -> some View {
        self.frame(minHeight: height)
    }
    
    public func minWidth(_ width: CGFloat) -> some View {
        self.frame(minWidth: width)
    }
    
    public func height(_ height: CGFloat) -> some View {
        self.frame(height: height)
    }
    
    public func dynamicFrame(maxWidth: CGFloat? = .infinity, maxHeight: CGFloat? = .infinity) -> some View {
        self.frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }

    // MARK: - Padding
    
    public func paddingLeading(_ padding: CGFloat) -> some View {
        self.padding(.leading, padding)
    }
    
    public func paddingTrailing(_ padding: CGFloat) -> some View {
        self.padding(.trailing, padding)
    }
    
    public func paddingTop(_ padding: CGFloat) -> some View {
        self.padding(.top, padding)
    }
    
    public func paddingBottom(_ padding: CGFloat) -> some View {
        self.padding(.bottom, padding)
    }
    
    public func paddingHorizontal(_ padding: CGFloat) -> some View {
        self.padding(.horizontal, padding)
    }
    
    public func paddingHorizontal(_ paddingLeading: CGFloat, _ paddingTrailing: CGFloat) -> some View {
        self.paddingLeading(paddingLeading)
            .paddingTrailing(paddingTrailing)
    }
    
    public func paddingVertical(_ padding: CGFloat) -> some View {
        self.padding(.vertical, padding)
    }
    
    public func paddingVertical(_ paddingTop: CGFloat, _ paddingBottom: CGFloat) -> some View {
        self.paddingTop(paddingTop)
            .paddingBottom(paddingBottom)
    }
}
