package ro.platformaStudiu.serviceClass;

import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

public class StudentProf {
    private final SimpleIntegerProperty idStudent;
    private final SimpleStringProperty nume;
    private final SimpleStringProperty prenume;
    private final SimpleDoubleProperty notaCurs;
    private final SimpleDoubleProperty notaSeminar;
    private final SimpleDoubleProperty notaLaborator;

    public StudentProf(int idStudent, String nume, String prenume, double notaCurs, double notaSeminar, double notaLaborator) {
        this.idStudent = new SimpleIntegerProperty(idStudent);
        this.nume = new SimpleStringProperty(nume);
        this.prenume = new SimpleStringProperty(prenume);
        this.notaCurs = new SimpleDoubleProperty(notaCurs);
        this.notaSeminar = new SimpleDoubleProperty(notaSeminar);
        this.notaLaborator = new SimpleDoubleProperty(notaLaborator);
    }

    public int getIdStudent() {
        return idStudent.get();
    }

    public String getNume() {
        return nume.get();
    }

    public String getPrenume() {
        return prenume.get();
    }

    public double getNotaCurs() {
        return notaCurs.get();
    }

    public void setNotaCurs(double notaCurs) {
        this.notaCurs.set(notaCurs);
    }

    public double getNotaSeminar() {
        return notaSeminar.get();
    }

    public void setNotaSeminar(double notaSeminar) {
        this.notaSeminar.set(notaSeminar);
    }

    public double getNotaLaborator() {
        return notaLaborator.get();
    }

    public void setNotaLaborator(double notaLaborator) {
        this.notaLaborator.set(notaLaborator);
    }
}
