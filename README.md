# TP-ADR-Bartil-Haddani

TD2 d'architecture logicielle (ENSIBS, 5eme annee ICE) : documentation des decisions d'architecture d'un systeme de gestion de bibliotheque (emprunts, reservations, notifications) avec des ADR et des vues ArchiMate.

Binome : Oussama Bartil et Haddani Abderazak.

## Structure du projet

    .
    ├── doc/
    │   ├── adr/            # Architecture Decision Records
    │   │   ├── 000-template.md
    │   │   ├── 001-choix-de-la-base-de-donnees.md
    │   │   ├── 002-architecture-monolithe-modulaire.md
    │   │   ├── 003-authentification-et-autorisation.md
    │   │   ├── 004-notifications-asynchrones.md
    │   │   └── 005-gestion-des-transactions-et-de-la-concurrence.md
    │   └── archimate/      # Vues ArchiMate (fichiers Archi)
    │       ├── vue-1-chaine-motivation.archimate
    │       └── vue-2-chaine-du-risque.archimate
    ├── scripts/
    │   ├── check-adr.sh        # Verifie qu'un ADR respecte le template
    │   ├── install-hooks.sh    # Installe le hook Git pre-commit
    │   └── hooks/pre-commit    # Hook qui lance check-adr.sh
    ├── rapport.md          # Reponses aux questions et analyse
    └── sujet_td_adr.pdf    # Sujet du TD

## Liste des ADR

| N° | Decision | Statut |
|----|----------|--------|
| 001 | Choix de la base de donnees (PostgreSQL) | Accepte |
| 002 | Architecture monolithe modulaire | Accepte |
| 003 | Authentification et autorisation (securite) | Accepte |
| 004 | Notifications asynchrones | Accepte |
| 005 | Gestion des transactions et de la concurrence | Accepte |

## Vues ArchiMate

- **Vue 1** : chaine de motivation (Driver, Goal, Requirement, Application Component) pour l'ADR 004.
- **Vue 2** : chaine du risque (Vulnerability, Threat Event, Risk, Control Measure, Control Objective) pour l'ADR 003.

Les fichiers s'ouvrent avec [Archi](https://www.archimatetool.com/).

## Comment contribuer aux ADR

1. Cloner le depot et installer le hook de validation :

       git clone https://github.com/oussamabartil/TP-ADR-Bartil-Haddani.git
       cd TP-ADR-Bartil-Haddani
       scripts/install-hooks.sh

2. Copier le template avec le numero suivant et un nom en minuscules separe par des tirets :

       cp doc/adr/000-template.md doc/adr/006-titre-de-la-decision.md

3. Remplir l'ADR en gardant exactement les sections : `Statut`, `Contexte`, `Decision`, `Alternatives envisagees`, `Consequences`.
   - Le titre a la forme `# <Numero>. <Titre>`.
   - Le statut est l'une de ces valeurs : `Accepte`, `Rejete`, `Obsolete`, `En discussion`.
   - Ajouter des liens vers les ADR lies (dans les Consequences).
4. Verifier le format :

       scripts/check-adr.sh

5. Faire un commit par ADR, puis recuperer les changements avant de pousser :

       git add doc/adr/006-titre-de-la-decision.md
       git commit -m "docs(adr): ajouter l'ADR 006 sur ..."
       git pull --rebase
       git push

### Regles

- Un ADR par decision, un commit par ADR.
- On ne reecrit pas un ADR accepte : si la decision change, on le passe en `Obsolete` et on cree un nouvel ADR qui le remplace.
- Si une decision apparait dans une vue ArchiMate, les noms et la phrase de decision doivent rester identiques dans l'ADR et dans la vue.
- Le hook `pre-commit` refuse un commit si un ADR modifie ne respecte pas le template.
