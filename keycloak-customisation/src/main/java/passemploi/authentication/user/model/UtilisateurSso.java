package passemploi.authentication.user.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class UtilisateurSso {
    private String prenom;
    private String nom;
    private String email;
    private Structure structure;
    private Type type;
    
    public UtilisateurSso(Structure structure, Type type) {
        this.structure = structure;
        this.type = type;
    }
}
