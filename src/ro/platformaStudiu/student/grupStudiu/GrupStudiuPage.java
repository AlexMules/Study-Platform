package ro.platformaStudiu.student.grupStudiu;

import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import ro.platformaStudiu.serviceClass.SqlConexiune;
import ro.platformaStudiu.student.StudentPage;

public class GrupStudiuPage {

    public GrupStudiuPage(Stage primaryStage, SqlConexiune sql, int user_id, int student_id){
        GridPane grid=new GridPane();
        grid.setPadding(new Insets(20));
        grid.setHgap(10);
        grid.setVgap(10);

        Button inscriere= new Button("Înscriere grup studiu");
        inscriere.setFont(new Font("Times New Roman", 14));
        Button veziGrupuri= new Button("Vezi în ce grupuri ești înscris");
        veziGrupuri.setFont(new Font("Times New Roman", 14));
        Button veziStudenti=new Button("Detalii grupuri");
        veziStudenti.setFont(new Font("Times New Roman", 14));
        Button inapoi=new Button("Înapoi");
        inapoi.setFont(new Font("Times New Roman", 14));

        inapoi.setOnAction(e->{
            primaryStage.close();
            new StudentPage(primaryStage, sql, user_id);
        });

        grid.add(inscriere,0,1);
        grid.add(inapoi,0,4);
        grid.add(veziGrupuri,0,2);
        grid.add(veziStudenti,0,3);

        inscriere.setOnAction(e->{
            primaryStage.close();
            new InscriereGrupStudiuPage(primaryStage,sql,user_id,student_id);
        });

        veziGrupuri.setOnAction(e->{
            primaryStage.close();
            new VizualizareGrupuri(primaryStage,sql,user_id,student_id);
        });
        veziStudenti.setOnAction(e->{
            primaryStage.close();
            new ManagementGrupuri(primaryStage,sql,user_id,student_id);
        });

        Scene scene = new Scene(grid, 800, 500);
        primaryStage.setTitle("Grupuri de Studiu");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
}
