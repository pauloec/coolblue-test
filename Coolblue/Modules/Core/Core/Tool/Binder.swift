//
//  Binder.swift
//  Core
//
//  Created by Paulo Correa on 11/12/2021.
//

final public class PublishBinder<Element> {
    public init() { }

    private var listener: ((Element) -> Void)?
    private var value: Element! {
        didSet { listener?(value) }
    }

    public func onNext(_ onNext: Element?) {
        guard listener != nil else {
            fatalError("Listener was not initialized")
        }

        guard let onNext = onNext else {
            return
        }

        self.value = onNext
    }

    public func bind(listener: ((Element) -> Void)?) {
        self.listener = listener

        guard let value = value else { return }
        listener?(value)
    }
}

final public class RelayBinder<Element> {
    private var listener: ((Element) -> Void)?

    public var value: Element {
        didSet { listener?(value) }
    }

    public init(_ value: Element) {
        self.value = value
    }

    public func bind(listener: ((Element) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
