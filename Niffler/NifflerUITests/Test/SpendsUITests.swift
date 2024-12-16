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


                // Arrange
                loginPage.launchAppWithoutLogin()
                
                //act
                regPage.tapCreateNewAccount()
                       .fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
                loginPage.logInInAlert()
                          .assertFieldUserNameEqual(userName: uniqueUserName)
                           .pressLoginButton()
                
                newSpendPage.assertIsAddSpendButtonShown()
                   .assertEmptySpendItem()
                   .addSpent()
                   .addNewCategory()
                   .inputNameCategory(nameCategory: "Еда")
                   .inputAmount(amount: "1000")
                   .inputDescription(description: "Бананы")
                   .pressAddSpend()
                
                // Assert
                profilePage.goToProfile()
                    .verifyCategory("Еда")
            }
        }

        func testDeletedCategoryIsNotShownInSpendScreen() throws {
            XCTContext.runActivity(named: "Тест: проверка, что удалённая категория не отображается на экране добавления новой траты") { _ in

                // Arrange
                loginPage.launchAppWithoutLogin()
                
                //act
                regPage.tapCreateNewAccount()
                       .fillRegForm(userName: uniqueUserName, password: uniquePassword, confirmPassword: uniquePassword)
                loginPage.logInInAlert()
                         .assertFieldUserNameEqual(userName: uniqueUserName)
                         .pressLoginButton()
                newSpendPage.assertIsAddSpendButtonShown()
                            .assertEmptySpendItem()
                            .addSpent()
                            .addNewCategory()
                            .inputNameCategory(nameCategory: "Еда")
                            .inputAmount(amount: "1000")
                            .inputDescription(description: "Бананы")
                            .pressAddSpend()
                
                profilePage.goToProfile()
                           .deleteCategory("Еда")
                           .closeProfile()
               
                // Assert
                newSpendPage.addSpent()
                             .verifyNewCategoryButtonIsVisibleAndTappable()
            }
        }
}

extension UUID {
    static var randomPart: String {
        UUID().uuidString.components(separatedBy: "-").first!
    }
}
