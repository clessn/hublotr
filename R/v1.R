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

# marts

#' @export
list_marts <- function(credentials) {
    stop("not implemented")
}
#' @export
add_mart_item <- function(mart_table, body, credentials) {
    stop("not implemented")
}
#' @export
retrieve_mart_item <- function(mart_table, id, credentials) {
    stop("not implemented")
}
#' @export
update_mart_item <- function(mart_table, id, body, credentials) {
    stop("not implemented")
}
#' @export
delete_mart_item <- function(mart_table, id, credentials) {
    stop("not implemented")
}

# warehouses

#' @export
list_warehouses <- function(credentials) {
    path <- "api/v1/warehouses/"
    response <- hubr::get(path, credentials = credentials)
    result <- hubr::handle_response(response, path, 200)
    return(result)
}
#' @export
list_warehouse_items <- function(warehouse_table, credentials, cursor = NULL) {
    path <- paste0("api/v1/", warehouse_table, "/")
    if (!is.null(cursor))
    {
        path <- paste0(path, "?", cursor)
    }
    response <- hubr::get(path, credentials = credentials)
    result <- hubr::handle_response(response, path, 200)

    if (!is.null(result$"next")) {
        result$"next" <- strsplit(result$"next", "?", fixed=T)[[1]][[2]]
    }
    if (!is.null(result$"previous")) {
        result$"previous" <- strsplit(result$"previous", "?", fixed=T)[[1]][[2]]
    }

    return(result)
}

#' @export
add_warehouse_item <- function(warehouse_table, body, credentials) {
    path <- paste0("api/v1/", warehouse_table, "/")
    response <- hubr::post(path, body = body, credentials = credentials)
    result <- hubr::handle_response(response, path, 201)
    return(result)
}
#' @export
retrieve_warehouse_item <- function(warehouse_table, id, credentials) {
    stop("not implemented")
}
#' @export
update_warehouse_item <- function(warehouse_table, id, body, credentials) {
    stop("not implemented")
}
#' @export
delete_warehouse_item <- function(warehouse_table, id, credentials) {
    stop("not implemented")
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
delete_lake_item <- function(id, credentials) {
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
delete_tag <- function(id, credentials) {
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
delete_file <- function(id, credentials) {
    stop("not implemented")
}
