import UIKit
import SnapKit

class PomodoroViewController: UIViewController {
    // MARK: - Outlets
    private lazy var isWorkTime: Bool = true
    private lazy var isStarted: Bool = false
    
    private lazy var timerCountdownLabel: UILabel = UILabel(
        text: "25:00",
        allignment: .center,
        color: isWorkTime ? .red : .green,
        fontSize: 50,
        fontWeight: 0
    )
    
    private lazy var timerControlButton: UIButton = UIButton(
        image: isStarted ? "pause" : "play",
        imageColor: isWorkTime ? .red : .green,
        backgroundColor: .clear,
        action: #selector(timerControlButtonPressed),
        target: self
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupHierarchy() {
        view.addSubview(timerCountdownLabel)
        view.addSubview(timerControlButton)
    }
    
    private func setupLayout() {
        timerCountdownLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        timerControlButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(timerCountdownLabel.snp.bottom).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
    }
    
    // MARK: - Actions
    @objc private func timerControlButtonPressed(_ sender: UIButton) {
        isStarted.toggle()
        let image = isStarted ? "pause" : "play"
        sender.setImage(UIImage(systemName: image), for: .normal)
    }
    
}

