//
//  LeaksViewController.swift
//  FixMe
//
//  Created by Alex Antonyuk on 13.07.2023.
//

import UIKit
import SnapKit

final class LeaksViewController: UIViewController {

    private let clockLabel: UILabel = .init()
    private let clockHelper: ClockHelper = .init()

    init() {
        LeaksCounter.shared.up()

        super.init(nibName: nil, bundle: nil)

        clockHelper.clockTickCallback = updateTime
    }

    deinit {
        LeaksCounter.shared.down()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        clockLabel.text = formatter.string(from: .now)
    }

    private func setup() {
        view.backgroundColor = .white

        let label = UILabel()
        label.text = "\(LeaksCounter.shared.counter)"

        let stack = UIStackView(arrangedSubviews: [
            label,
            clockLabel
        ])
        stack.axis = .vertical

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        navigationItem.title = "💦💦💦"
        navigationItem.backBarButtonItem = .init(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.primaryAction = .init(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })

        clockHelper.delegate = self
    }
}

// MARK: -
extension LeaksViewController: ClockHelperDelegate {
    func clockTicketTenTimes(_ sender: ClockHelper) {
        print("🔔")
    }
}
