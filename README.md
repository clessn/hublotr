# Hubr

## Snippets
```R
# installer hubr
devtools::install_github("clessn/hubr")

# valider si nous avons la dernière version, sinon lève une erreur
hubr::check_version()
# alternativement, on peut faire hubr::check_version(warn_only = T) pour simplement lever un avertissement

# entrer ses informations de login, qu'on stocke dans un objet "credentials"
credentials <- hubr::get_credentials("https://clhub.clessn.cloud/")
# on nous demandera notre username et password en ligne de commande ou dans une fenêtre si sur RStudio
# Alternativement, on peut passer les valeurs directement:
# NE PAS LAISSER VOTRE NOM D'UTILISATEUR OU MOT DE PASSE DANS UN PROJET GIT
credentials <- hubr::get_credentials("https://clhub.clessn.cloud/", "admin", "motdepasse")
# c'est utile si les informations de connexion sont dans une variable d'environnement, qu'on peut alors récupérer comme suit: username <- Sys.getenv("HUBR_USERNAME")
# UN MAUVAIS NOM D'UTILISATEUR OU DE MOT DE PASSE NE SERA PAS RAPPORTÉ AVANT UNE PREMIÈRE UTILISATION DE FONCTION

## LES FONCTIONS
hubr::list_tables(credentials) # retourne la liste des tables
# avec le package tidyjson, on peut convertir ces listes de listes en tibble
tables <- tidyjson::spread_all(hubr::list_tables(credentials))

# admettons que j'ai sélectionné une table et je veux y extraire des données
my_table <- "clhub_tables_test_table"
hubr::count_table_items(my_table, credentials) # le nombre total d'éléments dans la table
# les éléments d'une table sont paginés, généralement à coup de 1000. Pour récupérer tous les éléments, on doit demander les données suivantes. On commence par une page, puis on demande une autre, jusqu'à ce que la page soit NULL

page <- hubr::list_table_items(my_table, credentials) # on récupère la première page et les informations pour les apges suivantes
data <- list() # on crée une liste vide pour contenir les données
repeat {
    data <- c(data, page$results)
    page <- hubr::list_next(page, credentials)
    if (is.null(page)) {
        break
    }
}
Dataframe <- tidyjson::spread_all(data) # on convertir maintenant les données en tibble

# télécharger un subset des données grâce au filtrage
# les fonctions pertinentes:
hubr::filter_table_items(table_name, credentials, filter)
hubr::filter_next(page, credentials)
hubr::filter_previous(page, credentials)

# un filtre est une liste nommée d'une certaine façon qui détermine la structure de la requête SQL
# un filtre hubr est basé sur le [Queryset field lookup API](https://docs.djangoproject.com/en/4.0/ref/models/querysets/#field-lookups-1) de django
# il est re commandé de télécharger une page ou un élément et d'en observer la structure avant de créer un filtre.

# quelques exemples. Notez q'un lookup sépare la colonne par deux underscore __
my_filter <- list(
    id=27,
    key__exact="potato",
    key__iexact="PoTaTo",
    key__contains = "pota",
    key__contains="POTA",
    key__in=c("potato", "tomato"),
    timestamps__gte="2020-01-01",
    timestamps__lte="2020-01-31",
    timestamps__gt="2020-01-01",
    timestamps__lt="2020-01-31",
    timestamps__range=c("2020-01-01", "2020-01-31"), # non testé
    timestamps__year=2020, # non testé
    timestamps__month=1, # non testé
    timestamps__day=1, # non testé
    timestamps__week_day=1, # non testé (1=dimanche, 7=samedi)
    key__regex="^potato", # non testé
)

# Ajouter un élément dans une table
hubr::add_table_item(table_name,
        body = list(
            key = key,
            timestamps <- "2020-01-01",
            data = jsonlite::toJSON(
                list(type = "potato", kind = "vegetable"), # stockage de json par des listes (nommées pour dict, non nommées pour arrays)
                auto_unbox = T # très important, sinon les valeurs json seront stockées comme liste d'un objet (ie. {"type": ["potato"], "kind": ["vegetable"]})
            )
        ),
        credentials
    )


# Obtenir les tables de l'entrepôt vs. celles de datamarts
marts <- tidyjson::spread_all(
    hubr::filter_tables(credentials,
        list(metadata__contains=list(type="mart"))
    )
)

warehouses <- tidyjson::spread_all(
    hubr::filter_tables(credentials,
        list(metadata__contains=list(type="warehouse"))
    )
)


# to upload a file, endpoints work a bit differently.
# you need to convert the json yourself (in this example, the metadata)
hubr::add_lake_item(body = list(
    key = "mylakeitem",
    path = "test/items",
    file = httr::upload_file("test_upload.txt"),
    metadata = jsonlite::toJSON(list(type = "text"), auto_unbox = T)
), credentials)


# To read a file (for example a dictionary)
file_info <- hubr::retrieve_file("dictionnaire_LexicoderFR-enjeux", credentials)
dict <- read.csv(file_info$file)

# Pour les logs
hubr::log(app_id, "info", "Starting...", credentials)
hubr::log(app_id, "debug", "test123", credentials)
hubr::log(app_id, "warning", "this might be a problem later", credentials)
hubr::log(app_id, "error", "something went wrong", credentials)
hubr::log(app_id, "critical", "something went terribly wrong", credentials)
hubr::log(app_id, "success", "good! everything worked!", credentials)



```
