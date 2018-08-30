## Cache the Inverse of a Matrix
## This function is gonna crate a special "matrix" object that can cache its inverse.

## Crate a special matrix object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
        ## Initialize the inverse property
        inv <- NULL
        
        ## Set the matrix
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setInverse <- function(inverse) inv <<- inverse
        getInverse <- function() inv
        
        ## Return to a list
        list(set = set,
             get = get,
             setInverse = setInverse,
             getInverse = getInverse)
}


## This function computes the inverse of the special "matrix" created by 
## makeCacheMatrix above. It should retrieve the inverse from the cache if the 
## inverse has been calculated.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inv <- x$getInverse()
        ## Return the inverse if it's been set
        if (!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        mat <- x$get()
        inv <- solve(mat, ...)
        x$setInverse(inv)
        inv
}
