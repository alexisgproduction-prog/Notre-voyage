# Notre Voyage V3

Application PWA iPhone-style pour organiser un voyage à deux.

## V3
- Interface sombre inspirée d'iOS
- Compte à rebours avant départ
- Vols/logements avec payeur + réservateur
- Création automatique d'une dépense pour vols/logements
- Couleurs visuelles Alexis / Alix
- Carte OpenStreetMap + points personnalisés
- Planning en timeline
- Rappels + export Calendrier `.ics`
- Documents PDF/images via Supabase Storage
- Synchronisation Supabase entre deux téléphones

## Migration Supabase
Après la V2.1, exécuter **supabase-v3.sql** une seule fois dans SQL Editor.

Ne jamais mettre une clé `service_role` ou `secret` dans l'application. Utiliser la Publishable key.
