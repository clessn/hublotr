devtools::install_github("clessn/hubr")

# validate you have the latest version
hubr::check_version()

# enter credentials
credentials <- hubr::get_credentials("https://clhub.dev.clessn.cloud/")
# credentials <- hubr::get_credentials("http://localhost:8080/")

# list all warehouses
warehouse_tables <- hubr::list_warehouses(credentials)
warehouses <- tidyjson::spread_all(warehouse_tables)

# select a warehouse table
table_name <- warehouses$db_table[[1]]

# add a new item
for (i in 1:1000)
{
    print(i)
    key <- paste(sample(LETTERS, 32, TRUE), collapse = "")
    result <- hubr::add_warehouse_item(table_name,
        body = list(
            key = key,
            data = jsonlite::toJSON(
                list(type = "potato", kind = "vegetable"),
                auto_unbox = T
            )
        ),
        credentials
    )
}


# filter items
filter <- list(
    key__contains = "A"
)
count <- hubr::count_warehouse_items(table_name, credentials, filter)[[1]]
page <- hubr::filter_warehouse_items(table_name, credentials, filter)
data <- list() # on crée une liste vide pour contenir les données
repeat {
    data <- c(data, page$results)
    page <- hubr::filter_next(page, credentials)
    if (is.null(page)) {
        break
    }
}
df <- tidyjson::spread_all(data)

dplyr::filter(df, grepl("B", key))
