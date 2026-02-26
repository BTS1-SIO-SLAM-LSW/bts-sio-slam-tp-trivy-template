# TP -- Audit de sécurité d'une application conteneurisée avec Trivy

BTS SIO -- Option SLAM\
Bloc 3 -- Cybersécurité des services informatiques

------------------------------------------------------------------------

## Contexte professionnel

Vous êtes développeur au sein d'une ESN.

Votre équipe doit livrer une application Web conteneurisée à un client.

Avant la mise en production, le RSSI impose un audit de sécurité
automatisé des images Docker utilisées dans le projet.

Votre mission consiste à :

-   Installer un outil de scan de vulnérabilités
-   Scanner une image Docker
-   Identifier les vulnérabilités critiques
-   Proposer des actions correctives
-   Automatiser le contrôle via un pipeline CI/CD

Vous utiliserez l'outil **Trivy**.

# Trivy – Présentation et intérêt en BTS SIO SLAM

Trivy est un outil open source de scan de sécurité permettant d’identifier des vulnérabilités (CVE) dans les images Docker, les dépendances applicatives (Node.js, PHP, Java, Python…), ainsi que dans les fichiers d’infrastructure (Dockerfile, Kubernetes, Terraform). Il permet également la détection de secrets (clés API, tokens, mots de passe exposés) et peut générer un SBOM. Simple, rapide et facile à intégrer en CI/CD, il est largement utilisé dans les environnements DevOps .

Pour les étudiants de BTS SIO option SLAM, Trivy permet d’introduire la sécurité applicative et le DevSecOps dans les projets de développement. Il sensibilise aux risques liés aux dépendances et aux mauvaises configurations, tout en se rapprochant des pratiques professionnelles actuelles .

Trivy est aujourd’hui l’un des outils open source les plus populaires pour la sécurisation des conteneurs et des applications. Le maîtriser constitue un véritable atout pour les stages, l’alternance et l’insertion professionnelle .

------------------------------------------------------------------------

## Compétences BTS SIO visées

Bloc 3 -- Cybersécurité des services informatiques :

-   Identifier les vulnérabilités d'un service
-   Mettre en œuvre un outil d'audit
-   Analyser un rapport de sécurité
-   Proposer une remédiation
-   Intégrer la sécurité dans un processus DevOps

------------------------------------------------------------------------

## Structure du projet

Le dépôt contient :

-   docker/
    -   Dockerfile.insecure
    -   Dockerfile.fixed
-   scripts/
    -   install-trivy.sh
    -   scan-image.sh
    -   scan-fs.sh
    -   export-report.sh
-   reports/
-   .github/workflows/trivy.yml
-   app/

Ne modifiez pas la structure du dépôt.

------------------------------------------------------------------------

## PARTIE A -- Installation et vérifications

### A1 -- Vérifier Docker

``` bash
docker version
docker ps
```

### A2 -- Installer Trivy

``` bash
bash scripts/install-trivy.sh
trivy --version
```

### Questions A

1.  Quelle version de Trivy est installée ?
2.  À quoi sert un vulnerability scanner ?
3.  Quelle est la différence entre SAST, DAST et scan d'image Docker ?
4.  Pourquoi la cybersécurité doit-elle être automatisée ?

------------------------------------------------------------------------

## PARTIE B -- Construction d'une image vulnérable

``` bash
docker build -f docker/Dockerfile.insecure -t tp-trivy:insecure .
docker images
```

(Ne pas oublier le . dans la première commande car il représente le dossier courant)

### Questions B

1.  Quelle base image est utilisée ?
2.  Pourquoi une base ancienne augmente-t-elle le risque ?
3.  Que signifie CVE ?
4.  Expliquez la notion de surface d'attaque dans un conteneur.
5.  **Qu'est-ce qui fait que `Dockerfile.insecure` est vulnérable ?**
    -   Analysez le Dockerfile ligne par ligne.
    -   Identifiez les mauvaises pratiques de sécurité.
    -   Expliquez les risques associés.

------------------------------------------------------------------------

## PARTIE C -- Scan de l'image vulnérable

``` bash
bash scripts/scan-image.sh tp-trivy:insecure
```

### Questions C

1.  Nombre de vulnérabilités HIGH ?
2.  Nombre de vulnérabilités CRITICAL ?
3.  Citez une CVE détectée.
4.  Quel package est concerné ?
5.  Une version corrigée est-elle proposée ?
6.  Toutes les vulnérabilités sont-elles exploitables ? Justifiez.

------------------------------------------------------------------------

## PARTIE D -- Remédiation

``` bash
docker build -f docker/Dockerfile.fixed -t tp-trivy:fixed .
bash scripts/scan-image.sh tp-trivy:fixed
```

### Questions D

1.  Expliquer ce qu'est une remédiation 
2.  Le nombre de vulnérabilités a-t-il diminué ?
3.  Expliquez pourquoi.
4.  Comparez les deux Dockerfile.
5.  La sécurité peut-elle être totale ? Pourquoi ?

------------------------------------------------------------------------

## PARTIE E -- Scan du filesystem

``` bash
bash scripts/scan-fs.sh .
```

### Questions E

1.  Quelle différence entre `trivy image` et `trivy fs` ?
2.  À quel moment utiliser un scan filesystem ?
3.  Pourquoi scanner avant même de créer l'image Docker ?

------------------------------------------------------------------------

## PARTIE F -- Génération de rapports

``` bash
bash scripts/export-report.sh tp-trivy:fixed
```

Vérifiez le dossier `reports/`.

### Questions F

1.  Différence entre format table, JSON et SARIF ?
2.  Pourquoi le format SARIF est-il utilisé dans GitHub ?
3.  Pourquoi conserver les rapports de sécurité ?

------------------------------------------------------------------------

## PARTIE G -- Intégration CI/CD

1.  Faire un commit
2.  Pousser sur GitHub
3.  Vérifier l'onglet Actions
4.  Vérifier l'onglet Security

### Questions G

1.  Le pipeline passe-t-il ?
2.  Que signifie `exit-code: 1` ?
3.  Pourquoi bloquer une livraison en cas de vulnérabilité CRITICAL ?
4.  Qui est responsable de la sécurité applicative ?

------------------------------------------------------------------------

## Livrables attendus

-   Un fichier REPONSES.md contenant :
    -   Les réponses à toutes les questions
    -   Une analyse comparative insecure vs fixed
    -   Une proposition de politique sécurité (10 lignes minimum)
-   Au moins un rapport dans le dossier reports/
-   Le dépôt Git complet et fonctionnel

------------------------------------------------------------------------

## Barème (20 points)

Installation correcte : 4 pts\
Analyse image insecure : 4 pts\
Remédiation argumentée : 6 pts\
Rapports générés : 3 pts\
CI/CD fonctionnelle : 3 pts

------------------------------------------------------------------------

## 1Analyse professionnelle

Expliquez :

-   Pourquoi la sécurité doit être intégrée dès le développement
-   En quoi Trivy s'inscrit dans une démarche DevSecOps
-   Quels risques encourt une entreprise qui ignore ces contrôles

------------------------------------------------------------------------

## Conclusion

Le test montre la présence de vulnérabilités, mais ne garantit jamais
leur absence totale.

La cybersécurité est un processus continu.
