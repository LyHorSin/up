//
//  EProducVMRequest.swift
//  up
//
//  Created by Admin on 5/30/24.
//

import Foundation
import SwiftyJSON
import SwiftUI

extension EProductVM {
    //Hottest product
    public func hottestProductRequest(completation: @escaping (_ isSuccess :Bool) -> Void) {
        ESRequest.request(api: ESHottestProductRequest(), accessToken: nil) { response in
            if let data = response.data, let json = JSON(data).dictionaryObject {
                withAnimation {
                    if let data = json["data"] as? [String:Any] {
                        if let item = data["items"] as? [[String:Any]] {
                            self.hottestProducts = ESProduct.getProducts(json: item)
                        }
                        completation(true)
                    }
                }
            }
        } errorCompletion: { error in
            completation(false)
        } progression: { progress in
            
        }
    }
    //Image slider
    public func imageSliderRequest(completation: @escaping (_ isSuccess :Bool) -> Void) {
        ESRequest.request(api: ESHomeImageSilderRequest(), accessToken: nil) { response in
            if let data = response.data, let json = JSON(data).dictionaryObject {
                withAnimation {
                    if let data = json["data"] as? [String:Any] {
                        if let item = data["items"] as? [[String:Any]] {
                            self.banners = ESBanner.getBanners(json: item)
                        }
                        completation(true)
                    }
                }
            }
        } errorCompletion: { error in
            completation(false)
        } progression: { progress in
            
        }
    }
    //list product on home page
    public func productRequest(completation: @escaping (_ isSuccess :Bool) -> Void) {
        ESRequest.request(api: ESProductRequest(page: page), accessToken: nil) { response in
            if let data = response.data, let json = JSON(data).dictionaryObject {
                if let data = json["data"] as? [String:Any] {
                    withAnimation {
                        if let item = data["items"] as? [[String:Any]] {
                            let products = ESProduct.getProducts(json: item)
                            if self.isRefresh || self.products == nil {
                                self.products = []
                                self.isRefresh = false
                            }
                            self.isLastPage = products.isEmpty
                            self.products! += products
                        }
                        completation(true)
                    }
                }
            }
        } errorCompletion: { error in
            completation(false)
        } progression: { progress in
            
        }
    }
    //Product Detail
    public func productDetailRequest(productId:Int, completation: @escaping (_ isSuccess :Bool) -> Void) {
        ESRequest.request(api: ESProductDetailRequest(productId:productId), accessToken: nil) { response in
            if let data = response.data, let json = JSON(data).dictionaryObject {
                withAnimation {
                    if let data = json["data"] as? [String:Any] {
                        if let item = data["item"] as? [String:Any] {
                            self.product = ESProduct.getProduct(json: item)
                        }
                        completation(true)
                    }
                }
            }
        } errorCompletion: { error in
            completation(false)
        } progression: { progress in
            
        }
    }
}
