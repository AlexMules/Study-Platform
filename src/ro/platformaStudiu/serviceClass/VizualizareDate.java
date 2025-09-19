package ro.platformaStudiu.serviceClass;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import javafx.scene.paint.Color;
import ro.platformaStudiu.admins.AdminPage;
import ro.platformaStudiu.professor.ProfessorPage;
import ro.platformaStudiu.student.StudentPage;

import java.sql.*;

public class VizualizareDate {

    public VizualizareDate(Stage primaryStage, SqlConexiune sql, int rol_id, int user_id) {

        if (rol_id == 3) { //student
            Label headerLabel = new Label("Datele Studentului");
            headerLabel.setFont(new Font("Times New Roman", 30));
            headerLabel.setTextFill(Color.BLUE);

            // VBox pentru datele studentului
            VBox studentDataBox = new VBox();
            studentDataBox.setSpacing(10);
            studentDataBox.setPadding(new Insets(10));

            // incarcare date student
            loadStudentData(studentDataBox, user_id);

            Button inapoi = new Button("Înapoi");
            inapoi.setFont(new Font(18));
            inapoi.setOnAction(e -> {
                primaryStage.close();
                new StudentPage(primaryStage, sql, user_id);
            });

            VBox mainLayout = new VBox();
            mainLayout.setPadding(new Insets(10));
            mainLayout.setSpacing(20);
            mainLayout.getChildren().addAll(headerLabel, studentDataBox, inapoi);

            Scene scene = new Scene(mainLayout, 1200, 700);
            primaryStage.setScene(scene);
            primaryStage.setTitle("Detalii Student");
            primaryStage.show();
        }
        else if (rol_id == 2){ //profesor
            Label headerLabel = new Label("Datele Profesorului");
            headerLabel.setFont(new Font("Times New Roman", 30));
            headerLabel.setTextFill(Color.BLUE);

            // VBox pentru datele profesorului
            VBox professorDataBox = new VBox();
            professorDataBox.setSpacing(10);
            professorDataBox.setPadding(new Insets(10));

            // incarcare date profesor
            loadProfessorData(professorDataBox, user_id);

            Button inapoi = new Button("Înapoi");
            inapoi.setFont(new Font(18));
            inapoi.setOnAction(e -> {
                primaryStage.close();
                new ProfessorPage(primaryStage, sql, rol_id, user_id);
            });

            VBox mainLayout = new VBox();
            mainLayout.setPadding(new Insets(10));
            mainLayout.setSpacing(20);
            mainLayout.getChildren().addAll(headerLabel, professorDataBox, inapoi);

            Scene scene = new Scene(mainLayout, 1200, 700);
            primaryStage.setScene(scene);
            primaryStage.setTitle("Detalii Profesor");
            primaryStage.show();
        }
        else if (rol_id==1 || rol_id==0){ //admin sau super-admin
            Label headerLabel = new Label("Datele Adminului");
            headerLabel.setFont(new Font("Times New Roman", 30));
            headerLabel.setTextFill(Color.BLUE);

            // VBox pentru datele adminului
            VBox AdminDataBox = new VBox();
            AdminDataBox.setSpacing(10);
            AdminDataBox.setPadding(new Insets(10));

            // incarcare date admin
            loadAdminData(AdminDataBox, user_id);

            Button inapoi = new Button("Înapoi");
            inapoi.setFont(new Font(18));
            inapoi.setOnAction(e -> {
                primaryStage.close();
                new AdminPage(primaryStage, sql, rol_id, user_id);
            });

            VBox mainLayout = new VBox();
            mainLayout.setPadding(new Insets(10));
            mainLayout.setSpacing(20);
            mainLayout.getChildren().addAll(headerLabel, AdminDataBox, inapoi);

            Scene scene = new Scene(mainLayout, 1200, 700);
            primaryStage.setScene(scene);
            primaryStage.setTitle("Detalii Admin");
            primaryStage.show();
        }
    }

