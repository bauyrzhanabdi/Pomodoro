import UIKit
import SnapKit

class PomodoroViewController: UIViewController {
    // MARK: - Outlets
    private lazy var isWorkTime: Bool = true
    private lazy var isStarted: Bool = false
    
    private lazy var timerLabel: UILabel = UILabel(
        text: "25:00",
        allignment: .center,
        color: isWorkTime ? .red : .green,
        fontSize: 50,
        fontWeight: 0
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
        view.addSubview(timerLabel)
    }
    
    private func setupLayout() {
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }
    
    // MARK: - Actions
    
    
}

