//
//  AppCoordinator.swift
//  XCoordinator-Example
//
//  Created by Joan Disho on 03.05.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case login
    case home
}

class AppCoordinator: NavigationCoordinator<AppRoute> {

    init() {
        super.init(initialRoute: .login)
    }

    override func presented(from presentable: Presentable?) {
        super.presented(from: presentable)
        
        self.trigger(.home, with: TransitionOptions(animated: false), completion: nil)
    }

    var homeCoordinator: HomePageViewCoordinator?

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .login:
            var vc = LoginViewController.instantiateFromNib()
            let viewModel = LoginViewModelImpl(coordinator: anyCoordinator)
            vc.bind(to: viewModel)
            return .push(vc)
        case .home:
            self.homeCoordinator = HomePageViewCoordinator()
            let animation = Animation(presentationAnimation: CustomPresentations.flippingPresentation, dismissalAnimation: nil)
            return .present(homeCoordinator!, animation: animation)
        }
    }
}
