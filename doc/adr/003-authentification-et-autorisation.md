# 3. Authentification et autorisation

## Statut

Accepte

## Contexte

Le systeme manipule des donnees personnelles (identite des lecteurs, historique d'emprunts) et expose des operations sensibles (gestion du catalogue, modification des emprunts). Il faut empecher les acces non authentifies, limiter chaque utilisateur a ses droits (lecteur, bibliothecaire, administrateur) et reduire le risque de vol ou de rejeu de session.

## Decision

- Authentification par **jetons JWT signes** a courte duree de vie (15 minutes) avec jeton de rafraichissement, sur le protocole **OAuth 2.0 / OpenID Connect**.
- Autorisation par **controle d'acces base sur les roles (RBAC)** verifie dans le module Utilisateurs.
- Mots de passe haches avec **Argon2**, communications chiffrees en **TLS** obligatoire.
- Limitation du nombre de tentatives de connexion (anti force brute).

## Alternatives envisagees

- **Sessions serveur avec cookies** : rejete car l'etat partage complique la montee en charge et l'ouverture a des clients tiers.
- **Authentification maison (login/mot de passe simple)** : rejete car risque eleve d'erreurs d'implementation et absence de standard.
- **Cles d'API statiques** : rejete car pas de notion de role ni d'expiration, rotation difficile.

## Consequences

- **Positives** : authentification standard et interoperable, droits granulaires, reduction de la fenetre d'attaque grace aux jetons courts, compatible avec une evolution vers des services separes.
- **Negatives** : complexite d'implementation (rotation, revocation des jetons), necessite une gestion rigoureuse des secrets de signature.
- **Liens** : implemente dans le monolithe de l'[ADR 002](002-architecture-monolithe-modulaire.md) ; les donnees d'identite sont stockees dans la base de l'[ADR 001](001-choix-de-la-base-de-donnees.md).
