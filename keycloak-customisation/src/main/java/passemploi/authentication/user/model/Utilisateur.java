package passemploi.authentication.user.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Data
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class Utilisateur {
    private String id;
    private String prenom;
    private String nom;
    private String email;
    private Structure structure;
    private Type type;
    @Getter(AccessLevel.NONE)
    private List<String> roles;

    // TODO: enlever après avoir décomissionné les rôles realm
    public List<String> getRoles() {
        if (roles == null) {
            return Collections.emptyList();
        }
        return roles;
    }
}
