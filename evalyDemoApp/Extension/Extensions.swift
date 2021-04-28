//
//  Extensions.swift
//  evalyDemoApp
//
//  Created by Abdullah Al Mamun on 28/4/21.
//

import Foundation
import Alamofire
extension DataRequest{
    /// @Returns - DataRequest
    /// completionHandler handles JSON Object T
    @discardableResult func responseObject<T: Decodable> (
        queue: DispatchQueue? = nil ,
        completionHandler: @escaping (DataResponse<T>) -> Void ) -> Self{
        
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else {return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))}
            
            let result = DataRequest.serializeResponseData(response: response, data: data, error: error)
            guard case let .success(jsonData) = result else{
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            // (1)- Json Decoder. Decodes the data object into expected type T
            // throws error when failes
            let decoder = JSONDecoder()
            guard let responseObject = try? decoder.decode(T.self, from: jsonData)else{
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
            }
            return .success(responseObject)
        }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
extension UIImageView{
func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
       contentMode = mode
       URLSession.shared.dataTask(with: url) { data, response, error in
           guard
               let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
               let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
               let data = data, error == nil,
               let image = UIImage(data: data)
               else { return }
           DispatchQueue.main.async() { [weak self] in
               self?.image = image
           }
       }.resume()
   }
   func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
       guard let url = URL(string: link) else { return }
       downloaded(from: url, contentMode: mode)
   }
}
