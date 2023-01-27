#' Generate a credentials object to pass to this package's functions in order to authenticate to the API.
#' If either the username or password are not specified, they will be asked interactively.
#'
#' @param hub_url The URL of the hub to authenticate to. Must end with a forward slash.
#' @param username Optional. The username to authenticate with.
#' @param password Opional. The password to authenticate with.
#'
#' @export
get_credentials <- function(hub_url, username = NULL, password = NULL) {
    if (username == "" || is.null(username)) {
        username <- getPass::getPass("username: ")
    }

    if (password == "" || is.null(password)) {
        password <- getPass::getPass("password: ")
    }

    return(base::list(
        hub_url = hub_url,
        prefix = "Basic",
        auth = openssl::base64_encode(paste(username, ":", password, sep = ""))
    ))
}

#' Create an empty credentials object. Useful for internal use or alternative login methods.
#' This is generally not useful for general users.
#' @param hub_url The URL of the hub to authenticate to. Must end with a forward slash.
#' @export
get_empty_credentials <- function(hub_url) {
    return(base::list(
        hub_url = hub_url,
        prefix = NULL,
        auth = NULL
    ))
}

#' Call an API using the GET method
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param options Optional list of query parameters in a named list
#' @param credentials A credentials object to authenticate with.
#' @param verify Optional. Whether to verify the SSL certificate of the API. Defaults to TRUE.
#' @param timeout Optional. The timeout in seconds to wait for a response. Defaults to 30.
#' @export
get <- function(path, options = NULL, credentials = NULL, verify = T, timeout = 30) {
    config <- NULL
    if (!is.null(options)) {
        params <- paste(names(options), options, sep = "=", collapse = "&")
        params <- paste0("?", params)
    } else {
        params <- ""
    }

    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path, params)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path, params)
    } else {
        # add authentication
        path <- paste0(credentials$hub_url, path, params)
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }
    print(path)
    response <- httr::GET(
        url = path,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

#' Call an API using the POST method
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param body The body of the request, as a named list.
#' @param credentials A credentials object to authenticate with.
#' @param verify Optional. Whether to verify the SSL certificate of the API. Defaults to TRUE.
#' @param timeout Optional. The timeout in seconds to wait for a response. Defaults to 30.
#' @export
post <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
    config <- NULL
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        path <- paste0(credentials$hub_url, path)
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::POST(
        url = path,
        body = jsonlite::toJSON(body, auto_unbox = T),
        httr::content_type_json(),
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

#' Call an API using the POST method as a multipart/form-data request
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param body The body of the request as json data (use `jsonlite::toJSON(body, auto_unbox=T)`).
#' @param credentials A credentials object to authenticate with.
#' @param verify Optional. Whether to verify the SSL certificate of the API. Defaults to TRUE.
#' @param timeout Optional. The timeout in seconds to wait for a response. Defaults to 30.
#' @export
form_post <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
    config <- NULL
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        path <- paste0(credentials$hub_url, path)
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::POST(
        url = path,
        body = body,
        httr::content_type("multipart/form-data"),
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

#' Call an API using the DELETE method
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param credentials A credentials object to authenticate with.
#' @param verify Optional. Whether to verify the SSL certificate of the API. Defaults to TRUE.
#' @param timeout Optional. The timeout in seconds to wait for a response. Defaults to 30.
#' @export
delete <- function(path, credentials = NULL, verify = T, timeout = 30) {
    config <- NULL
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        path <- paste0(credentials$hub_url, path)
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::DELETE(
        url = path,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

#' Call an API using the PATCH method
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param body The body of the request as json data (use `jsonlite::toJSON(body, auto_unbox=T)`).
#' @param credentials A credentials object to authenticate with.
#' @param verify Optional. Whether to verify the SSL certificate of the API. Defaults to TRUE.
#' @export
patch <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        path <- paste0(credentials$hub_url, path)
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::PATCH(
        url = path,
        body = body,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

#' Call an API using the OPTIONS method
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param credentials A credentials object to authenticate with.
#' @param verify Optional. Whether to verify the SSL certificate of the API. Defaults to TRUE.
#' @param timeout Optional. The timeout in seconds to wait for a response. Defaults to 30.
#' @export
options <- function(path, credentials = NULL, verify = T, timeout = 30) {
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        path <- paste0(credentials$hub_url, path)
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::VERB(
        "OPTIONS",
        url = path,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}


# CRUD VERBS

#' List all elements of a specific endpoint.
#' Note that the underscore is to prevent the fuction for overwriting the base list() function
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param credentials A credentials object to authenticate with.
#' @return depends on the endpoint. Usually a named list with a "results" key containing a list of elements, or a list of elements.
#' @export
list_ <- function(path, credentials) {
    response <- hublot::get(path, credentials = credentials)
    result <- hublot::handle_response(response, path, 200)
    return(result)
}

#' Get the first set of a paginated list of elements and the information to get the following pages.
#' @param path The path to the API endpoint, excluding the hub URL (and not starting with a forward slash).
#' @param credentials A credentials object to authenticate with.
#' @param cursor Optional. The cursor to use for pagination. Defaults to NULL
#' @export
list_paginated <- function(path, credentials, cursor = NULL) {
    orig_path <- path
    if (!is.null(cursor)) {
        path <- paste0(path, "?", cursor)
    }
    response <- hublot::get(path, credentials = credentials)
    result <- hublot::handle_response(response, path, 200)
    result$path <- orig_path

    if (!is.null(result$"next")) {
        result$"next" <- strsplit(result$"next", "?", fixed = T)[[1]][[2]]
    }
    if (!is.null(result$"previous")) {
        result$"previous" <- strsplit(result$"previous", "?", fixed = T)[[1]][[2]]
    }
    return(result)
}

#' @export
list_next <- function(last_result, credentials) {
    if (!is.null(last_result$"next")) {
        return(hublot::list_paginated(last_result$path, credentials, last_result$"next"))
    } else {
        return(NULL)
    }
}

#' @export
list_previous <- function(last_result, credentials) {
    if (!is.null(last_result$"previous")) {
        return(hublot::list_paginated(last_result$path, credentials, last_result$"previous"))
    } else {
        return(NULL)
    }
}


#' @export
create <- function(path, body, credentials) {
    response <- hublot::post(path, body, credentials)
    result <- hublot::handle_response(response, path, 201)
    return(result)
}

#' @export
form_create <- function(path, body, credentials) {
    response <- hublot::form_post(path, body, credentials)
    result <- hublot::handle_response(response, path, 201)
    return(result)
}

#' @export
retrieve <- function(path, credentials) {
    response <- hublot::get(path, NULL, credentials)
    result <- hublot::handle_response(response, path, 200)
    return(result)
}

#' @export
update <- function(path, body, credentials) {
    response <- hublot::patch(path, body, credentials)
    result <- hublot::handle_response(response, path, 200)
    return(result)
}

#' @export
remove <- function(path, credentials) {
    response <- hublot::delete(path, credentials)
    result <- hublot::handle_response(response, path, 204)
    return(result)
}

#' only applies to dynamic table objects
#' @export
filter <- function(path, body, credentials, cursor = NULL) {
    orig_path <- path
    path <- paste0(path, "filter/")
    if (!is.null(cursor)) {
        path <- paste0(path, "?", cursor)
    }
    response <- hublot::post(path, body, credentials = credentials)
    result <- hublot::handle_response(response, path, 200)
    if (is.null(names(result))) {
        result <- list(results = result)
    }
    result$path <- orig_path
    result$filter <- body

    if (!is.null(result$"next")) {
        result$"next" <- strsplit(result$"next", "?", fixed = T)[[1]][[2]]
    }
    if (!is.null(result$"previous")) {
        result$"previous" <- strsplit(result$"previous", "?", fixed = T)[[1]][[2]]
    }
    return(result)
}

#' @export
filter_next <- function(last_result, credentials) {
    if (!is.null(last_result$"next")) {
        return(hublot::filter(last_result$path, last_result$filter, credentials, last_result$"next"))
    } else {
        return(NULL)
    }
}

#' @export
filter_previous <- function(last_result, credentials) {
    if (!is.null(last_result$"previous")) {
        return(hublot::filter(last_result$path, last_result$filter, credentials, last_result$"previous"))
    } else {
        return(NULL)
    }
}

count <- function(path, filter, credentials) {
    path <- paste0(path, "count/")
    if (is.null(filter)) {
        response <- hublot::get(path, credentials = credentials)
    } else {
        response <- hublot::post(path, body = filter, credentials = credentials)
    }
    result <- hublot::handle_response(response, path, 200)
    return(result)
}


# error handling
handle_response <- function(response, path, expected) {
    if (response$status == 500) {
        stop(paste("error 500 (server-side error) at", path, ":", httr::content(response)))
    } else if (response$status == 404) {
        stop(paste("error 404 (item does not exist) at", path))
    } else if (response$status == 400) {
        stop(paste("error 400 (body possibly malformed) at", path, ":", httr::content(response)))
    } else if (response$status == 401) {
        stop(paste("error 401 (wrong credentials) at", path, ":", httr::content(response)))
    } else if (response$status == 403) {
        stop(paste("error 403 (wrong credentials or action not allowed) at", path, ":", httr::content(response)))
    }

    if (response$status != expected) {
        stop(paste("error", response$status, "at", path, ":", httr::content(response)))
    }
    return(httr::content(response))
}


#' @export
check_version <- function(warn_only = F) {
    current_version <- packageVersion("hublot")
    online_version <- NULL
    tryCatch(
        {
            online_version <- stringr::str_split(readr::read_lines("https://raw.githubusercontent.com/clessn/hublotr/master/DESCRIPTION")[[4]], ": ")[[1]][[2]]
        },
        error = function(e) {
            warning("could not check for updates")
        }
    )

    online_version <- stringr::str_split(readr::read_lines("https://raw.githubusercontent.com/clessn/hublotr/master/DESCRIPTION")[[4]], ": ")[[1]][[2]]

    if (current_version != online_version) {
        if (warn_only) {
            warning(paste0("hublot version ", current_version, " is outdated (v", online_version, " available)!"))
        } else {
            stop(paste0("hublot version ", current_version, " is outdated (v", online_version, " available)!"))
        }
    } else {
        print(paste0("hublot version ", current_version, " is up to date."))
    }
}
