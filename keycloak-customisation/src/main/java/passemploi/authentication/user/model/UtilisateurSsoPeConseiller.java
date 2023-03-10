package passemploi.authentication.user.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class UtilisateurSsoPeConseiller {
    private String sub;
    private String updated_at;
    private String name;
    private String given_name;
    private String family_name;
    private String email;
}
