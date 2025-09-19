package ro.platformaStudiu.professor;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import ro.platformaStudiu.serviceClass.LoginPage;
import ro.platformaStudiu.serviceClass.SqlConexiune;
import ro.platformaStudiu.serviceClass.VizualizareDate;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static ro.platformaStudiu.serviceClass.SqlConexiune.con;

public class ProfessorPage {

     public ProfessorPage(Stage primaryStage, SqlConexiune sql, int rol_id, int user_id) {
         GridPane grid = new GridPane();
         grid.setPadding(new Insets(20));
         grid.setHgap(10);
         grid.setVgap(10);

         Label welcomeLabel = new Label("Bine ai venit!");
         welcomeLabel.setFont(new Font("Times New Roman", 20));
         welcomeLabel.setTextFill(Color.BLUE);

         Button vizualizareDateButon = new Button("Vizualizare Date");
         Button catalog = new Button("Vizualizare catalog");
         Button deautentificareButton = new Button("Deautentificare ");
         Button impartire = new Button("Împărțirea procentuală a activităților");
         Button programare = new Button("Programare activităti");

         vizualizareDateButon.setFont(new Font("Times New Roman", 16));
         catalog.setFont(new Font("Times New Roman", 16));
         deautentificareButton.setFont(new Font("Times New Roman", 16));
         programare.setFont(new Font("Times New Roman", 16));
         impartire.setFont(new Font("Times New Roman", 16));
         deautentificareButton.setFont(new Font("Times New Roman", 16));

         grid.add(welcomeLabel, 0, 0, 2, 1);
         grid.add(vizualizareDateButon, 0, 1);
         grid.add(catalog, 0, 2);
         grid.add(programare, 0, 3);
         grid.add(impartire, 0, 4);
         grid.add(deautentificareButton, 0, 5);

         deautentificareButton.setOnAction(e -> {
             primaryStage.close();
             new LoginPage(primaryStage, sql);
         });

         vizualizareDateButon.setOnAction(e -> {
             primaryStage.close();
             new VizualizareDate(primaryStage, sql, rol_id, user_id);
         });

         programare.setOnAction(e ->{
             primaryStage.close();
             int profesorID = getProfessorId(user_id);
             new ProgramareActivitatiProfesorPage(primaryStage, sql, user_id,profesorID);
         });
         impartire.setOnAction(e->{
             primaryStage.close();
             int profesorID = getProfessorId(user_id);
             new SetareProcentProfPage(primaryStage, sql, user_id, profesorID);
         });
         catalog.setOnAction(e->{
             primaryStage.close();
             int profesorID = getProfessorId(user_id);
             new CatalogProfPage(primaryStage, sql, user_id, profesorID);
         });

         Scene scene = new Scene(grid, 800, 500);
         primaryStage.setTitle("Professor Page");
         primaryStage.setScene(scene);
         primaryStage.show();
     }

    private int getProfessorId(int userId) {
        String query = "SELECT profesor_id FROM profesori WHERE profesor_id_user = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("profesor_id");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }
}
