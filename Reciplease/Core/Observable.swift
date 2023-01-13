//
//  Observable.swift
//  Reciplease
//
//  Created by Lorene Brocourt on 13/01/2023.
//

import Foundation

final class Observable<T> {
    var value: T {
        didSet {
            // whenever the value changes it's going to use listener
            self.listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: @escaping(T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
