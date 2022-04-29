devtools::install_github("clessn/hubr")

# enter credentials
credentials <- hubr::get_credentials("https://clhub.dev.clessn.cloud/")

# list all warehouses
warehouse_tables <- hubr::list_warehouses(credentials)

# select a warehouse table
warehouse_table <- warehouse_tables[[1]]$db_table


# add a new item
key <- paste(sample(LETTERS, 32, TRUE), collapse = "")
result <- hubr::add_warehouse_item(warehouse_table,
    body = list(
        key = key,
        data = jsonlite::toJSON(
            list(type = "potato", kind = "vegetable"),
            auto_unbox = T
        )
    ),
    credentials
)

# list tems
# items are paginated in pages of 1000
warehouse_data_page1 <- hubr::list_warehouse_items(warehouse_table, credentials)
warehouse_data_page2 <- hubr::list_next(warehouse_data_page1, credentials)
warehouse_data_page3 <- hubr::list_next(warehouse_data_page2, credentials)

length(warehouse_data_page1)
length(warehouse_data_page2)
length(warehouse_data_page3)
