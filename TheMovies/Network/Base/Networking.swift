//
//  Networking.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//

import Foundation
import UIKit

class Network {
    static let shared = Network()

    private let queue = DispatchQueue(label: "Network", qos: .userInitiated, attributes: .concurrent)

    enum NetworkError: Error {
        case noDataOrError
    }

    struct StatusCodeError: LocalizedError {
        let code: Int

        var errorDescription: String? {
            return "An error occurred communicating with the server. Please try again."
        }
    }

    /**
     The session that the app uses. Since it uses delegate: self, it must be declared lazy. You should never change this.
     */
    let session = URLSession(configuration: .default)

    // MARK: - API

    /**
     Sends a data request and parses the result into a model. To specify the model type, you'll need to include the type in your completion block.

     For instance:

     ```Network.shared.send(request) { result: Result<MyModel, Error> in ```
     */
    @discardableResult
    func send<T: BaseResponseProtocol>(_ request: Requestable, completion: @escaping (Result<T, Error>)->Void) -> NetworkTask {
        return send(request) { (result: Result<DecodableConvertible<T>, Error>) in
            completion(result.map { $0.model })
        }
    }

    /**
     Send a request and return anything which is DataConvertible. See DataConvertible.swift for a full list of types.

     If you don't care about what's returned, you should expect: Result<Empty, Error>.
     */
    @discardableResult
    func send<T: DataConvertible>(_ request: Requestable,
                                  completion: @escaping (Result<T, Error>)->Void) -> NetworkTask {
        return send(request,
                    taskCreator: { urlRequest, completion in self.session.dataTask(with: urlRequest,
                                                                                   completionHandler: completion) },
                    dataConvertor: { try T.convert(from: $0) },
                    completion: completion)
    }

    // MARK: - Main Networking Logic

    /**
     A wrapper function which allows us to send all of our requests down the same path. The syntax is a bit confusing, but that's ok because it's private.

     The taskCreator should create a URLSessionTask from a URLRequest and a completion block.
     The dataConvertor converts data to the expected return type.
     */
    private func send<DataType, ReturnType>(_ request: Requestable,
                                            taskCreator: @escaping ((URLRequest, @escaping (DataType?, URLResponse?, Error?)->Void)->URLSessionTask),
                                            dataConvertor: @escaping (DataType?) throws -> ReturnType,
                                            completion: @escaping (Result<ReturnType, Error>)->Void) -> NetworkTask {
        // Create a network task to immediately return
        let networkTask = NetworkTask()

        let backgroundTaskID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)

        // Go to a background queue as request.urlRequest() may do json parsing
        queue.async {
            let urlRequest = request.urlRequest()

            let urlToLog = urlRequest.url?.absoluteString ?? ""
            Logger.verbose("Send: \(urlToLog) - \(urlRequest.httpMethod ?? "")")

            let task = taskCreator(urlRequest) { data, response, error in
                let result: Result<ReturnType, Error>

                if let error = error {
                    result = .failure(error)
                } else if let error = self.error(from: response, with: request) {
                    result = .failure(error)
                } else {
                    do {
                        result = .success(try dataConvertor(data))
                    } catch let error {
                        result = .failure(error)
                    }
                }

                if case let .failure(error) = result {
                    Logger.error("Request failed: \(urlToLog) - \(error)")
                } else {
                    Logger.verbose("Request succeeded: \(urlToLog)")
                }

                DispatchQueue.main.async {
                    completion(result)

                    UIApplication.shared.endBackgroundTask(backgroundTaskID)
                }
            }

            task.resume()

            // Asyncronously set the real task inside the network task.
            // Note: This may happen after the NetworkTask has been cancelled but the NetworkTask object already handles this
            networkTask.set(task)
        }

        return networkTask
    }

    // MARK: Helpers

    private func error(from response: URLResponse?, with request: Requestable) -> Error? {
        guard let response = response as? HTTPURLResponse else {
            Logger.assertFailure("Missing http response when trying to parse a status code.")
            return nil
        }

        let statusCode = response.statusCode
        if statusCode >= 200 && statusCode <= 299 {
            return nil
        } else {
            Logger.error("Invalid status code from \(response.url?.absoluteString ?? "unknown"): \(statusCode)")
            return StatusCodeError(code: statusCode)
        }
    }
    
}
