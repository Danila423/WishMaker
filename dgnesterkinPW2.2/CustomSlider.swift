import UIKit

final class CustomSlider: UIView {
    var valueChanged: ((Float) -> Void)?
    // Изменяем уровень доступа с private на internal (или public, если нужно)
    let slider = UISlider()
    private let titleLabel = UILabel()

    init(title: String, min: Float, max: Float) {
        super.init(frame: .zero)
        titleLabel.text = title
        slider.minimumValue = min
        slider.maximumValue = max

        configureUI()
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        addSubview(slider)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            slider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func sliderValueChanged() {
        valueChanged?(slider.value)
    }
}
