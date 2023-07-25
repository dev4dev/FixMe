//
//  LeaksViewController.swift
//  FixMe
//
//  Created by Alex Antonyuk on 13.07.2023.
//

import UIKit
import SnapKit
import Then

final class LeaksViewController: UIViewController {

    private let clockLabel: UILabel = .init()
    private let clockHelper: ClockHelper = .init()
    private var activeInterval: Double = 1.0 {
        didSet {
            intervalLabel.text = "\(Int(activeInterval))"
        }
    }

    private let intervalLabel = UILabel().then {
        $0.text = "1"
    }

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
        label.text = "Instances: \(LeaksCounter.shared.counter)"

        let intervalControl = UIStepper()
        intervalControl.addTarget(self, action: #selector(intervalChange(_:)), for: .valueChanged)
        intervalControl.value = 1.0
        intervalControl.minimumValue = 1.0
        intervalControl.maximumValue = 5.0

        let startCTA = UIButton()
        startCTA.setTitle("Start", for: .normal)
        startCTA.setTitleColor(.label, for: .normal)
        startCTA.addAction(.init(handler: { _ in
            self.clockHelper.start(interval: self.activeInterval)
        }), for: .touchUpInside)

        let stopCTA = UIButton()
        stopCTA.setTitle("Stop", for: .normal)
        stopCTA.setTitleColor(.label, for: .normal)
        stopCTA.addAction(.init(handler: { _ in
            self.clockHelper.stop()
        }), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [intervalLabel, intervalControl, startCTA, stopCTA]).then {
                $0.axis = .horizontal
                $0.spacing = 10.0
            },
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

    @objc private func intervalChange(_ sender: UIStepper) {
        activeInterval = sender.value
    }
}

// MARK: -
extension LeaksViewController: ClockHelperDelegate {
    func clockTicketTenTimes(_ sender: ClockHelper) {
        print("🔔")
    }
}
