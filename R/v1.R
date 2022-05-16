# logs

#' @export
log <- function(app_id, level, message, credentials) {
    url <- paste0("api/v1/log/", app_id, "/")
    hubr::create(url, list(level = level, message = message), credentials)
    if (level == "error" || level == "critical") {
        stop(message)
    } else if (level == "warning") {
        warning(message)
    } else if (level == "info") {
        print(message)
    } else if (level == "success") {
        print(paste0("Success: ", message))
    } else if (level == "debug") {
        print(paste0("Debug: ", message))
    } else {
        stop(paste("Unknown level: ", level, ", should be one of debug, info, warning, error, critical or success"))
    }
}

#' @export
list_logs <- function(credentials) {
    path <- "api/v1/logs/"
    return(hubr::list_(path, credentials))
}
filter_logs <- function(credentials, filter) {
    path <- "api/v1/logs/"
    return(hubr::filter(path, filter, credentials))
}
#' @export
retrieve_log <- function(id, credentials) {
    path <- paste0("api/v1/", id, "/")
    return(hubr::retrieve(path, id, credentials))
}
#' @export
list_journals <- function(credentials) {
    path <- "api/v1/journals/"
    return(hubr::list_(path, credentials))
}
filter_journals <- function(credentials, filter) {
    path <- "api/v1/journals/"
    return(hubr::filter(path, filter, credentials))
}
#' @export
retrieve_journal <- function(id, credentials) {
    path <- paste0("api/v1/", id, "/")
    return(hubr::retrieve(path, id, credentials))
}

# tables

#' @export
list_tables <- function(credentials) {
    path <- "api/v1/dynamic_tables/"
    return(hubr::list_(path, credentials))
}
#' @export
filter_tables <- function(credentials, filter) {
    path <- "api/v1/dynamic_tables/"
    return(hubr::filter(path, filter, credentials))
}
#' @export
list_table_items <- function(table_name, credentials, cursor = NULL) {
    path <- paste0("api/v1/", table_name, "/")
    return(hubr::list_paginated(path, credentials, cursor))
}
#' @export
filter_table_items <- function(table_name, credentials, filter) {
    path <- paste0("api/v1/", table_name, "/")
    return(hubr::filter(path, filter, credentials))
}
#' @export
count_table_items <- function(table_name, credentials, filter = NULL) {
    path <- paste0("api/v1/", table_name, "/")
    return(hubr::count(path, filter, credentials))
}

#' @export
add_table_item <- function(table_name, body, credentials) {
    path <- paste0("api/v1/", table_name, "/")
    return(hubr::create(path, body, credentials))
}
#' @export
retrieve_table_item <- function(table_name, id, credentials) {
    path <- paste0("api/v1/", table_name, "/", id, "/")
    return(hubr::retrieve(path, credentials))
}
#' @export
update_table_item <- function(table_name, id, body, credentials) {
    path <- paste0("api/v1/", table_name, "/", id, "/")
    return(hubr::update(path, body, credentials))
}
#' @export
remove_table_item <- function(table_name, id, credentials) {
    path <- paste0("api/v1/", table_name, "/", id, "/")
    return(hubr::remove(path, credentials))
}

# lake

#' @export
list_lake_items <- function(credentials) {
    path <- "api/v1/lake/"
    return(hubr::list_(path, credentials))
}
#' @export
filter_lake_items <- function(credentials, filter) {
    path <- "api/v1/lake/"
    return(hubr::filter(path, filter, credentials))
}
#' @export
retrieve_lake_item <- function(id, credentials) {
    path <- paste0("api/v1/lake/", id, "/")
    return(hubr::retrieve(path, credentials))
}
#' @export
add_lake_item <- function(body, credentials) {
    path <- "api/v1/lake/"
    return(hubr::form_create(path, body, credentials))
}
#' @export
update_lake_item <- function(id, body, credentials) {
    path <- paste0("api/v1/lake/", id, "/")
    return(hubr::update(path, body, credentials))
}
#' @export
remove_lake_item <- function(id, credentials) {
    path <- paste0("api/v1/lake/", id, "/")
    return(hubr::remove(path, credentials))
}

# tags

#' @export
list_tags <- function(credentials) {
    stop("not implemented")
}
#' @export
filter_tags <- function(credentials, filter) {
    stop("not implemented")
}
#' @export
retrieve_tag <- function(id, credentials) {
    stop("not implemented")
}
#' @export
add_tag <- function(id, body, credentials) {
    stop("not implemented")
}
#' @export
update_tag <- function(id, body, credentials) {
    stop("not implemented")
}
#' @export
remove_tag <- function(id, credentials) {
    stop("not implemented")
}

# files

#' @export
list_files <- function(credentials) {
    path <- "api/v1/files/"
    return(hubr::list_(path, credentials))
}
#' @export
filter_files <- function(credentials, filter) {
    path <- "api/v1/files/"
    return(hubr::filter(path, filter, credentials))
}
#' @export
retrieve_file <- function(id, credentials) {
    path <- paste0("api/v1/files/", id, "/")
    return(hubr::retrieve(path, credentials))
}
#' @export
add_file <- function(id, body, credentials) {
    stop("not implemented")
}
#' @export
update_file <- function(id, body, credentials) {
    stop("not implemented")
}
#' @export
remove_file <- function(id, credentials) {
    stop("not implemented")
}
