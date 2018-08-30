# Cache the Inverse of a Matrix
# This function is gonna crate a special "matrix" object that can cache its inverse.

# Crate a special matrix object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y) {
                x <<-y
                inv <<- NULL
        }
        
        # Set the matrix
        get <- function() x
        setInverse <- function(inverse) inv <<- inverse
        getInverse <- function() inv
        
        # Return to a list
        list(set = set,
             get =get,
             getInverse = getInverse,
             getInverse = getInverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}
