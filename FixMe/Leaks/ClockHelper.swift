//
//  ClockHelper.swift
//  FixMe
//
//  Created by Alex Antonyuk on 13.07.2023.
//

import Foundation
import Combine

protocol ClockHelperDelegate {
    func clockTicketTenTimes(_ sender: ClockHelper)
}

final class ClockHelper {
    private var subscriptions: Set<AnyCancellable> = .init()

    var delegate: ClockHelperDelegate?

    var clockTickCallback: (() -> Void)?
    private var counter = 0

    init() {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.clockTickCallback?()
                self.counter += 1
                if self.counter.remainderReportingOverflow(dividingBy: 10).partialValue == 0 {
                    self.delegate?.clockTicketTenTimes(self)
                }
            }
            .store(in: &subscriptions)
    }
}
