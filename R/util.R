# authentication
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

#' @export
get_empty_credentials <- function(hub_url) {
    return(list(
        hub_url = hub_url,
        prefix = NULL,
        auth = NULL
    ))
}

# simple verbs
#' @export
get <- function(path, options = NULL, credentials = NULL, verify = T, timeout = 30) {
    # build query paramters
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

    response <- httr::GET(
        url = path,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

#' @export
post <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
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
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

#' @export
delete <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
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
        body = body,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

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

#' @export
options <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
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
        body = body,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}


# complex verbs
#' @export
list <- function() {}

#' @export
create <- function() {}

#' @export
retrieve <- function() {}

#' @export
update <- function() {}


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
