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
