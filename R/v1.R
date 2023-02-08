# logs

#' Log
#'
#' @export
log <- function(app_id, level, message, url) {
  url <- paste0(url, "api/v1/log/", app_id, "/")
  hublot::create(url, list(level = level, message = message), NULL)
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

#' List logs
#'
#' @inheritParams list_
#' @export
list_logs <- function(credentials) {
  path <- "api/v1/logs/"
  return(hublot::list_(path, credentials))
}
filter_logs <- function(credentials, filter) {
  path <- "api/v1/logs/"
  return(hublot::filter(path, filter, credentials))
}
#' Retrieve logs
#'
#' @inheritParams retrieve
#' @export
retrieve_log <- function(id, credentials) {
  path <- paste0("api/v1/", id, "/")
  return(hublot::retrieve(path, id, credentials))
}
#' List journals
#'
#' @inheritParams list_
#' @export
list_journals <- function(credentials) {
  path <- "api/v1/journals/"
  return(hublot::list_(path, credentials))
}
filter_journals <- function(credentials, filter) {
  path <- "api/v1/journals/"
  return(hublot::filter(path, filter, credentials))
}
#' Retrieve journal
#'
#' @inheritParams retrieve
#' @export
retrieve_journal <- function(id, credentials) {
  path <- paste0("api/v1/", id, "/")
  return(hublot::retrieve(path, id, credentials))
}

# tables

#' List tables
#'
#' @inheritParams list_
#' @export
list_tables <- function(credentials) {
  path <- "api/v1/dynamic_tables/"
  return(hublot::list_(path, credentials))
}
#' Filter tables
#'
#' @inheritParams filter
#' @export
filter_tables <- function(credentials, filter) {
  path <- "api/v1/dynamic_tables/"
  return(hublot::filter(path, filter, credentials))
}
#' List table items
#'
#' @inheritParams list_paginated
#' @export
list_table_items <- function(table_name, credentials, cursor = NULL) {
  path <- paste0("api/v1/", table_name, "/")
  return(hublot::list_paginated(path, credentials, cursor))
}
#' Filter table items
#'
#' @inheritParams filter
#' @export
filter_table_items <- function(table_name, credentials, filter) {
  path <- paste0("api/v1/", table_name, "/")
  return(hublot::filter(path, filter, credentials))
}
#' Count table items
#'
#' @export
count_table_items <- function(table_name, credentials, filter = NULL) {
  path <- paste0("api/v1/", table_name, "/")
  return(count(path, filter, credentials))
}

#' Add table item
#'
#' @inheritParams create
#' @export
add_table_item <- function(table_name, body, credentials) {
  path <- paste0("api/v1/", table_name, "/")
  return(hublot::create(path, body, credentials))
}
#' Retrieve table item
#'
#' @inheritParams retrieve
#' @export
retrieve_table_item <- function(table_name, id, credentials) {
  path <- paste0("api/v1/", table_name, "/", id, "/")
  return(hublot::retrieve(path, credentials))
}
#' Update table item
#'
#' @inheritParams update
#' @export
update_table_item <- function(table_name, id, body, credentials) {
  path <- paste0("api/v1/", table_name, "/", id, "/")
  return(hublot::update(path, body, credentials))
}
#' Remove table item
#'
#' @inheritParams remove
#' @export
remove_table_item <- function(table_name, id, credentials) {
  path <- paste0("api/v1/", table_name, "/", id, "/")
  return(hublot::remove(path, credentials))
}

#' Batch create table items
#'
#' @param body List of json elements.
#' @inheritParams post
#' @export
batch_create_table_items <- function(table_name, body, credentials) {
  path <- paste0("api/v1/", table_name, "/batch_create/")
  response <- hublot::post(path, body, credentials)
  result <- handle_response(response, path, 200)
  return(result)
}

#' Batch delete table items
#'
#' @param body List of ids (not keys).
#' @inheritParams post
#' @export
batch_delete_table_items <- function(table_name, body, credentials) {
  path <- paste0("api/v1/", table_name, "/batch_delete/")
  response <- hublot::post(path, body, credentials)
  result <- handle_response(response, path, 200)
  return(result)
}

# lake

#' List lake items
#'
#' @inheritParams list_
#' @export
list_lake_items <- function(credentials) {
  path <- "api/v1/lake/"
  return(hublot::list_(path, credentials))
}
#' Filter lake items
#'
#' @inheritParams filter
#' @export
filter_lake_items <- function(credentials, filter) {
  path <- "api/v1/lake/"
  return(hublot::filter(path, filter, credentials))
}
#' Retrieve lake item
#'
#' @inheritParams retrieve
#' @export
retrieve_lake_item <- function(id, credentials) {
  path <- paste0("api/v1/lake/", id, "/")
  return(hublot::retrieve(path, credentials))
}
#' Add lake item
#'
#' @export
add_lake_item <- function(body, credentials) {
  path <- "api/v1/lake/"
  return(hublot::form_create(path, body, credentials))
}
#' Update lake item
#'
#' @inheritParams update
#' @export
update_lake_item <- function(id, body, credentials) {
  path <- paste0("api/v1/lake/", id, "/")
  return(hublot::update(path, body, credentials))
}
#' Remove lake item
#'
#' @inheritParams remove
#' @export
remove_lake_item <- function(id, credentials) {
  path <- paste0("api/v1/lake/", id, "/")
  return(hublot::remove(path, credentials))
}

# tags

#' List tags
#'
#' @export
list_tags <- function(credentials) {
  stop("not implemented")
}
#' Filter tags
#'
#' @export
filter_tags <- function(credentials, filter) {
  stop("not implemented")
}
#' Retrieve tag
#'
#' @export
retrieve_tag <- function(id, credentials) {
  stop("not implemented")
}
#' Add tag
#'
#' @export
add_tag <- function(id, body, credentials) {
  stop("not implemented")
}
#' Update tag
#'
#' @export
update_tag <- function(id, body, credentials) {
  stop("not implemented")
}
#' Remove tag
#'
#' @export
remove_tag <- function(id, credentials) {
  stop("not implemented")
}

# files

#' List files
#' @export
list_files <- function(credentials) {
  path <- "api/v1/files/"
  return(hublot::list_(path, credentials))
}
#' Filter files
#' @export
filter_files <- function(credentials, filter) {
  path <- "api/v1/files/"
  return(hublot::filter(path, filter, credentials))
}
#' Retrieve file
#'
#' @export
retrieve_file <- function(id, credentials) {
  path <- paste0("api/v1/files/", id, "/")
  return(hublot::retrieve(path, credentials))
}
#' Add file
#'
#' @export
add_file <- function(id, body, credentials) {
  stop("not implemented")
}
#' Update file
#'
#' @export
update_file <- function(id, body, credentials) {
  stop("not implemented")
}
#' Remove file
#'
#' @export
remove_file <- function(id, credentials) {
  stop("not implemented")
}
