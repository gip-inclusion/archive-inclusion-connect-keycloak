package passemploi.authentication.user.repository;

import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.jboss.logging.Logger;
import org.keycloak.util.JsonSerialization;
import passemploi.authentication.user.model.Utilisateur;
import passemploi.authentication.user.model.UtilisateurSso;

import java.io.IOException;
import java.net.URI;

public class UserRepository {
  private final CloseableHttpClient httpClient;
  private final String apiBaseUrl = System.getenv("API_BASE_URL");
  private final String apiKey = System.getenv("API_KEY");
  private final Logger logger = Logger.getLogger(UserRepository.class);

  public UserRepository() {
    int timeout = 5;
    RequestConfig config = RequestConfig.custom()
        .setConnectTimeout(timeout * 1000)
        .setConnectionRequestTimeout(timeout * 1000)
        .setSocketTimeout(timeout * 1000).build();
    this.httpClient = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
  }

  public Utilisateur createOrFetch(UtilisateurSso utilisateurSso, String idUtilisateur) throws FetchUtilisateurException {
    try {
      URI uri = URI.create(String.format("%s/auth/users/%s", this.apiBaseUrl, idUtilisateur));
      HttpPut httpPut = new HttpPut(uri);
      httpPut.setHeader("X-API-KEY", this.apiKey);
      String body = JsonSerialization.writeValueAsString(utilisateurSso);
      StringEntity requestEntity = new StringEntity(body, ContentType.APPLICATION_JSON);
      httpPut.setEntity(requestEntity);
      HttpResponse response = httpClient.execute(httpPut);
      if (response.getStatusLine().getStatusCode() == 200) {
        return JsonSerialization.readValue(response.getEntity().getContent(), Utilisateur.class);
      } else {
        logger.error("Une erreur est survenue lors de la récupération de l'utilisateur. Code HTTP : " + response.getStatusLine().getStatusCode());
        logger.error("Une erreur est survenue lors de la récupération de l'utilisateur. Message : " + response.getEntity().getContent().toString());
        throw new FetchUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur. Code HTTP : " + response.getStatusLine().getStatusCode());
      }
    } catch (IOException e) {
      logger.error("error while fetching user: " + idUtilisateur, e);
      throw new FetchUtilisateurException("Une erreur est survenue lors de la récupération de l'utilisateur");
    }
  }
}
