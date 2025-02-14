//
//  Constants.swift
//  Lodjinha
//
//  Created by ely.assumpcao.ndiaye on 17/06/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//


import Foundation

typealias CompletionHandler = (_ Success: Bool, _ errorMessage :String?) -> ()

// URL Constants
let BASE_URL = "https://alodjinha.herokuapp.com"
let URL_BANNER = "\(BASE_URL)/banner"
let URL_CATEGORIA = "\(BASE_URL)/categoria"
let URL_PRODUTO = "\(BASE_URL)/produto"
let URL_PRODUTO_MAISVENDIDOS = "\(URL_PRODUTO)/maisvendidos"

let URL_STATEMENTS = "\(BASE_URL)/statements/"
//\(AuthService.instance.userId)
// Segues
let TO_CURRENCY = "toCurrency"


// User Defaults
let LOGGED_IN_KEY = "loggedIn"
let USER_NAME = "userName"
let USER_AGENCY = "userAgency"
let USER_BALANCE = "userBalance"
let USER_BANKACCOUNT = "userBankAccount"
let USER_ID = "userId"

let TITLE = "title"
let DESC = "desc"
let DATE = "date"
let VALUE = "value"


//Headers
let BEARER_HEADER = [
    "Content-Type": "application/x-www-form-urlencoded"
]
