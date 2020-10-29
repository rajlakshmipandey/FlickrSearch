
import Foundation


typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

// Provides interface for network routing and defines an associated type *EndPoint* confirming to *EndPointType* protocol
protocol NetworkHandlerProtocol {
    
    associatedtype EndPoint: EndPointType
    
    @discardableResult
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) -> URLSessionTask?
}

struct Provider<EndPoint: EndPointType> {
    
    // Configure request
    private func configureRequest(from endPoint: EndPoint) throws -> URLRequest {
        let baseURL = endPoint.baseURL
        var urlRequest = URLRequest(url: baseURL, cachePolicy: endPoint.cachingPolicy, timeoutInterval: 3.0)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        do {
            switch endPoint.task {
            case .request(let urlParams):
                try configureHTTPParameters(urlRequest: &urlRequest, urlParams: urlParams)
            }
            return urlRequest
        } catch  {
            throw error
        }
    }
    
    
    // Configure url parameters
    private func configureHTTPParameters(urlRequest: inout URLRequest,urlParams: HTTPParameters?) throws {
        do {
            if let params = urlParams {
                try HTTPURLParameterEncoder.encode(urlRequest: &urlRequest, httpParameters: params)
            }
        } catch {
            throw error
        }
    }
}

extension Provider: NetworkHandlerProtocol {
    
    @discardableResult
    // Data task to fetch data
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) -> URLSessionTask? {
        do {
            let urlRquest = try configureRequest(from: endPoint)
            let urlTask = URLSession.shared.dataTask(with: urlRquest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            urlTask.resume()
            return urlTask
        } catch {
            completion(nil,nil,error)
        }
        return nil
        
    }
}

