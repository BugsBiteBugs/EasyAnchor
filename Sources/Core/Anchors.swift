#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

/// Produce constraints into group
public func group(_ producers: ConstraintProducer ...) -> Group {
    return Group(producers: producers)
}

/// Produce constraints into group and activate
public func activate(@ActivateBuilder contents: () -> Void) {
    contents()
}
