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

@resultBuilder
public struct ActivateBuilder {
    public static func buildPartialBlock(first: [ConstraintProducer]) -> [ConstraintProducer] {
        first
    }
    
    public static func buildPartialBlock(accumulated: [ConstraintProducer], next: [ConstraintProducer]) -> [ConstraintProducer] {
        if next.isEmpty {
            return accumulated
        } else {
            var array = accumulated
            array.append(next[0])
            return array
        }
    }
    
    public static func buildEither(first component: [ConstraintProducer]) -> [ConstraintProducer] {
        component
    }
    
    public static func buildEither(second component: [ConstraintProducer]) -> [ConstraintProducer] {
        component
    }
    
    public static func buildOptional(_ component: [ConstraintProducer]?) -> [ConstraintProducer] {
        component ?? []
    }
    
    public static func buildExpression(_ expression: ConstraintProducer) -> [ConstraintProducer] {
        [expression]
    }
    
    public static func buildFinalResult(_ component: [ConstraintProducer]) {
        let group = Group(producers: component)
        group.isActive = true
    }
}
