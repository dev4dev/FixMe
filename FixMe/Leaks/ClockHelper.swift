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
    private var subscription: AnyCancellable?

    var delegate: ClockHelperDelegate?

    var clockTickCallback: (() -> Void)?
    private var counter = 0

    init() {
        // no-op
    }

    func start(interval: TimeInterval) {
        subscription = Timer.publish(every: interval, on: .main, in: .common)
            .sink { _ in
                self.clockTickCallback?()
                self.counter += 1
                if self.counter.remainderReportingOverflow(dividingBy: 10).partialValue == 0 {
                    self.delegate?.clockTicketTenTimes(self)
                }
            }
    }

    func stop() {
        subscription?.cancel()
        subscription = nil
    }
}
