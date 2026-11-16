# 4. Notifications asynchrones

## Statut

Accepte

## Contexte

Le systeme doit prevenir les lecteurs (confirmation d'emprunt, rappel de date de retour, disponibilite d'un livre reserve) par e-mail ou SMS. L'envoi depend de services externes (serveur SMTP, fournisseur SMS) qui peuvent etre lents ou indisponibles. Un envoi realise pendant la requete de l'utilisateur ralentirait les emprunts et les reservations, et une panne du service de notification ne doit pas empecher d'emprunter un livre. Aucune notification ne doit etre perdue ni envoyee pour une operation finalement annulee.

## Decision

Envoyer les notifications de maniere **asynchrone** via une **file de messages (RabbitMQ)**, avec le **pattern Outbox** :

- le module Emprunts ou Reservations enregistre l'evenement dans une table `outbox` de la base PostgreSQL, dans la meme transaction que l'operation metier ;
- un processus d'arriere-plan publie les evenements de la table `outbox` dans la file ;
- un consommateur du module Notifications envoie le message et reessaie en cas d'echec (avec une file des messages en echec apres plusieurs tentatives).

## Alternatives envisagees

- **Envoi synchrone dans la requete** : rejete car il ralentit les operations et une panne du service d'envoi bloquerait les emprunts.
- **Apache Kafka** : rejete car disproportionne pour le volume de la bibliotheque et trop couteux a exploiter pour une petite equipe.
- **Tache planifiee (cron) qui parcourt la base** : rejete car les notifications seraient envoyees avec retard et le parcours regulier de la base alourdirait PostgreSQL.
- **Publication directe dans la file apres le commit (sans Outbox)** : rejete car un plantage entre le commit et la publication ferait perdre la notification.

## Consequences

- **Positives** : les emprunts restent rapides, une panne du service d'envoi n'a pas d'effet sur les operations metier, aucune notification perdue (livraison au moins une fois), possibilite de reessayer les envois en echec.
- **Negatives** : un composant supplementaire a deployer et surveiller (RabbitMQ), notification livree avec un leger delai, un message peut etre envoye deux fois donc le consommateur doit etre idempotent.
- **Liens** : s'appuie sur la base unique de l'[ADR 001](001-choix-de-la-base-de-donnees.md) (table `outbox`) et sur le monolithe modulaire de l'[ADR 002](002-architecture-monolithe-modulaire.md) (module Notifications decouple) ; l'ecriture dans `outbox` suit les regles transactionnelles de l'[ADR 005](005-gestion-des-transactions-et-de-la-concurrence.md).
