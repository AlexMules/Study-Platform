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
import ro.platformaStudiu.serviceClass.Materie;
import ro.platformaStudiu.serviceClass.Service;
import ro.platformaStudiu.serviceClass.SqlConexiune;
import ro.platformaStudiu.serviceClass.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CautaCursuriPage {

    public CautaCursuriPage(Stage primaryStage,SqlConexiune sql, int rolID, int userID){
        Label statusLabel= new Label();
        statusLabel.setFont(new Font(14));
        statusLabel.setTextFill(Color.BLUE);

        VBox layout = new VBox(10);
        layout.setPadding(new Insets(20));

        Button inapoi=new Button("Înapoi");
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

        List<Materie> lista= Service.getMaterii();
        ComboBox<Materie> comboBoxMaterii = new ComboBox<>();
        comboBoxMaterii.getItems().addAll(lista);

        TextArea resultArea = new TextArea();
        resultArea.setEditable(false);
        resultArea.setFont(new Font("Times New Roman", 14));

        Button cautaProfi = getProfesoriButton(comboBoxMaterii, resultArea);
        Button cautaStudenti = getStudentiButton(resultArea, comboBoxMaterii);

        layout.getChildren().addAll(comboBoxMaterii, statusLabel, cautaProfi, resultArea,cautaStudenti,inapoi);

        Scene scene = new Scene(layout, 800, 500);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Căutare Utilizatori");
        primaryStage.show();
    }

    private Button getStudentiButton(TextArea resultArea, ComboBox<Materie> comboBoxMaterii) {
        Button cautaStudenti = new Button("Afișează studenții înscriși la curs");
        cautaStudenti.setFont(new Font("Times New Roman", 14));
        cautaStudenti.setOnAction(e->{
            resultArea.clear();
            Materie materie= comboBoxMaterii.getValue();
            try {
                List<User> studenti = cautaStudenti(materie.getIdMaterie());
                if(studenti.isEmpty()){
                    resultArea.setText("Nu au fost găsiți utilizatori care să corespundă criteriilor.");
                } else {
                    resultArea.setText(studenti.stream().map(User::showUser).collect(Collectors.joining("\n")));
                }
            } catch (SQLException ex) {
                resultArea.setText("Eroare la interogarea bazei de date: " + ex.getMessage());
            }

        });
        return cautaStudenti;
    }

    private Button getProfesoriButton(ComboBox<Materie> comboBoxMaterii, TextArea resultArea) {
        Button cautaProfi=new Button("Afiseaza profesorii cursului: ");
        cautaProfi.setFont(new Font("Times New Roman", 14));
        cautaProfi.setOnAction(e->{
            Materie materie = comboBoxMaterii.getValue();
            try {
                List<User> profi = cautaProfesori(materie.getIdMaterie());
                if(profi.isEmpty()){
                    resultArea.setText("Nu au fost găsiți utilizatori care să corespundă criteriilor.");
                } else {
                resultArea.setText(profi.stream().map(User::showUser).collect(Collectors.joining("\n")));
                }
            } catch (SQLException ex) {
                resultArea.setText("Eroare la interogarea bazei de date: " + ex.getMessage());
            }
        });
        return cautaProfi;
    }

    private List<User> cautaProfesori(int materie_id) throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "{CALL VeziProfesoriMaterie(?)}";

        try (PreparedStatement statement = SqlConexiune.con.prepareStatement(query)) {
            statement.setInt(1,materie_id );

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    User user = new User(
                            resultSet.getString("nume"),
                            resultSet.getString("prenume"),
                            resultSet.getString("email")
                    );
                    users.add(user);
                }
            }
        }
        return users;
    }

    private List<User> cautaStudenti(int materie_id) throws SQLException {
        List<User> users = new ArrayList<>();
        String query = "{CALL VeziStudentiMaterie(?)}";

        try (PreparedStatement statement = SqlConexiune.con.prepareStatement(query)) {
            statement.setInt(1,materie_id );

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    User user = new User(
                            resultSet.getString("nume"),
                            resultSet.getString("prenume"),
                            resultSet.getString("email")
                    );
                    users.add(user);
                }
            }
        }
        return users;
    }

}
