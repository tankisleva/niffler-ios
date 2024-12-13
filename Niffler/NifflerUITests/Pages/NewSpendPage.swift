import XCTest

class NewSpendPage: BasePage {
    
    func inputSpent(title: String) {
        inputAmount()
        .selectCategory()
        .inputDescription(title)
//        .swipeToAddSpendsButton()
        .pressAddSpend()
    }
    
    func inputAmount() -> Self {
        app.textFields["amountField"].typeText("14")
        return self
    }
    
    func selectCategory() -> Self {
        app.buttons["Select category"].tap()
        app.buttons["Рыбалка"].tap() // TODO: Bug
        return self
    }
    
    func inputDescription(_ title: String) -> Self {
        app.textFields["descriptionField"].tap()
        app.textFields["descriptionField"].typeText(title)
        return self
    }
    
//    func swipeToAddSpendsButton() -> Self {
//        let screenCenter = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
//        let screenTop = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
//        screenCenter.press(forDuration: 0.01, thenDragTo: screenTop)
//        return self
//    }
    
    
    
    
    func assertIsAddSpendButtonShown(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Жду кноку добавления траты") { _ in
            let isAddSpendButton = app.buttons["addSpendButton"].waitForExistence(timeout: 5)
            
            XCTAssertTrue(isAddSpendButton,
                          "Не нашли кнопку добавления траты",
                          file: file, line: line)
        }
    }
    
    func assertEmptySpendItem(file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Жду кноку добавления траты") { _ in
            XCTAssertEqual(app.scrollViews.switches.count, 0,
                                        "Список трат не пустой!",
                                        file: file, line: line)
        }
    }
    
    
//    func inputSpent(description: String, amount: String) {
//        inputAmount(amount: amount)
//        selectCategory()
//        inputDescription(description: description)
//        pressAddSpend()
//    }
    
    func inputAmount(amount: String) {
        XCTContext.runActivity(named: "Вводим сумму равную \(amount)") { _ in
         app.textFields["amountField"].typeText(amount)
        }
    }
    
    
    func addNewCategory(){
        XCTContext.runActivity(named: "Жму кноку добавления новой категории") { _ in
            app.buttons["+ New category"].tap()
        }
    }
    
    
    func verifyNewCategoryButtonIsVisibleAndTappable(file: StaticString = #file, line: UInt = #line) {
            let newCategoryButton = app.buttons["+ New category"]
            waitForElement(newCategoryButton, timeout: 5, message: "'+ New category' button did not appear.", file: file, line: line)
            
            XCTAssertTrue(newCategoryButton.exists, "'+ New category' button is not visible.", file: file, line: line)
            XCTAssertTrue(newCategoryButton.isHittable, "'+ New category' button is not tappable.", file: file, line: line)
        }
    
    func inputNameCategory(nameCategory: String) {
        XCTContext.runActivity(named: "Вводим название категории, равное  \(nameCategory)") { _ in
            app.textFields["Name"].typeText(nameCategory)
            app.buttons["Add"].firstMatch.tap()}
        }
    
    

    
    func selectCategory() {
        XCTContext.runActivity(named: "Выбираю категорию") { _ in
         app.buttons["Select category"].tap()
         app.buttons["Рыбалка"].tap()
        }
    }
    
    func inputDescription(description: String) {
        XCTContext.runActivity(named: "Заполняю поле description, равное \(description)") { _ in
            app.textFields["descriptionField"].tap()
            app.textFields["descriptionField"].typeText(description)
        }
    }
    
    
    func addSpent() {
        XCTContext.runActivity(named: "Жму кноку добавления траты") { _ in
            let addSpendButton = app.buttons["addSpendButton"]
            waitForElement(addSpendButton, message: "'Add' button did not appear.")
            addSpendButton.tap()
        }
    }
    
//    func swipeToAddSpendsButton() -> Self {
//        let screenCenter = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
//        let screenTop = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
//        screenCenter.press(forDuration: 0.01, thenDragTo: screenTop)
//        return self
//    }
    
    func pressAddSpend() {
        XCTContext.runActivity(named: "Нажимаю кнопку 'Add' для сохранения траты") { _ in
            let addButton = app.buttons["Add"]
            waitForElement(addButton, message: "'Add' button did not appear.")
            addButton.tap()
        }
    }
    
    
    
    func assertNewSpendIsShown(title: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTContext.runActivity(named: "Проверяю, что новая трата с заголовком '\(title)' отображается в списке") { _ in
            let spendTitle = app.firstMatch
                .scrollViews.firstMatch
                .staticTexts[title].firstMatch

            waitForElement(spendTitle, timeout: 2, message: "Spend with title '\(title)' was not found in the list.")

            XCTAssertTrue(spendTitle.exists, "Spend with title '\(title)' is not displayed in the list.", file: file, line: line)
        }
    }
}
