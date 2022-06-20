devtools::install_github("clessn/hublotr")

# validate you have the latest version
hublot::check_version()

# enter credentials
credentials <- hublot::get_credentials("https://clhub.clessn.cloud/")
credentials <- hublot::get_credentials("http://localhost:8080/")

# list all tables
tables <- tidyjson::spread_all(hublot::list_tables(credentials))


# filter tables by type
marts <- tidyjson::spread_all(
    hublot::filter_tables(
        credentials,
        list(metadata__type = "mart")
    )$results
)

warehouses <- tidyjson::spread_all(
    hublot::filter_tables(
        credentials,
        list(metadata__type = "warehouse")
    )$results
)

# select a table
table_name <- tables$db_table[[1]]

# log information to the hub
hublot::log(app_id, "info", "Starting...", credentials)
hublot::log(app_id, "debug", "test123", credentials)
hublot::log(app_id, "warning", "this might be a problem later", credentials)
hublot::log(app_id, "error", "something went wrong", credentials)
hublot::log(app_id, "critical", "something went terribly wrong", credentials)
hublot::log(app_id, "success", "good! everything worked!", credentials)

tidyjson::spread_all(
    hublot::filter_logs(credentials, filter = list(application = "test"))$results
)

# add a new item
for (i in 1:2000) {
    print(i)
    key <- paste(sample(LETTERS, 32, TRUE), collapse = "")

    result <- hublot::add_table_item(table_name,
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
count <- hublot::count_table_items(table_name, credentials, filter)[[1]]
page <- hublot::filter_table_items(table_name, credentials, filter)
data <- list() # on crée une liste vide pour contenir les données
repeat {
    data <- c(data, page$results)
    page <- hublot::filter_next(page, credentials)
    if (is.null(page)) {
        break
    }
}
df <- tidyjson::spread_all(data)


# to upload a file, endpoints work a bit differently.
# you need to convert the json yourself (in this example, the metadata)
hublot::add_lake_item(body = list(
    key = "mylakeitem",
    path = "test/items",
    file = httr::upload_file("test_upload.txt"),
    metadata = jsonlite::toJSON(list(type = "text"), auto_unbox = T)
), credentials)


for (i in 1:rowcount(variables_df))
{
    hublot::create_variable(
        body = list(
            key = variables_df[[i, "key"]],
            name = variables_df[[i, "name"]],
            description = variables_df[[i, "description"]],
            ...
        )
    )
}


file_info <- hublot::retrieve_file("test", credentials)
Df <- read.csv(file_info$file)

data <- hublot::filter_lake_items(credentials, list(key = "21c99719-701b-4876-867d-0795b3b1aea3"))
df <- tidyjson::spread_all(data$results)
