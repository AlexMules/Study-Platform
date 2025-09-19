package ro.platformaStudiu.student;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import ro.platformaStudiu.serviceClass.ActivitateInscriere;
import ro.platformaStudiu.serviceClass.Materie;
import ro.platformaStudiu.serviceClass.Service;
import ro.platformaStudiu.serviceClass.SqlConexiune;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivitatiSelectStudentPage {

    public ActivitatiSelectStudentPage(Stage primaryStage, SqlConexiune sql, int user_id, int student_id){

        Label statusLabel= new Label();
        statusLabel.setFont(new Font("Times New Roman", 14));
        statusLabel.setTextFill(Color.GREEN);

        Button inapoi = new Button("Înapoi");
        inapoi.setFont(new Font("Times New Roman", 14));
        inapoi.setOnAction(e -> {
            primaryStage.close();
            new StudentPage(primaryStage, sql, user_id);
        });

        ComboBox<Materie> comboBoxMaterii = new ComboBox<>();
        ComboBox<ActivitateInscriere> comboBoxActivitati = new ComboBox<>();
        List<Materie> materiiList= getMateriiInscris(student_id);
        comboBoxMaterii.getItems().addAll(materiiList);

        comboBoxMaterii.valueProperty().addListener((observable, oldValue, newValue) -> {
            if (newValue != null) {
                statusLabel.setText("Ai selectat materia: " + newValue.getNumeMaterie());
                statusLabel.setTextFill(Color.GREEN);
                comboBoxActivitati.getItems().clear();
                int id_prof = Service.getProfIdMaterie(student_id,newValue.getIdMaterie());

                List<ActivitateInscriere> activitatiList=getActivitati(id_prof,newValue.getIdMaterie());
                comboBoxActivitati.getItems().addAll(activitatiList);

            }
        });

        Button inscriereButton = getButton(student_id, comboBoxActivitati, statusLabel);

        VBox layout = new VBox(10);
        layout.setPadding(new Insets(20));
        layout.getChildren().addAll(comboBoxMaterii,comboBoxActivitati,statusLabel,inscriereButton, inapoi);

        Scene scene = new Scene(layout, 800, 500);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Înscriere Activități");
        primaryStage.show();
    }

    private Button getButton(int student_id, ComboBox<ActivitateInscriere> comboBoxActivitati, Label statusLabel) {
        Button inscriereButton = new Button("Înscriere");
        inscriereButton.setFont(new Font("Times New Roman", 14));
        inscriereButton.setOnAction(e -> {
            ActivitateInscriere selectedActivitate = comboBoxActivitati.getValue();
            if (selectedActivitate != null) {
                int idActivitate = selectedActivitate.getId_activitate();
                insertActivitateInBazaDeDate(statusLabel, idActivitate, student_id);
            } else {
                statusLabel.setText("Selectează o activitate!");
                statusLabel.setTextFill(Color.RED);
            }
        });
        return inscriereButton;
    }

    private List<Materie> getMateriiInscris(int student_id) {
        List<Materie> materii = new ArrayList<>();
        String query = "SELECT m.id_materii, m.nume_materii FROM catalog c INNER JOIN materii m " +
                       "ON c.id_materie_catalog = m.id_materii WHERE c.id_student_catalog = ?";

        try (PreparedStatement stmt = SqlConexiune.con.prepareStatement(query)) {
            stmt.setInt(1, student_id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                materii.add(new Materie(
                        rs.getInt("id_materii"),
                        rs.getString("nume_materii")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return materii;
    }

    private void insertActivitateInBazaDeDate(Label statusLabel,int idActivitate,int studentId) {
        String query = "CALL InscriereActivitate(?,?)";

        try (PreparedStatement stmt = SqlConexiune.con.prepareStatement(query)) {
            stmt.setInt(1, idActivitate);
            stmt.setInt(2, studentId);

            stmt.execute();
            statusLabel.setText("Inscrierea la activitate a avut loc cu succes");
            statusLabel.setTextFill(Color.GREEN);
        } catch (SQLException e) {
            statusLabel.setText("Eroare :" + e.getMessage());
            statusLabel.setTextFill(Color.RED);
            e.printStackTrace();
        }

    }

    public List<ActivitateInscriere> getActivitati(int profID, int materieID) {
        List<ActivitateInscriere> activitati = new ArrayList<>();
        String query = "{CALL SelectActivitatiProfesor(?, ?)}";

        try (CallableStatement stmt = SqlConexiune.con.prepareCall(query)) {

            stmt.setInt(1, profID);
            stmt.setInt(2, materieID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int idActivitate = rs.getInt("ActivitateID");
                String descriere = rs.getString("Descriere");
                String ziua = rs.getString("Ziua");
                String ora = rs.getString("Ora");

                ActivitateInscriere activitate = new ActivitateInscriere(ora,ziua,idActivitate,descriere);
                activitati.add(activitate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return activitati;
    }

}

