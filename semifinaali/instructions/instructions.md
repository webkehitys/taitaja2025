# Instructions

## 1. Create a New Repository

**Open Gitea:**
- Go to the Git server: [https://git.taitaja.webkehitys.fi](https://git.taitaja.webkehitys.fi).
- Log in using your username and password.

**Choose a Framework:**
- Navigate to **Organization → Frameworks**.
  ![orgs](/semifinaali/instructions/orgs.png)
- Select a framework you want to use, or choose the "vanilla" template.
- Click **"Use this template"** to create a new repository.
- Name the repository based on the module name, **frontend** or **backend**. For a vanilla project, name the repository **frontend**.
  ![new repo](/semifinaali/instructions/new_repo.png)


**Set up Action Secrets:**
1. Open your repository settings: **Settings → Actions → Secrets**.
  ![secrets settings](/semifinaali/instructions/secrets.png)
2. Add the following:
   - **USER:** Your username (e.g., comp01)
   - **PASS:** Your password (e.g., test123)
  ![secrets settings](/semifinaali/instructions/secrets.png)

**Test the Setup:**
- Make a commit to verify that GitHub Actions work correctly.
- Check changes at the URL.

## 2. Clone and Use the Repository

**Clone the Repository:**
- Use the repository URL to clone it:
  ```bash
  git clone https://git.taitaja.webkehitys.fi/<username>/<module_name>.git
  ```
  **Example:**
  ```bash
  git clone https://git.taitaja.webkehitys.fi/comp01/frontend.git
  ```

**Edit, Commit, and Develop:**
- Make regular commits to keep your work organized.
- Update the **README file** with important information, such as setup instructions and dependencies.

## 3. Using phpMyAdmin

**Open phpMyAdmin:**
- Go to [https://pma.taitaja.webkehitys.fi](https://pma.taitaja.webkehitys.fi).
- Log in using the same credentials as Gitea:
  - **Username:** e.g., comp01
  - **Password:** e.g., test123

**Database Connection:**
- Use the following host setting in your application to connect to the database:
  ```php
  define('DB_HOST', 'db.taitaja.webkehitys.fi');
  ```

## 4. Automation and Deployment

**Automatic Deployment:**
- Each **push** automatically deploys to the competition URL:
  ```
  https://<subdomain>-<module_name>.taitaja.webkehitys.fi
  ```
  - Avoid unnecessary pushes to minimize deployments.
  - Check changes at the competition URL after every push.
