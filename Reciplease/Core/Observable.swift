//
//  Observable.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            self.listener?(value)
        }
    }

    var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: @escaping(T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
