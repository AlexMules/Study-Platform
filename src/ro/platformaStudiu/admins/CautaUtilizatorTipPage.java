package ro.platformaStudiu.admins;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.scene.text.Font;
import javafx.scene.paint.Color;
import ro.platformaStudiu.admins.Super.SuperAdminPage;
import ro.platformaStudiu.serviceClass.Roluri;
import ro.platformaStudiu.serviceClass.Service;
import ro.platformaStudiu.serviceClass.SqlConexiune;
import ro.platformaStudiu.serviceClass.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static ro.platformaStudiu.serviceClass.SqlConexiune.con;

public class CautaUtilizatorTipPage {

    public CautaUtilizatorTipPage(Stage primaryStage, SqlConexiune sql, int rolID, int userID){
        Label statusLabel = new Label();
        statusLabel.setFont(new Font(14));
        statusLabel.setTextFill(Color.BLUE);

        ComboBox<Roluri> comboBoxRoluri = new ComboBox<>();
        List<Roluri> roluri= Service.getRoluriInscris();
        comboBoxRoluri.getItems().addAll(roluri);

        Button inapoi = new Button("Înapoi");
        inapoi.setFont(new Font("Times New Roman", 14));
        inapoi.setOnAction(e->{
            primaryStage.close();
            if(rolID == 0) {
                new SuperAdminPage(primaryStage, sql, rolID, userID);
            }
            else {
                new AdminPage(primaryStage, sql, rolID, userID);
            }
        });

        TextArea resultArea = new TextArea();
        resultArea.setEditable(false);
        resultArea.setFont(new Font("Times New Roman", 14));

        Button searchUsersButton = getButton(comboBoxRoluri, resultArea);

        VBox layout = new VBox(10);
        layout.setPadding(new Insets(20));
        layout.getChildren().addAll(comboBoxRoluri, statusLabel,searchUsersButton,resultArea, inapoi);

        Scene scene = new Scene(layout, 1000, 600);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Căutare Utilizatori");
        primaryStage.show();
    }

    private Button getButton(ComboBox<Roluri> comboBoxRoluri, TextArea resultArea) {
        Button searchUsersButton = new Button("Caută");
        searchUsersButton.setFont(new Font("Times New Roman", 14));
        searchUsersButton.setOnAction(event -> {
            Roluri search = comboBoxRoluri.getValue();
            try {
                List<User> users = cautaUtilizatori(search.getIdRol());
                if (users.isEmpty()) {
                    resultArea.setText("Nu au fost găsiți utilizatori care să corespundă criteriilor.");
                } else {
                    resultArea.setText(users.stream().map(User::toString).collect(Collectors.joining("\n")));
                }
            } catch (SQLException e) {
                resultArea.setText("Eroare la interogarea bazei de date: " + e.getMessage());
            }
        });
        return searchUsersButton;
    }

    private List<User> cautaUtilizatori(int rol_id) throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "SELECT user_id, CNP, nume, prenume, NumarTelefon, Adresa, IBAN, email, Nr_contract, Rol_id, " +
                "parola FROM utilizatori WHERE Rol_id=?";

        try (PreparedStatement statement = con.prepareStatement(query)) {
            statement.setInt(1,rol_id );
            generateResultSet(users, statement);
        }
        return users;
    }

    static void generateResultSet(List<User> users, PreparedStatement statement) throws SQLException {
        try (ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                User user = new User(
                        resultSet.getInt("Rol_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getString("nume"),
                        resultSet.getString("prenume"),
                        resultSet.getString("CNP"),
                        resultSet.getString("NumarTelefon"),
                        resultSet.getString("Adresa"),
                        resultSet.getString("IBAN"),
                        resultSet.getString("email"),
                        resultSet.getInt("Nr_contract"),
                        resultSet.getString("parola")
                );
                users.add(user);
            }
        }
    }
}
