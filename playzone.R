devtools::install_github("clessn/hubr")

# validate you have the latest version
hubr::check_version()

# enter credentials
credentials <- hubr::get_credentials("https://clhub.clessn.cloud/")
credentials <- hubr::get_credentials("http://localhost:8080/")

# list all tables
tables <- tidyjson::spread_all(hubr::list_tables(credentials))

# select a table
table_name <- tables$db_table[[1]]

# log information to the hub
hubr::log(app_id, "info", "Starting...", credentials)
hubr::log(app_id, "debug", "test123", credentials)
hubr::log(app_id, "warning", "this might be a problem later", credentials)
hubr::log(app_id, "error", "something went wrong", credentials)
hubr::log(app_id, "critical", "something went terribly wrong", credentials)
hubr::log(app_id, "success", "good! everything worked!", credentials)

tidyjson::spread_all(
    hubr::filter_logs(credentials, filter = list(application = "test"))$results
)

# add a new item
for (i in 1:2000) {
    print(i)
    key <- paste(sample(LETTERS, 32, TRUE), collapse = "")

    result <- hubr::add_table_item(table_name,
        body = list(
            key = key,
            data = list(type = "potato", kind = "vegetable")
        ),
        credentials
    )
}


# filter items
filter <- list(
    key__contains = "A"
)
count <- hubr::count_table_items(table_name, credentials, filter)[[1]]
page <- hubr::filter_table_items(table_name, credentials, filter)
data <- list() # on crée une liste vide pour contenir les données
repeat {
    data <- c(data, page$results)
    page <- hubr::filter_next(page, credentials)
    if (is.null(page)) {
        break
    }
}
df <- tidyjson::spread_all(data)
