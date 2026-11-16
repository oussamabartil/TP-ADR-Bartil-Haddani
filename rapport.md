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

### 3. Pourquoi documenter les alternatives et les consequences d'une decision ?

Documenter les **alternatives** montre que la decision a ete comparee a d'autres options et pas prise par habitude. Cela evite de reproposer plus tard une solution deja ecartee, et cela permet de reevaluer le choix quand le contexte change : si le volume de notifications explose, on sait pourquoi Kafka avait ete rejete et on peut reconsiderer ce choix.

Documenter les **consequences** oblige a rendre les compromis explicites, y compris les points negatifs. L'equipe sait ce que la decision coute (dette technique, complexite, limites) et peut preparer les mesures qui vont avec. Dans notre projet, l'ADR 004 (RabbitMQ avec Outbox) indique par exemple qu'il faut un composant de plus a surveiller et que le consommateur doit etre idempotent, car un message peut arriver deux fois.

Enfin, ces deux sections permettent de juger la decision apres coup : on peut verifier si les consequences annoncees se sont produites et si le choix etait bon.

### 4. Risques lies a une mauvaise gestion des decisions d'architecture

- **Perte du contexte** : quand les decisions ne sont pas ecrites, la raison des choix disparait avec le depart d'un membre de l'equipe, et les nouveaux arrivants mettent du temps a comprendre le systeme.
- **Decisions contradictoires** : sans suivi, deux decisions peuvent s'opposer (par exemple une gestion des transactions incompatible avec le mode d'envoi des notifications). Les liens entre ADR servent a reperer ces conflits.
- **Debats repetes** : sans trace, les memes discussions reviennent regulierement et font perdre du temps.
- **Dette architecturale** : une decision devenue obsolete mais jamais marquee comme telle continue de guider le code, et l'ecart avec la realite grandit.
- **Failles de securite** : une decision de securite non documentee (ADR 003 sur l'authentification) peut etre modifiee ou retiree sans que l'on mesure le risque, ce qui ouvre des vulnerabilites.
- **Documentation qui diverge** : si les ADR, les vues ArchiMate et le code ne sont pas coherents, la documentation n'est plus fiable et plus personne ne l'utilise.

<!-- PARTIE 5 : analyse et discussion : a completer (binome) -->
