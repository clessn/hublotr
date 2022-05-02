devtools::install_github("clessn/hubr")

# enter credentials
credentials <- hubr::get_credentials("https://clhub.dev.clessn.cloud/")

# list all warehouses
warehouse_tables <- hubr::list_warehouses(credentials)
warehouses <- tidyjson::spread_all(warehouse_tables)

# select a warehouse table
table_name <- warehouses$db_table[[1]]

# add a new item
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

# filter items
filter <- list(
    key__contains = "A"
)
count <- hubr::count_warehouse_items(table_name, credentials, filter)[[1]]
page <- hubr::filter_warehouse_items(table_name, credentials, filter)
data <- page$results
while (!is.null(data$"next")) {
    page <- hubr::filter_next(page, credentials)
    if (is.null(page)) {
        break
    }
    data <- c(data, page$results)
}
df <- tidyjson::spread_all(data)
