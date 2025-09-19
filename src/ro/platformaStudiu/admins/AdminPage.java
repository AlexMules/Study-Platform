package ro.platformaStudiu.admins;

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


public class AdminPage {

    public AdminPage(Stage primaryStage, SqlConexiune sql, int rol_id, int user_id) {
        GridPane grid = new GridPane();
        grid.setPadding(new Insets(20));
        grid.setHgap(10);
        grid.setVgap(10);

        Label welcomeLabel = new Label("Bine ai venit!");
        welcomeLabel.setFont(new Font("Times New Roman", 20));
        welcomeLabel.setTextFill(Color.BLUE);

        Button vizualizareDateButon = new Button("Vizualizare Date");
        Button modificaUtilizator = new Button("Modifică datele utilizatorilor");
        Button cautaNumeButon = new Button("Caută utilizator după nume");
        Button cautaTipButon = new Button("Caută utilizator după tip");
        Button adaugaUtilizatorButon = new Button("Adaugă utilizator nou");
        Button cautaCursuriButon = new Button("Caută cursuri");
        Button deautentificareButton = new Button("Deautentificare");

        Label messageLabel = new Label();
        messageLabel.setFont(new Font("Times New Roman", 18));
        vizualizareDateButon.setFont(new Font("Times New Roman", 18));
        modificaUtilizator.setFont(new Font("Times New Roman", 18));
        cautaCursuriButon.setFont(new Font("Times New Roman", 18));
        cautaNumeButon.setFont(new Font("Times New Roman", 18));
        cautaTipButon.setFont(new Font("Times New Roman", 18));
        adaugaUtilizatorButon.setFont(new Font("Times New Roman", 18));
        deautentificareButton.setFont(new Font("Times New Roman", 18));

        vizualizareDateButon.setPrefWidth(250);
        vizualizareDateButon.setPrefHeight(20);
        modificaUtilizator.setPrefWidth(250);
        modificaUtilizator.setPrefHeight(20);
        cautaCursuriButon.setPrefWidth(250);
        cautaCursuriButon.setPrefHeight(20);
        cautaNumeButon.setPrefWidth(250);
        cautaNumeButon.setPrefHeight(20);
        cautaTipButon.setPrefWidth(250);
        cautaTipButon.setPrefHeight(20);
        adaugaUtilizatorButon.setPrefWidth(250);
        adaugaUtilizatorButon.setPrefHeight(20);
        deautentificareButton.setPrefWidth(250);
        deautentificareButton.setPrefHeight(20);

        grid.add(welcomeLabel, 0, 0);
        grid.add(vizualizareDateButon, 0, 1);
        grid.add(modificaUtilizator, 0, 2);
        grid.add(cautaTipButon, 0, 3);
        grid.add(adaugaUtilizatorButon, 0, 5);
        grid.add(cautaNumeButon, 0, 4);
        grid.add(cautaCursuriButon, 0, 6);
        grid.add(deautentificareButton, 0, 7);
        grid.add(messageLabel, 0, 8);

        deautentificareButton.setOnAction(e -> {
            primaryStage.close();
            new LoginPage(primaryStage, sql);
        });

        vizualizareDateButon.setOnAction( e ->{
            primaryStage.close();
            new VizualizareDate(primaryStage, sql, rol_id, user_id);
        });

        cautaNumeButon.setOnAction(e->{
            primaryStage.close();
            new CautaUtilizatorNumePage(primaryStage,sql, rol_id, user_id);
        });

        cautaTipButon.setOnAction(e->{
            primaryStage.close();
            new CautaUtilizatorTipPage(primaryStage, sql, rol_id, user_id);
        });
        cautaCursuriButon.setOnAction(e->{
            primaryStage.close();
            new CautaCursuriPage(primaryStage,sql, rol_id, user_id);
        });

        modificaUtilizator.setOnAction(e->{
            primaryStage.close();
            new ModificaUtilizatorPage(primaryStage, sql, rol_id, user_id);
        });
        adaugaUtilizatorButon.setOnAction(e->{
            primaryStage.close();
            new AdaugaUtilizatorPage(primaryStage, sql, rol_id, user_id);
        });

        Scene scene = new Scene(grid, 600, 700);
        primaryStage.setTitle("Admin Page");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
}

