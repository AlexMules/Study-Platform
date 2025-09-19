package ro.platformaStudiu.serviceClass;

public class ActivitateInscriere extends  Activitate{
    private String descriere;
    private String ora;

    public ActivitateInscriere(String ora, String ziua, int activitateID, String descriere){
        super(ziua,activitateID);
        this.descriere=descriere;
        this.ora=ora;
    }

    @Override
    public String toString() {
        return " " + super.toString() + ", Descriere:'" + descriere + '\'' + ", Ora:'" + ora + '\'';
    }
}
