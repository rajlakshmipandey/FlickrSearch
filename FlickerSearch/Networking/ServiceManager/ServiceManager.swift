


import Foundation

struct ServiceManager {
 private var provider = Provider<FlickerSearchAPI>()
}


extension ServiceManager {
    
    // Fetch request with endPoint
    // -Parameter: endPoint
    // Result:-  Network Completion block
    func fetchData<EndPoint>(_ endPoint: EndPoint, completion: @escaping NetworkCompletionBlock) where EndPoint:EndPointType {
        guard let endPointType = endPoint as? FlickerSearchAPI else {return}
            provider.request(endPoint: endPointType) {(data, response, error) in
                self.parseURLRequestData(data: data, response: response, error: error) { (data, error) in
                    completion(data, error)
            }
        }
    }
    
    // Parse the URLRequest response
    // -Parameter: data, response and error
    // Result:- returns a completion closure with Data object or error string
    private func parseURLRequestData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkCompletionBlock) {
        
        if let _ = error {
            completion(nil, NetworkError.internetError)
            return
        }
        
      
        guard let data = data else {
            completion(nil, NetworkError.noResult)
            return
        }
        completion(data, nil)
    }
}

