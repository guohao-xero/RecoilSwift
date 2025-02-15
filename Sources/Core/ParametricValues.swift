#if canImport(Combine)
import Combine
#endif

public struct ParametricRecoilValue<P, T: RecoilValue> {
    let recoilValue: T
    let param: P
}

public typealias ParametricGetBody<P, T> = (P, Getter) -> T

@available(iOS 13, *)
public typealias ParametricCombineGetBody<P, T,  E: Error> = (P, Getter) throws -> AnyPublisher<T, E>

public typealias FamilyFunc<P, T: RecoilValue> = (P) -> ParametricRecoilValue<P, T>
