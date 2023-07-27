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
public func activate(@ActivateBuilder contents: () -> Void) -> Void {
    contents()
}

@resultBuilder
public struct ActivateBuilder {
    public static func buildBlock(_ components: ConstraintProducer...) -> Void {
        let group = Group(producers: components)
        group.isActive = true
        return ()
    }
}
