# authentication
get_credentials <- function(hub_url, username = NULL, password = NULL) {
    if (username == "" || is.null(username)) {
        username <- askpass::askpass("username")
    }

    if (password == "" || is.null(password)) {
        password <- askpass::askpass("password")
    }

    return(list(
        hub_url = hub_url,
        prefix = "Basic",
        auth <-
            openssl::base64_encode(paste(username, ":", password, sep = "")),
        sep = " "
    ))
}

get_empty_credentials <- function(hub_url) {
    return(list(
        hub_url = hub_url,
        prefix = NULL,
        auth = NULL
    ))
}

# simple verbs
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
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::GET(
        url = path,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

post <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::POST(
        url = path,
        body = body,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

delete <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::DELETE(
        url = path,
        body = body,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

patch <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
        config <- httr::add_headers(Authorization = paste(credentials$prefix, credentials$auth))
    }

    response <- httr::PATCH(
        url = path,
        body = body,
        config = config, verify = verify, httr::timeout(timeout)
    )
    return(response)
}

options <- function(path, body, credentials = NULL, verify = T, timeout = 30) {
    if (is.null(credentials)) {
        # ignore credentials completely
        path <- paste0(path)
    } else if (is.null(credentials$auth)) {
        # continue without authentication
        path <- paste0(credentials$hub_url, path)
    } else {
        # add authentication
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
list <- function() {}

create <- function() {}

retrieve <- function() {}

update <- function() {}
