//
//  ProfilePage.swift
//  NifflerUITests
//
//  Created by Олег Малышев on 13.12.2024.
//

import XCTest

final class ProfilePage: BasePage {

    
    func goToProfile() -> Self{
        XCTContext.runActivity(named: "Перехожу на экран профиля") { _ in
            openMenu()
            tapProfileButton()
            return self
        }
    }

    private func openMenu() -> Self {
        XCTContext.runActivity(named: "Открываю бургер-меню") { _ in
            let burgerMenu = app.images["ic_menu"]
            waitForElement(burgerMenu, message: "Burger menu button did not appear on the screen.")
            burgerMenu.tap()
            return self
        }
    }

    private func tapProfileButton() -> Self {
        XCTContext.runActivity(named: "Нажимаю кнопку 'Profile'") { _ in
            let profileButton = app.buttons["Profile"]
            waitForElement(profileButton, message: "Profile button did not appear on the screen.")
            XCTAssertTrue(profileButton.isHittable, "Profile button is not tappable.")
            profileButton.tap()
            return self
        }
    }

    @discardableResult
    func verifyCategory(_ categoryName: String, timeout: TimeInterval = 2, file: StaticString = #file, line: UInt = #line) -> Self {
        XCTContext.runActivity(named: "Проверяю наличие категории в списке: \(categoryName)") { _ in
            let category = app.staticTexts[categoryName]
            waitForElement(category, timeout: timeout, message: "The '\(categoryName)' category did not appear in the list.", file: file, line: line)
            XCTAssertTrue(category.exists, "The category '\(categoryName)' does not exist in the list.", file: file, line: line)
            return self
        }
    }

    func deleteCategory(_ categoryName: String) -> Self{
        XCTContext.runActivity(named: "Удаляю категорию '\(categoryName)'") { _ in
            let categoryCell = app.cells.containing(.staticText, identifier: categoryName).firstMatch
            waitForElement(categoryCell, message: "The category '\(categoryName)' did not appear on the screen.")

            XCTContext.runActivity(named: "Свайпаю влево для удаления категории '\(categoryName)'") { _ in
                categoryCell.swipeLeft()
            }

            let deleteButton = app.buttons["Delete"]
            waitForElement(deleteButton, message: "The 'Delete' button did not appear after swiping.")

            XCTContext.runActivity(named: "Нажимаю кнопку удаления 'Delete'") { _ in
                XCTAssertTrue(deleteButton.isHittable, "The 'Delete' button is not tappable.")
                deleteButton.tap()
               
            }
            return self
        }
    }
    
    @discardableResult
    func closeProfile() -> Self{
        XCTContext.runActivity(named: "Нажимаем на элемент закрытия профиля") { _ in
            let buttonClose = app.buttons["Close"]
            waitForElement(buttonClose, message: "Не дождались кнопки закрытия профиля")
            buttonClose.tap()
            return self
        }
    }
}
