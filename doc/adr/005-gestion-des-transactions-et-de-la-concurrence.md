# 5. Gestion des transactions et de la concurrence

## Statut

Accepte

## Contexte

Plusieurs lecteurs et bibliothecaires utilisent le systeme en meme temps. Deux lecteurs peuvent tenter d'emprunter ou de reserver le dernier exemplaire d'un livre au meme instant, et un emprunt modifie plusieurs tables (exemplaire, emprunt, evenement de notification). Sans protection, on risque des doubles emprunts, des stocks incoherents ou des operations a moitie enregistrees.

## Decision

- Chaque operation metier (emprunt, retour, reservation) s'execute dans **une seule transaction ACID PostgreSQL**, locale au monolithe, au niveau d'isolation **READ COMMITTED**.
- Pour emprunter ou reserver un exemplaire, on utilise un **verrouillage pessimiste** (`SELECT ... FOR UPDATE`) sur la ligne de l'exemplaire.
- Pour les autres modifications (fiche lecteur, catalogue), on utilise un **verrouillage optimiste** avec une colonne `version`.
- Une **contrainte d'unicite partielle** en base (un seul emprunt actif par exemplaire) sert de garde-fou final.

## Alternatives envisagees

- **Niveau d'isolation SERIALIZABLE partout** : rejete car il provoque de nombreux echecs a rejouer et reduit les performances.
- **Verrouillage optimiste uniquement** : rejete pour l'emprunt car la contention sur un exemplaire populaire produirait de nombreux conflits et reessais.
- **Transactions distribuees (2PC) ou saga** : rejete car le monolithe modulaire de l'ADR 002 utilise une base unique ; des transactions locales suffisent.
- **Aucune gestion explicite (confiance a l'application)** : rejete car il laisse la porte ouverte aux doubles emprunts.

## Consequences

- **Positives** : plus de double emprunt, donnees toujours coherentes, solution simple et standard grace a PostgreSQL, garde-fou en base meme en cas de bug applicatif.
- **Negatives** : les verrous peuvent faire attendre des requetes concurrentes et risquent des interblocages (ordre de verrouillage a respecter), le verrouillage optimiste demande de gerer les conflits de version cote application.
- **Liens** : repose sur PostgreSQL ([ADR 001](001-choix-de-la-base-de-donnees.md)) et sur les transactions locales du monolithe ([ADR 002](002-architecture-monolithe-modulaire.md)) ; l'evenement de notification est ecrit dans la meme transaction pour l'[ADR 004](004-notifications-asynchrones.md).
