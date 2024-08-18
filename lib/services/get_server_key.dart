import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "vaccinationapp-bd2d9",
        "private_key_id": "4653346621e264e32497532f63382005803dbb85",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCaCBHYG26byEWR\n1UyzCYmTFj2LphPpt5aPImEeuSFyuOFJUSstqcIW/4bXfgHlwsF75lFbOXXKu1Ci\nh0aI8WqDkS3y7zkQfWhn4AaT6MYDiE2eDY33MciN3bwXHRrzPehV/6up/rSGj9Kd\nOb/Gc2ENfU1jMRX0NAVUMracuWbBKd+rvxBRNrS5Fws+i5wDt5JDOAbulol8Zj+i\nSfjBLA7zSRzHn3dsJJBZxW8Jw/Mh0k4ahDlAjZnQvIisX9mDei121Nw2WfkODWF+\nt+a2QpxsPoTHCeiUGGCT51d0NlJQOyUlWp83ZNqHLv5OWucAUQQiB0hotb6tc1M6\nz0VzqpNbAgMBAAECggEAOlugVx5dk8wW/5+uxY5xfzbH7qbnmH8kHerKnRdLIuoF\nAQAtuck9bfU2I2LsWR6mq8ihPkzQ4hSCAnH6OVwuHNbeb9JO7n51FhX8qAFjNGdp\n8N310ZgdAhLmdmNimJH1+s85PNjxkKHhDAybKhcAyFmW/mPUi4dCFZp5MXvVAI3E\nZfQS1ao+xMxqwPSh3xzCD8jzqyCx9qml9Cz2l/2cwKVwJYVRmUQKRk0232NF2AcE\n8Z0+obbWbUwlfsMoZ8YGNoc+5mJ/w4EoqIQeLvVpjzFGXbRXEup2+BHPU2lxthgd\nK8ptgapD9kQGCVnS5cS8cF0KmMdYAbnpkl5lSJGvMQKBgQDHHSU3mJbZyKLOhwQU\n5wg3KyJ7Xb+j0Qr86rVqBvZUUDE6T281F2rJKsS2jeGvYjYCQN8bLV8po+DfRK5i\nfQN2fL2nC0u67BEiVjhp9utf3OxIitFouXcO+Dazj2P2tKpQtGf0tWTUX237iMbb\n7bifxpgYzll+BMpadluK8jggnQKBgQDGCa2c/LOFvxO38yYWtsC0uX0gTHA9CzlQ\nOaSna6pUJuVQ0apHK7H3vZ4VACk6Cydzvmdbfh+Rzi9KBvUBNlwtOmkjQMZhNSxa\nHLdB/UR3gb6ZXd2Y9N0jo+OJggr9cJ2Z8VAafskjCeqpGdV9QECRgQ0LYAbAyCXg\nKiF1G9IWVwKBgGxLEb7XItR4JvQkwreLoBBBSZPHPT+fplZAYUK1XqwkoWGRam55\nuf6HYE3ZhPGafL1lAvMJDkTbeKZ1+FJgo82BsrRzlFCpq/f85NndDc8pnOkndxV6\nKaLepQGr7zZytF8If7G8JobLEEpJ7b4X4N4laPu03z+G43en/8nmS1iRAoGADkyM\nmJU2cSXGyrVnvqQbbfEms7pRMFcrIDvJQ71mYwUb8aXx4YmqI/UxANsuHt7HTngl\nBloo9WIpz/KIpjnClhFtnfoDWOl59le0c7NRyj83/+LjKTQk83nV6AvXt0z2VDM0\nUXVuGHWS1/rhi1WkU905j+SzGCBbe8APAmGr3akCgYEAkJCJYPrq/fRM3foa/Rsu\nBuN7prYc4cLNK24YC+Mu2Tn2JrOXwtqeD8yKnTymMZ+7fQDQ9fQ+IqWVYXpMM8ox\nAE3QUT2uDqvc8XgtaPvll/AbXy5xtVKoA3l7IDA8lsp4370FvAUeKE28Aeq2Chg7\npLfABk6ULPH9XCudMszanPc=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-i12lm@vaccinationapp-bd2d9.iam.gserviceaccount.com",
        "client_id": "111351385584774713140",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-i12lm%40vaccinationapp-bd2d9.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
