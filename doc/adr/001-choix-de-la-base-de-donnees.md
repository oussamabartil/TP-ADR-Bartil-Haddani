# 1. Choix de la base de donnees

## Statut

Accepte

## Contexte

Le systeme de gestion de bibliotheque doit gerer un grand nombre de transactions (emprunts, reservations, retours) avec une forte coherence des donnees : un exemplaire ne peut pas etre emprunte par deux lecteurs en meme temps. Les donnees doivent etre persistantes, accessibles rapidement et interrogeables par des requetes complexes (historique, statistiques, recherche multi-criteres).

## Decision

Utiliser **PostgreSQL** comme base de donnees relationnelle unique du systeme.

## Alternatives envisagees

- **MongoDB** : rejete car moins adapte aux transactions multi-documents complexes et au modele fortement relationnel (lecteurs, exemplaires, emprunts, reservations).
- **MySQL** : rejete car moins performant pour les requetes complexes et moins riche en fonctionnalites (types avances, contraintes d'exclusion).

## Consequences

- **Positives** : coherence transactionnelle ACID, requetes complexes possibles, contraintes d'integrite fortes, ecosysteme mature et open source.
- **Negatives** : configuration et administration plus complexes qu'une base NoSQL, montee en charge horizontale plus difficile.
- **Liens** : cette decision conditionne l'[ADR 005](005-gestion-des-transactions-et-de-la-concurrence.md) (transactions et concurrence) et est utilisee par l'[ADR 002](002-architecture-monolithe-modulaire.md) (base unique partagee par les modules).
