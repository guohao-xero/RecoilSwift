//MARK: - Atoms
public func atom<T: Equatable>(_ value: T) -> Atom<T> {
    Atom(value)
}

public func atom<T: Equatable>(_ fn: () -> T) -> Atom<T> {
    Atom(fn())
}

//MARK: - Selectors
public func selector<T: Equatable>(_ getBody: @escaping GetBody<T>) -> Selector<T> {
    Selector(body: getBody)
}

@available(iOS 13.0, *)
public func selector<T: Equatable, E: Error>(_ getBody: @escaping CombineGetBody<T, E>) -> AsyncSelector<T, E> {
    AsyncSelector(get: getBody)
}

public func selector<T: Equatable>(get getBody: @escaping GetBody<T>, set setBody: @escaping SetBody<T>) -> MutableSelector<T> {
    MutableSelector(get: getBody, set: setBody)
}

//MARK: - Families
public func selectorFamily<P, T: Equatable>(
    _ getBody: @escaping ParametricGetBody<P, T>
) -> FamilyFunc<P, Selector<T>> {
    
    return { (param: P) -> ParametricRecoilValue<P, Selector<T>> in
        let body = curry(getBody)(param)
        return ParametricRecoilValue(recoilValue: selector(body), param: param)
    }
}

@available(iOS 13.0, *)
public func selectorFamily<P, T: Equatable, E: Error>(
    _ getBody: @escaping ParametricCombineGetBody<P, T, E>
) -> FamilyFunc<P, AsyncSelector<T, E>> {
    
    return { (param: P) -> ParametricRecoilValue<P, AsyncSelector<T, E>> in
        let body = curry(getBody)(param)
        return ParametricRecoilValue(recoilValue: selector(body), param: param)
    }
}
