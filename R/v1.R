# logs

#' @export
send_log <- function(app_id, level, message, credentials) {
    stop("not implemented")
}
#' @export
list_logs <- function(credentials) {
    stop("not implemented")
}
#' @export
retrieve_log <- function(id, credentials) {
    stop("not implemented")
}
#' @export
list_journals <- function(credentials) {
    stop("not implemented")
}
#' @export
retrieve_journal <- function(id, credentials) {
    stop("not implemented")
}

# warehouses

#' @export
list_warehouses <- function(credentials) {
    path <- "api/v1/warehouses/"
    return(hubr::list(path, credentials))
}
#' @export
list_warehouse_items <- function(warehouse_table, credentials, cursor = NULL) {
    path <- paste0("api/v1/", warehouse_table, "/")
    return(hubr::list_paginated(path, credentials, cursor))
}
#' @export
filter_warehouse_items <- function(warehouse_table, credentials, filter) {
    path <- paste0("api/v1/", warehouse_table, "/")
    return(hubr::filter(path, filter, credentials))
}
#' @export
count_warehouse_items <- function(warehouse_table, credentials, filter = NULL) {
    path <- paste0("api/v1/", warehouse_table, "/")
    return(hubr::count(path, filter, credentials))
}

#' @export
add_warehouse_item <- function(warehouse_table, body, credentials) {
    path <- paste0("api/v1/", warehouse_table, "/")
    return(hubr::create(path, body, credentials))
}
#' @export
retrieve_warehouse_item <- function(warehouse_table, id, credentials) {
    path <- paste0("api/v1/", warehouse_table, "/", id, "/")
    return(hubr::retrieve(path, credentials))
}
#' @export
update_warehouse_item <- function(warehouse_table, id, body, credentials) {
    path <- paste0("api/v1/", warehouse_table, "/", id, "/")
    return(hubr::update(path, body, credentials))
}
#' @export
remove_warehouse_item <- function(warehouse_table, id, credentials) {
    path <- paste0("api/v1/", warehouse_table, "/", id, "/")
    return(hubr::remove(path, credentials))
}

# marts

#' @export
list_marts <- function(credentials) {
    path <- "api/v1/marts/"
    return(hubr::list(path, credentials))
}
#' @export
add_mart_item <- function(mart_table, body, credentials) {
    path <- paste0("api/v1/", mart_table, "/")
    return(hubr::create(path, body, credentials))
}
#' @export
filter_mart_items <- function(mart_table, credentials, filter) {
    path <- paste0("api/v1/", mart_table, "/")
    return(hubr::filter(path, filter, credentials))
}
#' @export
count_mart_items <- function(mart_table, credentials, filter = NULL) {
    path <- paste0("api/v1/", mart_table, "/")
    return(hubr::count(path, filter, credentials))
}

#' @export
retrieve_mart_item <- function(mart_table, id, credentials) {
    path <- paste0("api/v1/", mart_table, "/", id, "/")
    return(hubr::retrieve(path, credentials))
}
#' @export
update_mart_item <- function(mart_table, id, body, credentials) {
    path <- paste0("api/v1/", mart_table, "/", id, "/")
    return(hubr::update(path, body, credentials))
}
#' @export
remove_mart_item <- function(mart_table, id, credentials) {
    path <- paste0("api/v1/", mart_table, "/", id, "/")
    return(hubr::remove(path, credentials))
}

# lake

#' @export
list_lake_items <- function(credentials) {
    stop("not implemented")
}
#' @export
retrieve_lake_item <- function(id, credentials) {
    stop("not implemented")
}
#' @export
add_lake_item <- function(id, body, credentials) {
    stop("not implemented")
}
#' @export
update_lake_item <- function(id, body, credentials) {
    stop("not implemented")
}
#' @export
remove_lake_item <- function(id, credentials) {
    stop("not implemented")
}

# tags

#' @export
list_tags <- function(credentials) {
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
    stop("not implemented")
}
#' @export
retrieve_file <- function(id, credentials) {
    stop("not implemented")
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
