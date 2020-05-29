//
//  ErrorViewModel.swift
//  vietagreport
//
//  Created by Hoi Dang Quoc on 5/29/20.
//  Copyright © 2020 Hoi. All rights reserved.
//

import Foundation

protocol ErrorViewModelProtocol {
    var title: String? { get }
    var message: String? { get }
    var buttonTitles: [String]? { get }
}

struct ErrorViewModel: ErrorViewModelProtocol {
    var title: String?
    var message: String?
    var buttonTitles: [String]?
}
