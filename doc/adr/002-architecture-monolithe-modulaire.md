# 2. Architecture monolithe modulaire vs microservices

## Statut

Accepte

## Contexte

Le systeme (emprunts, reservations, notifications) doit etre scalable, fiable et maintenable. L'equipe est reduite et le perimetre fonctionnel est bien delimite. Le choix du style d'architecture impacte le deploiement, la gestion des donnees, la complexite operationnelle et la facilite d'evolution.

## Decision

Adopter un **monolithe modulaire** : une seule application deployable, decoupee en modules decouples (Catalogue, Emprunts, Reservations, Utilisateurs), communiquant par des interfaces internes bien definies, et utilisant une base PostgreSQL unique (voir [ADR 001](001-choix-de-la-base-de-donnees.md)).

## Alternatives envisagees

- **Microservices** : rejete car la complexite operationnelle (orchestration, observabilite, transactions distribuees, deploiements multiples) est disproportionnee pour une petite equipe et un domaine peu volumineux.
- **Monolithe classique non structure** : rejete car il degrade vite la maintenabilite (couplage fort entre fonctionnalites).

## Consequences

- **Positives** : deploiement simple, transactions locales ACID, debogage facile, cout d'infrastructure reduit ; les modules peuvent etre extraits en services plus tard si besoin.
- **Negatives** : montee en charge par duplication de l'ensemble de l'application, discipline necessaire pour preserver les frontieres entre modules, un defaut grave peut affecter tout le systeme.
- **Liens** : s'appuie sur l'[ADR 001](001-choix-de-la-base-de-donnees.md) ; encadre l'[ADR 003](003-authentification-et-autorisation.md) (securite centralisee) et l'[ADR 004](004-notifications-asynchrones.md) (notifications decouplees par file de messages).
