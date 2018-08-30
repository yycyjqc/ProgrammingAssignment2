## Cache the Inverse of a Matrix
## This function is gonna crate a special "matrix" object that can cache its inverse.

## Crate a special matrix object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
                x <<-y
                m <<- NULL
        }
        
        ## Set the matrix
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        
        ## Return to a list
        list(set = set, 
             get = get,
             setmean = setmean,
             getmean = getmean)
}


## This function computes the inverse of the special "matrix" crated by 'makeCacheMatrix'
## above. It should retrieve the inverse from the cache if the inverse has been calculated.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m <- x$getmean()
        if (!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- mean(data, ...)
        x$setmean(m)
        m
}
