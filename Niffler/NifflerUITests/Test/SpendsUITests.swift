import XCTest

final class SpendsUITests: TestCase {
    let uniqueUserName = "user\(Int(Date().timeIntervalSince1970))"
    let uniquePassword = "123456"
    
    func test_whenAddSpent_shouldShowSpendInList() {
        launchAppWithoutLogin()
        
        // Arrange
        loginPage
            .input(login: "stage", password: "12345")
        
        // Act
        spendsPage
            .waitSpendsScreen()
            .addSpent()
        
        let title = UUID.randomPart
        newSpendPage
            .inputSpent(title: title)
        
        // Assert
        spendsPage
            .assertNewSpendIsShown(title: title)
    }
    
    
    func testVerifyCategoryInProfileAfterAddingNewSpend() throws {
            XCTContext.runActivity(named: "Тест: проверка отображения новой категории в профиле после добавления траты") { _ in
                let app = XCUIApplication()
                let loginPage = LoginPage(app: app)
                let regPage = RegPage(app: app)
                let newSpendsPage = NewSpendPage(app: app)
                let profilePage = ProfilePage(app: app)


                // Arrange
                loginPage.launchAppWithoutLogin()
                
                //act
                regPage.tapCreateNewAccount()
                regPage.fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
                loginPage.logInInAlert()
                loginPage.assertFieldUserNameEqual(userName: uniqueUserName)
                loginPage.pressLoginButton()
                newSpendsPage.assertIsAddSpendButtonShown()
                newSpendsPage.assertEmptySpendItem()
                newSpendsPage.addSpent()
                newSpendsPage.addNewCategory()
                newSpendsPage.inputNameCategory(nameCategory: "Еда")
                newSpendsPage.inputAmount(amount: "1000")
                newSpendsPage.inputDescription(description: "Бананы")
                newSpendsPage.pressAddSpend()
                profilePage.goToProfile()

                // Assert
                profilePage.verifyCategory("Еда")
            }
        }

        func testDeletedCategoryIsNotShownInSpendScreen() throws {
            XCTContext.runActivity(named: "Тест: проверка, что удалённая категория не отображается на экране добавления новой траты") { _ in
                let app = XCUIApplication()
                let loginPage = LoginPage(app: app)
                let regPage = RegPage(app: app)
                let newSpendsPage = NewSpendPage(app: app)
                let profilePage = ProfilePage(app: app)

                // Arrange
                loginPage.launchAppWithoutLogin()
                
                //act
                regPage.tapCreateNewAccount()
                regPage.fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
                loginPage.logInInAlert()
                loginPage.assertFieldUserNameEqual(userName: uniqueUserName)
                loginPage.pressLoginButton()
                newSpendsPage.assertIsAddSpendButtonShown()
                newSpendsPage.assertEmptySpendItem()
                newSpendsPage.addSpent()
                newSpendsPage.addNewCategory()
                newSpendsPage.inputNameCategory(nameCategory: "Еда")
                newSpendsPage.inputAmount(amount: "1000")
                newSpendsPage.inputDescription(description: "Бананы")
                newSpendsPage.pressAddSpend()
                profilePage.goToProfile()
                profilePage.deleteCategory("Еда")
                profilePage.closeProfile()
                newSpendsPage.addSpent()

                // Assert
                newSpendsPage.verifyNewCategoryButtonIsVisibleAndTappable()
            }
        }
}

extension UUID {
    static var randomPart: String {
        UUID().uuidString.components(separatedBy: "-").first!
    }
}
