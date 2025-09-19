package ro.platformaStudiu.serviceClass;

import javafx.geometry.HPos;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;
import javafx.scene.text.Font;
import javafx.scene.paint.Color;
import ro.platformaStudiu.admins.AdminPage;
import ro.platformaStudiu.admins.Super.SuperAdminPage;
import ro.platformaStudiu.professor.ProfessorPage;
import ro.platformaStudiu.student.StudentPage;

public class LoginPage {

    public LoginPage(Stage primaryStage, SqlConexiune sql){
        GridPane grid = new GridPane();
        grid.setPadding(new Insets(20));
        grid.setHgap(10);
        grid.setVgap(10);

        Label email = new Label("Email");
        TextField emailField = new TextField();
        Label password = new Label("Parola");
        PasswordField passwordField = new PasswordField();

        Label subtitle = new Label("Introduceți datele de logare:");
        subtitle.setFont(new Font("Times New Roman", 18));
        subtitle.setTextFill(Color.BLUE);

        Button loginButton = new Button("Login");
        Label messageLabel = new Label();

        email.setFont(new Font("Times New Roman", 18));
        password.setFont(new Font("Times New Roman", 18));
        loginButton.setFont(new Font("Times New Roman", 18));
        messageLabel.setFont(new Font("Times New Roman", 18));
        emailField.setFont(new Font("Times New Roman", 18));
        passwordField.setFont(new Font("Times New Roman", 18));

        emailField.setPrefWidth(250);
        passwordField.setPrefWidth(250);

        GridPane.setHalignment(email, HPos.CENTER);
        GridPane.setHalignment(password, HPos.CENTER);
        GridPane.setHalignment(loginButton, HPos.CENTER);
        GridPane.setHalignment(messageLabel, HPos.CENTER);

        grid.setAlignment(javafx.geometry.Pos.CENTER);

        grid.add(subtitle, 0, 1, 2, 1);
        grid.add(email, 0, 2);
        grid.add(emailField, 1, 2);
        grid.add(password, 0, 3);
        grid.add(passwordField, 1, 3);
        grid.add(loginButton, 1, 4);
        grid.add(messageLabel, 1, 5);

        email.setTextFill(Color.BLUE);
        password.setTextFill(Color.BLUE);

        loginButton.setOnAction(e ->{
            User user = sql.validateUser(emailField.getText(), passwordField.getText());
            if(user != null){
                messageLabel.setText("Login reusit!");
                messageLabel.setTextFill(Color.GREEN);
                if(user.getRolId() == 3) {
                    new StudentPage(primaryStage, sql, user.getUserId());
                }
                else if(user.getRolId() == 2){
                    new ProfessorPage(primaryStage, sql, user.getRolId(), user.getUserId());
                }
                else if (user.getRolId() == 1){
                    new AdminPage(primaryStage, sql, user.getRolId(),user.getUserId());
                }
                else if (user.getRolId() == 0){
                    new SuperAdminPage(primaryStage, sql, user.getRolId(),user.getUserId());
                }
            }
            else {
                messageLabel.setText("Login eșuat! Verifică datele!");
                messageLabel.setTextFill(Color.RED);
            }
        });

        Scene scene = new Scene(grid, 500, 600);
        primaryStage.setTitle("Login");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

}
