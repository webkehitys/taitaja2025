# Ohjeet

## 1. Luo uusi repositorio

**Avaa Gitea:**
- Mene Git-palvelimelle: [https://git.taitaja.webkehitys.fi](https://git.taitaja.webkehitys.fi).
- Kirjaudu sisään käyttäjätunnuksellasi ja salasanallasi.

**Valitse framework:**
- Siirry **Organisaatio → Frameworks**.
  ![orgs](/semifinaali/instructions/orgs.png)

- Valitse framework, jota haluat käyttää, tai "vanilla"-pohja.
- Klikkaa **"Use this template"** luodaksesi uuden repositorion.
- Nimeä repositorio moduulin nimen mukaan: **frontend** tai **backend**. Vanilla-projektissa nimeä repositorio **frontend**.
  ![new repo](/semifinaali/instructions/new_repo.png)



**Aseta Action Secrets:**
1. Avaa repositoriosi asetukset: **Settings → Actions → Secrets**.
   ![secrets settings](/semifinaali/instructions/secrets.png)
2. Lisää seuraavat:
   - **USER:** Käyttäjänimesi (esim. comp01)
   - **PASS:** Salasanasi (esim. test123)
  ![secrets settings](/semifinaali/instructions/add-secret.png)

**Testaa toiminta:**
- Tee commit ja tarkista, että GitHub Actions toimii oikein.
- Tarkista muutokset URL-osoitteessa.

## 2. Repositorion kloonaus ja käyttö

**Kloonaa repositorio:**
- Käytä repositorion URL-osoitetta kloonaukseen:
  ```bash
  git clone https://git.taitaja.webkehitys.fi/<käyttäjänimi>/<moduulinimi>.git
  ```
  **Esimerkki:**
  ```bash
  git clone https://git.taitaja.webkehitys.fi/comp01/frontend.git
  ```

**Muokkaa, committaa ja kehitä:**
- Tee säännöllisesti committeja, jotta työ pysyy järjestyksessä.
- Päivitä **README-tiedosto** tärkeillä tiedoilla, kuten asennusohjeilla ja riippuvuuksilla.

## 3. phpMyAdmin käyttö

**Avaa phpMyAdmin:**
- Mene osoitteeseen [https://pma.taitaja.webkehitys.fi](https://pma.taitaja.webkehitys.fi).
- Kirjaudu sisään samoilla tunnuksilla kuin Giteassa:
  - **Käyttäjänimi:** esim. comp01
  - **Salasana:** esim. test123

**Tietokantayhteys:**
- Käytä alla olevaa host-asetusta yhdistääksesi tietokantaan:
  ```php
  define('DB_HOST', 'db.taitaja.webkehitys.fi');
  ```

## 4. Automaatio ja julkaisu

**Automaattinen julkaisu:**
- Jokainen **push** julkaisee automaattisesti kilpailu-URL-osoitteeseen:
  ```
  https://<aliverkko>-<moduulinimi>.taitaja.webkehitys.fi
  ```
  - Vältä turhia pusheja, jotta julkaisuja ei synny liikaa.
  - Tarkista muutokset kilpailu-URL-osoitteessa jokaisen pushin jälkeen.
