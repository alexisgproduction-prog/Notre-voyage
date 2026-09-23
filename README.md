# Notre Voyage V2.1
Interface PWA sombre pour Alexis × Alix.

Inclus : voyage/dates/budget, vols, logements, planning, dépenses 50/50, documents/liens, mode local et préparation complète de la synchronisation Supabase.

## GitHub Pages
Remplace les fichiers de la V1 dans le dépôt GitHub par ceux de cette V2. Garde `index.html` à la racine.

## Synchronisation à deux
1. Créer un projet Supabase.
2. Authentication > Providers : activer Anonymous Sign-Ins.
3. SQL Editor : exécuter `supabase.sql`.
4. Dans l'app : Voyage > Configurer.
5. Coller Project URL + clé publishable/anon.
6. Alexis crée le voyage partagé et donne le code à Alix.
7. Alix colle le code sur son iPhone.

Ne jamais mettre une `service_role` key dans l'application.


## V2.1
- Ajout d’un bouton ⚙️ Réglages accessible depuis l’en-tête.
- Correction du placement du JavaScript afin que toutes les fonctions d’ajout/suppression/synchronisation soient exécutées correctement.
- Utilisation de la Publishable key Supabase côté navigateur.
- Ajout de la possibilité de déconnecter un téléphone de la synchronisation.
