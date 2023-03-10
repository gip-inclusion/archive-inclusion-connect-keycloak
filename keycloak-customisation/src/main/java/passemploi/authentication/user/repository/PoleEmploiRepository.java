package passemploi.authentication.user.repository;

import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.jboss.logging.Logger;
import org.keycloak.util.JsonSerialization;
import passemploi.authentication.user.model.UtilisateurSsoPeConseiller;
import passemploi.authentication.user.model.UtilisateurSsoPeJeune;

import java.io.IOException;
import java.net.URI;

public class PoleEmploiRepository {
  private final CloseableHttpClient httpClient;
  private final Logger logger = Logger.getLogger(PoleEmploiRepository.class);
  private final String userInfoConseillerUrl = System.getenv("PE_CONSEILLER_USER_INFO_API_URL");
  private final String userInfoJeuneUrl = System.getenv("PE_JEUNE_USER_INFO_API_URL");

  public PoleEmploiRepository() {
    int timeout = 5;
    RequestConfig config = RequestConfig.custom()
        .setConnectTimeout(timeout * 1000)
        .setConnectionRequestTimeout(timeout * 1000)
        .setSocketTimeout(timeout * 1000).build();
    this.httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
  }

  public UtilisateurSsoPeConseiller getConseiller(String token) throws FetchPEUtilisateurException {
    try {
      URI uri = URI.create(this.userInfoConseillerUrl);
      HttpGet httpGet = new HttpGet(uri);
      httpGet.setHeader("Authorization", "Bearer " + token);
      HttpResponse response = httpClient.execute(httpGet);
      if (response.getStatusLine().getStatusCode() == 200) {
        return JsonSerialization.readValue(response.getEntity().getContent(), UtilisateurSsoPeConseiller.class);
      } else {
        logger.error("Une erreur est survenue lors de la récupération de l'utilisateur PE. Message : " + response.getEntity().toString());
        throw new FetchPEUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur PE. Code HTTP : " + response.getStatusLine().getStatusCode());
      }
    } catch (IOException e) {
      logger.error("error while fetching user");
      throw new FetchPEUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur PE");
    }
  }

  public UtilisateurSsoPeJeune getJeune(String token) throws FetchPEUtilisateurException {
    try {
      URI uri = URI.create(this.userInfoJeuneUrl);
      HttpGet httpGet = new HttpGet(uri);
      httpGet.setHeader("Authorization", "Bearer " + token);
      HttpResponse response = httpClient.execute(httpGet);
      if (response.getStatusLine().getStatusCode() == 200) {
        return JsonSerialization.readValue(response.getEntity().getContent(), UtilisateurSsoPeJeune.class);
      } else {
        logger.error("Une erreur est survenue lors de la récupération de l'utilisateur PE. Message : " + response.getEntity().toString());
        throw new FetchPEUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur PE. Code HTTP : " + response.getStatusLine().getStatusCode());
      }
    } catch (IOException e) {
      logger.error("error while fetching user");
      throw new FetchPEUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur PE");
    }
  }
}
