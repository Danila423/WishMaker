import UIKit

final class WishMakerViewController: UIViewController {
    private var isSlidersHidden = false
    private let stack = UIStackView()
    private let hexTextField = UITextField()

    // Создаем слайдеры с диапазоном значений от 0 до 255
    private let sliderRed = CustomSlider(title: "Red", min: 0, max: 255)
    private let sliderGreen = CustomSlider(title: "Green", min: 0, max: 255)
    private let sliderBlue = CustomSlider(title: "Blue", min: 0, max: 255)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSliders()
        configureToggleButton()
        configureHexTextField()
        configureHexButton()
        configureRandomColorButton()
    }

    private func configureUI() {
        view.backgroundColor = .systemPink

        let title = UILabel()
        title.text = "WishMaker"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 32)

        view.addSubview(title)

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)

        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        sliderRed.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
        sliderGreen.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
        sliderBlue.valueChanged = { [weak self] _ in self?.updateBackgroundColor() }
    }

    private func configureToggleButton() {
        let toggleButton = createStyledButton(title: "Toggle Sliders")
        view.addSubview(toggleButton)

        toggleButton.addTarget(self, action: #selector(toggleSliders), for: .touchUpInside)

        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
            toggleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40), // Расширяем фон кнопки
            toggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40) // Расширяем фон кнопки
        ])
    }

    private func configureHexTextField() {
        hexTextField.placeholder = "Enter HEX color"
        hexTextField.borderStyle = .roundedRect
        hexTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hexTextField)

        NSLayoutConstraint.activate([
            hexTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexTextField.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 60),
            hexTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hexTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func configureHexButton() {
        let hexButton = createStyledButton(title: "Apply HEX")
        view.addSubview(hexButton)

        hexButton.addTarget(self, action: #selector(applyHexColor), for: .touchUpInside)

        NSLayoutConstraint.activate([
            hexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hexButton.topAnchor.constraint(equalTo: hexTextField.bottomAnchor, constant: 20),
            hexButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40), // Расширяем фон кнопки
            hexButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40) // Расширяем фон кнопки
        ])
    }

    private func configureRandomColorButton() {
        let randomColorButton = createStyledButton(title: "Random Color")
        view.addSubview(randomColorButton)

        randomColorButton.addTarget(self, action: #selector(generateRandomColor), for: .touchUpInside)

        NSLayoutConstraint.activate([
            randomColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomColorButton.topAnchor.constraint(equalTo: hexTextField.bottomAnchor, constant: 60),
            randomColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40), // Расширяем фон кнопки
            randomColorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40) // Расширяем фон кнопки
        ])
    }

    @objc private func toggleSliders() {
        isSlidersHidden.toggle()
        stack.isHidden = isSlidersHidden
    }

    @objc private func applyHexColor() {
        guard let hexString = hexTextField.text, let color = UIColor(hex: hexString) else {
            return
        }
        view.backgroundColor = color
    }

    @objc private func generateRandomColor() {
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)

        view.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    private func updateBackgroundColor() {
        let redValue = CGFloat(sliderRed.slider.value) / 255
        let greenValue = CGFloat(sliderGreen.slider.value) / 255
        let blueValue = CGFloat(sliderBlue.slider.value) / 255

        view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }

    // Создаем функцию для стилизации кнопок
    private func createStyledButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
