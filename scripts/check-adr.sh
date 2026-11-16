#!/usr/bin/env bash
# Verifie que chaque ADR respecte le template (doc/adr/NNN-*.md).
# Usage : scripts/check-adr.sh [fichier ...]   (sans argument : tous les ADR)
set -u
cd "$(git rev-parse --show-toplevel)"

if [ "$#" -gt 0 ]; then files=("$@"); else
  mapfile -t files < <(ls doc/adr/[0-9][0-9][0-9]-*.md 2>/dev/null | grep -v '/000-')
fi

sections=("## Statut" "## Contexte" "## Decision" "## Alternatives envisagees" "## Consequences")
errors=0
err() { echo "ERREUR [$1] : $2"; errors=$((errors+1)); }

for f in "${files[@]}"; do
  [ -f "$f" ] || continue
  head -n1 "$f" | grep -Eq '^# [0-9]+\. .+' || err "$f" "le titre doit etre '# <Numero>. <Titre>'"
  last=0
  for s in "${sections[@]}"; do
    n=$(grep -nxF "$s" "$f" | head -n1 | cut -d: -f1)
    if [ -z "$n" ]; then err "$f" "section manquante : '$s'"
    elif [ "$n" -lt "$last" ]; then err "$f" "section '$s' dans le mauvais ordre"
    else last=$n; fi
  done
  statut=$(awk '/^## Statut/{f=1;next} /^## /{f=0} f&&NF{print;exit}' "$f")
  echo "$statut" | grep -Eq '^(Accepte|Rejete|Obsolete|En discussion)$' \
    || err "$f" "statut invalide ('$statut') : Accepte / Rejete / Obsolete / En discussion"
done

if [ "$errors" -gt 0 ]; then echo "$errors erreur(s) : ADR non conforme au template."; exit 1; fi
echo "ADR conformes au template (${#files[@]} fichier(s))."
