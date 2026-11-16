# Rapport TD2 - ADR et vues ArchiMate

Binome : Oussama Bartil / Haddani

## Partie 1 : Etude theorique

### 1. Qu'est-ce qu'un ADR ? Avantages par rapport a une documentation classique

Un **Architecture Decision Record (ADR)** est un court document, generalement en Markdown, qui consigne **une seule decision d'architecture** : son contexte, la solution retenue, les alternatives ecartees et les consequences. Chaque ADR est numerote, date, a un statut (accepte, rejete, obsolete, en discussion) et vit dans le depot de code.

Avantages par rapport a une documentation classique (gros document d'architecture, wiki) :

- **Capture le "pourquoi"** et pas seulement le "quoi" : la documentation classique decrit l'etat final, l'ADR garde la raison des choix.
- **Leger et facile a ecrire** : une page par decision, donc effectivement redigee et tenue a jour.
- **Versionne avec le code** : historique Git, revue par pull request, lien entre decision et evolution du code.
- **Immuable et tracable** : on ne reecrit pas l'histoire, on marque un ADR obsolete et on le remplace par un nouveau.
- **Facilite l'integration** de nouveaux arrivants et evite de remettre en cause sans cesse les memes choix.

### 2. Trois outils ou methodes pour gerer les ADR

| Outil / methode | Principe | Points forts | Limites |
|---|---|---|---|
| **adr-tools** (scripts shell) | Ligne de commande : `adr new`, `adr link`, numerotation automatique, generation de sommaire | Simple, gere les liens et le remplacement entre ADR, standard de fait | Necessite un shell Unix, peu de controle de format |
| **Fichiers Markdown manuels** + template dans Git (`doc/adr`) | On copie un template et on ouvre une pull request | Aucune dependance, totalement flexible, relu comme du code | Numerotation et liens a la main, risque de derive du format (d'ou un hook de validation) |
| **Log4brains** (ou Docusaurus/MkDocs) | Genere un site web navigable a partir des ADR | Recherche, timeline, publication facile, bon pour de gros projets | Outil supplementaire a installer et maintenir |

Dans ce projet, nous utilisons des **fichiers Markdown dans Git** avec un template et un **hook de validation** : c'est le choix le plus simple, sans dependance, et le hook compense l'absence d'outillage.

<!-- PARTIE 1 questions 3 et 4 : a completer (binome) -->

<!-- PARTIE 5 : analyse et discussion : a completer (binome) -->
