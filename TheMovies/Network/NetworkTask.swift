//
//  NetworkTask.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//

import Foundation

/**
 A semi-opaque object returned by the Network stack which allows you to cancel requests.
 Note: when you call cancel, the task may not yet have started. But as soon as it does start, it will immediately cancel.
 */
class NetworkTask {
    private var task: URLSessionTask?
    private var cancelled = false

    let queue = DispatchQueue(label: "com.task.networkTask", qos: .utility)

    func cancel() {
        queue.sync {
            cancelled = true

            if let task = task {
                task.cancel()
            }
        }
    }
    
    func set(_ task: URLSessionTask) {
        queue.sync {
            self.task = task

            if cancelled {
                task.cancel()
            }
        }
    }
}
