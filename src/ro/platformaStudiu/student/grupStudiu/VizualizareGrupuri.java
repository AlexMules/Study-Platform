package ro.platformaStudiu.student.grupStudiu;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import ro.platformaStudiu.serviceClass.SqlConexiune;

import java.sql.*;


public class VizualizareGrupuri {

    public VizualizareGrupuri(Stage primaryStage, SqlConexiune sql, int userID, int studentID){

        VBox layout = new VBox(10);
        layout.setPadding(new Insets(20));
        loadGrupuriStudiu(studentID,layout);
        Button inapoi=new Button("Înapoi");
        inapoi.setFont(new Font("Times New Roman", 14));
        inapoi.setOnAction(e->{
            primaryStage.close();
            new GrupStudiuPage(primaryStage,sql,userID,studentID);
        });
        layout.getChildren().add(inapoi);


        Scene scene = new Scene(layout, 800, 500);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Grupuri de Studiu");
        primaryStage.show();

    }

    private void loadGrupuriStudiu(int studentID, VBox layout){
        String query = "{CALL AfisareGrupuriDeStudiu(?)}";

        try(PreparedStatement stmt = SqlConexiune.con.prepareStatement(query)){
            stmt.setInt(1,studentID);
            ResultSet rs=stmt.executeQuery();
            while (rs.next()){
                int idGrup = rs.getInt("ID_grup_studiu");
                String materie = rs.getString("Materie");
                Label label = new Label(idGrup + " - Materie: " + materie);
                label.setFont(new Font("Times New Roman",16));
                layout.getChildren().add(label);
            }


        } catch (Exception e) {
            e.printStackTrace();
            layout.getChildren().add(new Label("Eroare la încărcarea datelor."));
        }
    }
}