    private void loadStudentData(VBox studentDataBox, int userId) {
        String query = "{CALL GetStudentData(?)}";

        try {
            PreparedStatement stmt = SqlConexiune.con.prepareStatement(query);
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    loadPersonalData(studentDataBox, rs);
                    addDetail(studentDataBox, "An de Studiu: ", String.valueOf(rs.getInt("an_de_studiu")));
                    addDetail(studentDataBox, "Număr Ore Sustinute: ", String.valueOf(rs.getInt("numar_ore_sustinute")));
                } else {
                    Text noDataText = new Text("Nu s-au găsit date pentru acest student.");
                    noDataText.setFont(new Font("Arial", 20));
                    noDataText.setFill(Color.RED);
                    studentDataBox.getChildren().add(noDataText);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void loadPersonalData(VBox studentDataBox, ResultSet rs) throws SQLException {
        addDetail(studentDataBox, "Nume: ", rs.getString("nume"));
        addDetail(studentDataBox, "Prenume: ", rs.getString("prenume"));
        addDetail(studentDataBox, "CNP: ", rs.getString("CNP"));
        addDetail(studentDataBox, "Număr Telefon: ", rs.getString("Numar_Telefon"));
        addDetail(studentDataBox, "Adresa: ", rs.getString("Adresa"));
        addDetail(studentDataBox, "IBAN: ", rs.getString("IBAN"));
        addDetail(studentDataBox, "Email: ", rs.getString("email"));
        addDetail(studentDataBox, "Nr. Contract: ", String.valueOf(rs.getInt("Nr_Contract")));
    }

    private void loadProfessorData(VBox professorDataBox, int userId) {
        String query = "{CALL GetProfesorData(?)}";

        try {
            PreparedStatement stmt = SqlConexiune.con.prepareStatement(query);
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    loadPersonalData(professorDataBox, rs);
                    addDetail(professorDataBox, "Materie predata: ", String.valueOf(rs.getString("Materie_predata")));
                    addDetail(professorDataBox, "Departament: ", String.valueOf(rs.getString("departament")));
                    addDetail(professorDataBox, "Numar minim ore: ", String.valueOf(rs.getInt("Nr_minim_ore")));
                    addDetail(professorDataBox, "Numar maxim ore: ", String.valueOf(rs.getInt("Nr_maxim_ore")));
                    addDetail(professorDataBox, "Numar curent ore: ", String.valueOf(rs.getInt("Nr_curent_ore")));
                    addDetail(professorDataBox, "Numar maxim studenti: ", String.valueOf(rs.getInt("Nr_maxim_studenti")));
                    addDetail(professorDataBox, "Numar curent studenti: ", String.valueOf(rs.getInt("Nr_curent_studenti")));
                } else {
                    Text noDataText = new Text("Nu s-au găsit date pentru acest profesor!");
                    noDataText.setFont(new Font("Arial", 20));
                    noDataText.setFill(Color.RED);
                    professorDataBox.getChildren().add(noDataText);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void loadAdminData(VBox AdminDataBox, int userId) {
        String query = "{CALL GetAdminData(?)}";

        try {
            PreparedStatement stmt = SqlConexiune.con.prepareStatement(query);
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    loadPersonalData(AdminDataBox, rs);
                    addDetail(AdminDataBox, "Rol: ", String.valueOf(rs.getString("Rol")));
                } else {
                    Text noDataText = new Text("Nu s-au găsit date pentru acest student.");
                    noDataText.setFont(new Font("Arial", 20));
                    noDataText.setFill(Color.RED);
                    AdminDataBox.getChildren().add(noDataText);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void addDetail(VBox box, String label, String value) {
        Text detail = new Text(label + value);
        detail.setFont(new Font("Times New Roman", 18));
        detail.setFill(Color.BLACK);
        box.getChildren().add(detail);
    }
}