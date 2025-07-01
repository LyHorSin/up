//
//  ESRequest.swift
//  up
//
//  Created by Ly Hor Sin on 29/5/24.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

class ESRequest {
    
    class func request(api: ESMultiTargetRequest,
                       successCompletion: @escaping (_ response: AFDataResponse<Data>) -> Void,
                       errorCompletion: @escaping (_ error: ESError) -> Void,
                       progression: ((_ progress: Progress) -> Void)? = nil) {
        var header = HTTPHeaders()
        var parameter: Parameters?
        
//        if let accessToken = ESAuthenticationVM.share.token {
//            header["Authorization"] = accessToken
//            debugPrint(accessToken)
//        }
        
        let languageCode = ESLocalizable.share.languageCode
        let defaultHeaders = [
            "Accept" : "application/json",
            "Accept-Language" : languageCode
        ]
        
        defaultHeaders.forEach { (key, value) in
            header[key] = value
        }
        
        if let headers = api.headers {
            headers.forEach { key, value in
                header[key] = value
            }
        }
                
        if let params = api.body {
            parameter = params
        }
        
        let urlString = api.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        AF.request(urlString, method: api.method, parameters: parameter, encoding: JSONEncoding.default, headers: header, interceptor: nil).responseData(completionHandler: { response in
            let statusCode = response.response?.statusCode ?? 0
            debugPrint("\(api.method.rawValue) \(api.url)", response.response?.statusCode ?? 0)
            switch response.result {
            case .success:
                handleSuccess(response: response, statusCode: statusCode, successCompletion: successCompletion, errorCompletion: errorCompletion)
            case let .failure(error):
                handleFailure(error: error, statusCode: statusCode, errorCompletion: errorCompletion)
            }
        }).downloadProgress { progress in
            if let progression = progression {
                progression(progress)
            }
        }
    }
    
    class private func handleSuccess(response: AFDataResponse<Data>, statusCode: Int, successCompletion: @escaping (_ response: AFDataResponse<Data>) -> Void, errorCompletion: @escaping (_ error: ESError) -> Void) {
        if let data = response.data {
            debugPrint("Response----------------------------------------Response")
            debugPrint(JSON(data))
            debugPrint("END----------------------------------------END")
        }
        if statusCode == SUCCESS_CODE {
            successCompletion(response)
        } else if statusCode == UNAUTHORIZED_CODE {
            let error = ESError.getUnauthorizedError()
            handleUnauthorizedError(defaultErrorMethod: error, errorCompletion: errorCompletion)
        } else {
            if let data = response.data {
                if let json = JSON(data).dictionaryObject {
                    let error = ESError.getError(dict: json)
                    errorCompletion(error)
                } else {
                    let error = ESError.getGeneralError()
                    errorCompletion(error)
                }
            } else {
                let error = ESError.getGeneralError()
                errorCompletion(error)
            }
        }
    }
    
    class private func handleFailure(error: AFError, statusCode: Int, errorCompletion: @escaping (_ error: ESError) -> Void) {
        switch error {
        case .sessionTaskFailed(URLError.timedOut):
            let message = NSError(domain: "", code: NSURLErrorTimedOut, userInfo: nil).localizedDescription
            handleError(message: message,
                        defaultErrorMethod: ESError.getGeneralError(),
                        errorCompletion: errorCompletion)
        case .sessionTaskFailed(URLError.networkConnectionLost), .sessionTaskFailed(URLError.notConnectedToInternet):
            let message = NSError(domain: "", code: URLError.networkConnectionLost.rawValue, userInfo: nil).localizedDescription
            handleError(message:message,
                        defaultErrorMethod: ESError.getNetworkConnectionError(),
                        errorCompletion: errorCompletion)
        default:
            handleError(message:error.localizedDescription,
                        defaultErrorMethod: ESError.getGeneralError(),
                        errorCompletion: errorCompletion)
        }
    }
    
    class private func handleError(message:String?, defaultErrorMethod: ESError, errorCompletion :(_ error :ESError)->Void) {
        let errorObj = defaultErrorMethod
        if let message = message {
            errorObj.error = message
        }
        errorCompletion(errorObj)
    }
    
    class private func handleUnauthorizedError(defaultErrorMethod: ESError, errorCompletion :(_ error :ESError)->Void) {
        let errorObj = defaultErrorMethod
        errorCompletion(errorObj)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let presenting = UIApplication.topViewController() {
                // Check if the top view controller is already a UIAlertController
                if presenting is UIAlertController {
                    // UIAlertController is already presented, so do nothing
                    return
                }
                
                // Create and present the alert
                let alert = UIAlertController(title: defaultErrorMethod.message,
                                              message: defaultErrorMethod.error,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Login", style: .destructive, handler: { action in
//                    ESThread.main {
//                        if  ESAppManager.share.target == .Client {
//                            ESAuthorizeLoginViewController.goToLogin(source: presenting)
//                        } else {
//                            ESAuthorizeLoginViewController.goToAuthorizeLoginAndReplace(source: presenting)
//                        }
//                    }
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                    DispatchQueue.main.async {
                        presenting.goBack()
                    }
                }))
                presenting.present(alert, animated: true)
//                ESAuthenticationVM.share.clearSession()
            }
        }
    }
}

extension ESRequest {
    
    @discardableResult
    class func requestWithFormData(api: ESMultiTargetRequest,
                                   accessToken: String?,
                                   successCompletion: @escaping (_ response: AFDataResponse<Data>) -> Void,
                                   errorCompletion: @escaping (_ error: ESError) -> Void,
                                   progression: ((_ progress: Progress) -> Void)? = nil) -> UploadRequest {
        var header = HTTPHeaders()
        
//        if let accessToken = ESAuthenticationVM.share.token {
//            header["Authorization"] = accessToken
//        }
        
        let languageCode = ESLocalizable.share.local.rawValue
        header["Accept-Language"] = languageCode
        
        if let headers = api.headers {
            headers.forEach { key, value in
                header[key] = value
            }
        }
        
        let urlString = api.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return AF.upload(multipartFormData: { multipartFormData in
            api.setMultipartFormData(multipartFormData: multipartFormData)
        }, to: urlString, method: api.method, headers: header)
        .uploadProgress { progress in
            if let progression = progression {
                progression(progress)
            }
        }
        .responseData { response in
            let statusCode = response.response?.statusCode ?? 0
            switch response.result {
            case .success:
                handleSuccess(response: response, statusCode: statusCode, successCompletion: successCompletion, errorCompletion: errorCompletion)
            case let .failure(error):
                handleFailure(error: error, statusCode: statusCode, errorCompletion: errorCompletion)
            }
        }
    }
}
