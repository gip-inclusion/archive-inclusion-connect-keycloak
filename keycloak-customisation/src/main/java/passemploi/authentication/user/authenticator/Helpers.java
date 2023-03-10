package passemploi.authentication.user.authenticator;

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.authentication.authenticators.broker.AbstractIdpAuthenticator;
import org.keycloak.authentication.authenticators.broker.util.PostBrokerLoginConstants;
import org.keycloak.authentication.authenticators.broker.util.SerializedBrokeredIdentityContext;
import org.keycloak.broker.provider.BrokeredIdentityContext;
import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.representations.AccessTokenResponse;
import passemploi.authentication.user.model.Utilisateur;

import javax.ws.rs.core.Response;

import static org.keycloak.broker.oidc.OIDCIdentityProvider.FEDERATED_ACCESS_TOKEN_RESPONSE;

public class Helpers {
  public enum UTILISATEUR_INCONNU_MESSAGE {
    JEUNE_PE_INCONNU("passJeunePEInconnu"),
    UTILISATEUR_PASS_EMPLOI_INCONNU("passUtilisateurInconnu");

    public final String value;

    UTILISATEUR_INCONNU_MESSAGE(String value) {
      this.value = value;
    }
  }

  static public void utilisateurInconnuRedirect(AuthenticationFlowContext context, UTILISATEUR_INCONNU_MESSAGE utilisateurInconnuMessage) {
    LoginFormsProvider form = context.form();
    form.setAttribute("utilisateurInconnu", true);
    form.setAttribute("passMessage", utilisateurInconnuMessage.value);
    Response response = form.createForm("utilisateur-inconnu.ftl");
    context.failure(AuthenticationFlowError.INVALID_USER, response);
  }

  static public AccessTokenResponse getFederatedAccessTokenResponse(AuthenticationFlowContext context) {
    SerializedBrokeredIdentityContext serializedCtx = SerializedBrokeredIdentityContext.readFromAuthenticationSession(context.getAuthenticationSession(), AbstractIdpAuthenticator.BROKERED_CONTEXT_NOTE);
    if (serializedCtx == null) {
      // get the identity context for post login flow
      serializedCtx = SerializedBrokeredIdentityContext.readFromAuthenticationSession(context.getAuthenticationSession(), PostBrokerLoginConstants.PBL_BROKERED_IDENTITY_CONTEXT);
    }
    BrokeredIdentityContext brokerContext = serializedCtx.deserialize(context.getSession(), context.getAuthenticationSession());
    AccessTokenResponse tokenResponse = (AccessTokenResponse) brokerContext.getContextData().get(FEDERATED_ACCESS_TOKEN_RESPONSE);
    return tokenResponse;
  }

  public static void setContextPostLogin(AuthenticationFlowContext context, Utilisateur utilisateur) {
    context.getUser().setSingleAttribute("id_user", utilisateur.getId());
    context.getUser().setSingleAttribute("type", utilisateur.getType().toString());
    context.getUser().setSingleAttribute("structure", utilisateur.getStructure().toString());
    context.getUser().setAttribute("roles", utilisateur.getRoles());
    context.getUser().setEmail(utilisateur.getEmail());
    context.getUser().setFirstName(utilisateur.getPrenom());
    context.getUser().setLastName(utilisateur.getNom());
  }

}
