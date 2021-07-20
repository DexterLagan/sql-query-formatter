# Sql Query Formatter
An SQL query formatter written in Racket.

## Introduction

SQL Query Formatter reads a long line of code containing an SQL query from the clipboard, cuts it into neatly formatted lines of code with underscore line breaks. SQL Query Formatter reads code from the clipboard. Copy your line, run this, then paste it back into your code and voilà! You get several cleanly formatted lines of code.

## Features

- Reads code directly from the clipboard;
- Automatic syntax detection;
- Parses and breaks SQL queries according to their grammar.

## Technical Details

Turns this:
<pre>
"SELECT DISTINCT p.produit_num, p.produit_idp, pd.produit_descript_num, t.par_ht, pd.produit_descript_part_number, p.produit_num_serie, p.produit_asset_tag, p.produit_commentaire, p.produit_palette, (CASE p.etat_nom WHEN 'OK' THEN 'Fonctionnel' WHEN '2C' THEN 'Reparable' WHEN 'HS' THEN 'HS' ELSE 'Fonctionnel' END) AS etat_nom, (CASE p.audit_etat WHEN 'OK' THEN 'Fonctionnel' WHEN '2C' THEN 'Reparable' WHEN 'HS' THEN 'HS' ELSE 'Fonctionnel' END) AS audit_etat, p.audit_commentaire, p.audit_resultats_abr, m.marque_nom, pd.produit_descript_modele" + sAuditQuery + " FROM produit_descript pd LEFT JOIN mw_tarifs t ON (t.id_pd = pd.produit_descript_num AND t.ty_tar = 'RE' AND t.flpromo = '0' AND t.id_lan = '1' AND t.id_btq = '0' AND t.id_famc = '0') LEFT JOIN marque m ON (m.marque_num = pd.marque_num), produit p LEFT JOIN mw_audit a ON (a.produit_num = p.produit_num) WHERE p.lot_num = '" + Str(nLot) + "' AND pd.categorie_num = '" + Str(nCategory) + "' AND pd.produit_descript_num = p.produit_descript_num ORDER BY p.produit_num"
</pre>
...into this:
<pre>
"SELECT DISTINCT "+_
"p.produit_num, "+_
"p.produit_idp, "+_
"pd.produit_descript_num, "+_
"t.par_ht, "+_
"pd.produit_descript_part_number, "+_
"p.produit_num_serie, "+_
"p.produit_asset_tag, "+_
"p.produit_commentaire, "+_
"p.produit_palette, "+_
"(CASE p.etat_nom WHEN 'OK' THEN 'Fonctionnel' WHEN '2C' THEN 'Reparable' WHEN 'HS' THEN 'HS' ELSE 'Fonctionnel' END) AS etat_nom, "+_
"(CASE p.audit_etat WHEN 'OK' THEN 'Fonctionnel' WHEN '2C' THEN 'Reparable' WHEN 'HS' THEN 'HS' ELSE 'Fonctionnel' END) AS audit_etat, "+_
"p.audit_commentaire, "+_
"p.audit_resultats_abr, "+_
"m.marque_nom, "+_
"pd.produit_descript_modele, "+_
+ sAuditQuery + " "+_
"FROM produit_descript pd "+_
"LEFT JOIN mw_tarifs t ON (t.id_pd = pd.produit_descript_num "+_
"AND t.ty_tar = 'RE' "+_
"AND t.flpromo = '0' "+_
"AND t.id_lan = '1' "+_
"AND t.id_btq = '0' "+_
"AND t.id_famc = '0') "+_
"LEFT JOIN marque m ON (m.marque_num = pd.marque_num), produit p "+_
"LEFT JOIN mw_audit a ON (a.produit_num = p.produit_num) "+_
"WHERE p.lot_num = '" + Str(nLot) + "' "+_
"AND pd.categorie_num = '" + Str(nCategory) + "' "+_
"AND pd.produit_descript_num = p.produit_descript_num ORDER BY p.produit_num"
</pre>

## License

SQL Query Formatter is free software; see [LICENSE](https://github.com/DexterLagan/sql-query-formatter/blob/master/LICENSE) for more details.
