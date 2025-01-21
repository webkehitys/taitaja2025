# Instruktioner

## 1. Skapa ett nytt repo

**Öppna Gitea:**
- Gå till Git-servern: [https://git.taitaja.webkehitys.fi](https://git.taitaja.webkehitys.fi).
- Logga in med ditt användarnamn och lösenord.

**Välj ett ramverk:**
- Gå till **Organisation → Frameworks**.
  ![orgs](/semifinaali/instructions/orgs.png)
- Välj ett ramverk som du vill använda, eller en "vanilla"-mall.
- Klicka på **"Use this template"** för att skapa ett nytt repo.
- Namnge repot efter modulens namn: **frontend** eller **backend**. Om du använder vanilla-projekt, namnge repot **frontend**.
  ![new repo](/semifinaali/instructions/new_repo.png)

**Ställ in Action-secrets:**
1. Öppna inställningarna för ditt repo: **Settings → Actions → Secrets**.
  ![secrets settings](/semifinaali/instructions/secrets.png)
1. Lägg till följande:
   - **USER:** Ditt användarnamn (t.ex. comp01)
   - **PASS:** Ditt lösenord (t.ex. test123)
  ![secrets settings](/semifinaali/instructions/add-secret.png)

![secrets settings](/semifinaali/instructions/secrets.png)


**Testa funktionaliteten:**
- Gör en commit och kontrollera att GitHub Actions fungerar korrekt.
- Kontrollera ändringarna på URL-adressen.


## 2. Klona och använda repo

**Klona repo:**
- Använd repo-URL:en för att klona:
  ```bash
  git clone https://git.taitaja.webkehitys.fi/<användarnamn>/<modulnamn>.git
  ```
  **Exempel:**
  ```bash
  git clone https://git.taitaja.webkehitys.fi/comp01/frontend.git
  ```

**Redigera, committa och utveckla:**
- Gör regelbundna commits för att hålla arbetet organiserat.
- Uppdatera **README-filen** med viktig information, såsom installationsinstruktioner och beroenden.


## 3. Använda phpMyAdmin

**Öppna phpMyAdmin:**
- Gå till [https://pma.taitaja.webkehitys.fi](https://pma.taitaja.webkehitys.fi).
- Logga in med samma inloggningsuppgifter som i Gitea:
  - **Användarnamn:** t.ex. comp01
  - **Lösenord:** t.ex. test123

**Databasanslutning:**
- Använd följande värdinställning i din applikation för att ansluta till databasen:
  ```php
  define('DB_HOST', 'db.taitaja.webkehitys.fi');
  ```


## 4. Automatisering och publicering

**Automatisk publicering:**
- Varje **push** publiceras automatiskt till tävlings-URL:en:
  ```
  https://<subdomän>-<modulnamn>.taitaja.webkehitys.fi
  ```
  - Undvik onödiga pushar för att minimera antalet publiceringar.
  - Kontrollera ändringarna på tävlings-URL:en efter varje push.

