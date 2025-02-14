//
//  AboutInteractor.swift
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

protocol AboutBusinessLogic
{
  func doSomething(request: About.Something.Request)
}

protocol AboutDataStore
{
  //var name: String { get set }
}

class AboutInteractor: AboutBusinessLogic, AboutDataStore
{
  var presenter: AboutPresentationLogic?
  var worker: AboutWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: About.Something.Request)
  {
    worker = AboutWorker()
    worker?.doSomeWork()
    
    let response = About.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
