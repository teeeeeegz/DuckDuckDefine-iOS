//
//  BasePresenter+Interface.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 13/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Foundation
import RxSwift

/**
 Common base type for a Presenter, to attach a View which implements this protocol
 */
protocol MvpView : class {
}

/**
 Common base class for Presenters to extend from, of type MvpView, providing common functionality
 This base class enables linking a View based on a specific protocol type
 */
class BasePresenter<MvpView> {
    private var mvpView : MvpView?
    private let disposeBag = DisposeBag()
    
    init () {
    }
    
    func attachView(_ view: MvpView) {
        self.mvpView = view
    }
    
    func detachView() {
        self.mvpView = nil
    }
    
    func getMvpView() -> MvpView {
        return self.mvpView!
    }
    
    func isViewAttached() -> Bool {
        return self.mvpView != nil
    }
    
    func getDisposeBag() -> DisposeBag {
        return disposeBag
    }
}
