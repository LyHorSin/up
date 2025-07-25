//
//  FacebookAdView.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/25.
//

import SwiftUI
import FBAudienceNetwork

struct FacebookAdView: View {
    
    let news: News
    let width: CGFloat
    let height:CGFloat
    
    var body: some View {
        ZStack {
            NewsItemView(news: news,
                         width: screenWidth,
                         height: screenHeight)
            
            if let adId = news.adId {
                FBInterstitialAdRepresentable(adId: adId)
            }
        }
    }
}

struct FBInterstitialAdRepresentable: UIViewRepresentable {

    let adId:String
    var didShowAd:(()->Void)? = nil
    var didShowAdError:(()->Void)? = nil
    
    class Coordinator {
        var adView: FBBannerAdView?

        init(adView: FBBannerAdView?) {
            self.adView = adView
        }

        func showAd(from rootVC: UIViewController) {
            
        }
    }

    func makeUIView(context: Context) -> FBBannerAdView {
        let view = FBBannerAdView(adId: adId)
        context.coordinator.adView = view
        return view
    }

    func updateUIView(_ uiView: FBBannerAdView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(adView: nil)
    }

    // Expose this to manually trigger the ad from SwiftUI
    func showAd(from rootVC: UIViewController, context: Context) {
        context.coordinator.showAd(from: rootVC)
    }
}

class FBBannerAdView: UIView, FBAdViewDelegate {
    private var adView: FBAdView?
    private let adId: String
    private let adSize: FBAdSize

    init(adId: String, adSize: FBAdSize = kFBAdSizeHeight50Banner) {
        self.adId = adId
        self.adSize = adSize
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()

        // Load ad when added to window
        if window != nil {
            loadBannerAd()
        }
    }

    private func loadBannerAd() {
        adView = FBAdView(placementID: adId, adSize: adSize, rootViewController: UIApplication.shared.rootController)
        adView?.delegate = self
        adView?.loadAd()

        if let adView = adView {
            adView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(adView)

            NSLayoutConstraint.activate([
                adView.topAnchor.constraint(equalTo: topAnchor),
                adView.bottomAnchor.constraint(equalTo: bottomAnchor),
                adView.leadingAnchor.constraint(equalTo: leadingAnchor),
                adView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Optional: FBAdViewDelegate methods
    func adViewDidLoad(_ adView: FBAdView) {
        
    }

    func adView(_ adView: FBAdView, didFailWithError error: Error) {
        print("Banner ad failed to load: \(error.localizedDescription)")
    }
}

