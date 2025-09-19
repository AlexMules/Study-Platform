package ro.platformaStudiu.student;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.stage.Stage;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ro.platformaStudiu.serviceClass.Activitate;
import ro.platformaStudiu.serviceClass.SqlConexiune;

public class TodayActivitiesPage {

    public TodayActivitiesPage(Stage primaryStage,SqlConexiune sql, int user_id, int student_id){
        Button inapoi = new Button("Înapoi");
        inapoi.setFont(new Font("Times New Roman", 14));
        inapoi.setOnAction(e -> {
            primaryStage.close();
            new StudentPage(primaryStage, sql, user_id);
        });

        ComboBox<String> zileComboBox = new ComboBox<>();
        zileComboBox.getItems().addAll("Luni", "Marți", "Miercuri", "Joi", "Vineri");
        zileComboBox.setPromptText("Alege o zi pentru care să îți vezi activitățile:");

        Label statusLabel = new Label();
        statusLabel.setFont(new Font("Times New Roman", 14));
        statusLabel.setTextFill(Color.BLUE);

        TableView<Activitate> table = new TableView<>();
        initializeTable(table);

        Button showButton = new Button("Arată activități");
        showButton.setFont(new Font("Times New Roman", 14));
        showButton.setOnAction(e -> {
            String ziua = zileComboBox.getValue();
            if (ziua != null) {
                loadData(table, ziua,student_id);
                statusLabel.setText("Încărcarea activităților a avut loc cu succes!");
                statusLabel.setTextFill(Color.GREEN);
            } else {
                statusLabel.setText("Selectați ziua");
                statusLabel.setTextFill(Color.RED);
            }
        });

        VBox layout = new VBox(10);
        layout.setPadding(new Insets(20));
        layout.getChildren().addAll(zileComboBox,statusLabel,table,showButton,inapoi);

        Scene scene = new Scene(layout, 1500, 600);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Vezi activitățile");
        primaryStage.show();
    }

    private void initializeTable(TableView<Activitate> table) {

        TableColumn<Activitate, String> materieCol = new TableColumn<>("Materie");
        materieCol.setCellValueFactory(cellData -> cellData.getValue().materieProperty());
        materieCol.setPrefWidth(600);

        TableColumn<Activitate, String> descriereCol = new TableColumn<>("Descriere Activitate");
        descriereCol.setCellValueFactory(cellData -> cellData.getValue().descriereProperty());
        descriereCol.setPrefWidth(250);

        TableColumn<Activitate, String> oraCol = new TableColumn<>("Ora");
        oraCol.setCellValueFactory(cellData -> cellData.getValue().oraProperty());
        oraCol.setPrefWidth(150);

        table.getColumns().addAll(materieCol,descriereCol, oraCol);
    }

    private void loadData(TableView<Activitate> table, String ziua,int id_student) {
        ObservableList<Activitate> data = FXCollections.observableArrayList();
        String query = "{CALL GetActivitatiStudent(?,?)}";

        try (PreparedStatement stmt = SqlConexiune.con.prepareStatement(query)) {
            stmt.setString(1, ziua);
            stmt.setInt(2, id_student);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    data.add(new Activitate(
                            rs.getString("Descriere_Activitate"),
                            rs.getString("Ora_Activitatii"),
                            rs.getString("Nume_Materie")
                    ));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        table.setItems(data);
    }

}
