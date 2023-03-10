package passemploi.authentication.user.authenticator;

import org.jboss.logging.Logger;
import org.keycloak.TokenVerifier;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.authentication.Authenticator;
import org.keycloak.common.VerificationException;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.representations.AccessTokenResponse;
import org.keycloak.representations.IDToken;
import passemploi.authentication.user.model.*;
import passemploi.authentication.user.repository.FetchPEUtilisateurException;
import passemploi.authentication.user.repository.FetchUtilisateurException;
import passemploi.authentication.user.repository.PoleEmploiRepository;
import passemploi.authentication.user.repository.UserRepository;

import java.util.List;

public class SsoPEJeuneAuthenticator implements Authenticator {
  protected static final Logger logger = Logger.getLogger(SsoPEJeuneAuthenticator.class);
  private final UserRepository userRepository;
  private final PoleEmploiRepository poleEmploiRepository;

  public SsoPEJeuneAuthenticator() {
    userRepository = new UserRepository();
    poleEmploiRepository = new PoleEmploiRepository();
  }

  @Override
  public void authenticate(AuthenticationFlowContext context) {
    AccessTokenResponse tokenResponse = Helpers.getFederatedAccessTokenResponse(context);
    try {
      UtilisateurSso utilisateurSso = buildUtilisateurSso(context, tokenResponse.getToken());
      IDToken idTokenParsed = TokenVerifier.create(tokenResponse.getIdToken(), IDToken.class).getToken();
      Utilisateur utilisateur = userRepository.createOrFetch(utilisateurSso, idTokenParsed.getSubject());
      Helpers.setContextPostLogin(context, utilisateur);
      context.success();
    } catch (VerificationException e) {
      logger.error(e);
      context.failure(AuthenticationFlowError.IDENTITY_PROVIDER_ERROR);
    } catch (FetchUtilisateurException e) {
      logger.error(e);
      Helpers.utilisateurInconnuRedirect(context, Helpers.UTILISATEUR_INCONNU_MESSAGE.JEUNE_PE_INCONNU);
    }
  }

  private UtilisateurSso buildUtilisateurSso(AuthenticationFlowContext context, String accessToken) {
    try {
      UtilisateurSsoPeJeune utilisateurSsoPe = poleEmploiRepository.getJeune(accessToken);
      return new UtilisateurSso(
          utilisateurSsoPe.getPrenom(),
          utilisateurSsoPe.getNom(),
          utilisateurSsoPe.getEmail(),
          Structure.POLE_EMPLOI,
          Type.JEUNE
      );
    } catch (FetchPEUtilisateurException e) {
      logger.error("Erreur lors de la recuperation de l'utilisteur PE, Fallback", e);
      return new UtilisateurSso(context.getUser().getFirstName(),
          context.getUser().getLastName(),
          context.getUser().getEmail(),
          Structure.POLE_EMPLOI,
          Type.JEUNE);
    }
  }


  @Override
  public void action(AuthenticationFlowContext context) {
  }

  @Override
  public void close() {
  }

  @Override
  public boolean requiresUser() {
    return true;
  }

  @Override
  public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
    return true;
  }


  @Override
  public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
  }
}
