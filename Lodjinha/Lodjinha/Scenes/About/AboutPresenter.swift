//
//  AboutPresenter.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 21/06/19.
//  Copyright (c) 2019 ely.assumpcao.ndiaye. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AboutPresentationLogic
{
  func presentSomething(response: About.Something.Response)
}

class AboutPresenter: AboutPresentationLogic
{
  weak var viewController: AboutDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: About.Something.Response)
  {
    let viewModel = About.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
