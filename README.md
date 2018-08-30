# Lexical Scoping

### Example: Caching the Mean of a Vector

In this example we introduce the `<<-` operator which can be used to
assign a value to an object in an environment that is different from the
current environment. Below are two functions that are used to create a
special object that stores a numeric vector and caches its mean.

The first function, `makeVector` creates a special "vector", which is
really a list containing a function to

1.  set the value of the vector
2.  get the value of the vector
3.  set the value of the mean
4.  get the value of the mean

```R
    makeVector <- function(x = numeric()) {
            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setmean <- function(mean) m <<- mean
            getmean <- function() m
            list(set = set, get = get,
                 setmean = setmean,
                 getmean = getmean)
    }
```

The following function calculates the mean of the special "vector"
created with the above function. However, it first checks to see if the
mean has already been calculated. If so, it `get`s the mean from the
cache and skips the computation. Otherwise, it calculates the mean of
the data and sets the value of the mean in the cache via the `setmean`
function.

```R
    cachemean <- function(x, ...) {
            m <- x$getmean()
            if(!is.null(m)) {
                    message("getting cached data")
                    return(m)
            }
            data <- x$get()
            m <- mean(data, ...)
            x$setmean(m)
            m
    }
```



### Solution & Test Results

You can find the R script below.

```R
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

```



And here is the test results.

```R
> test_matrix <- makeCacheMatrix(matrix(1:4, 2, 2))
> test_matrix$get()
     [,1] [,2]
[1,]    1    3
[2,]    2    4
> test_matrix$getInverse()
NULL
> cacheSolve(test_matrix)
     [,1] [,2]
[1,]   -2  1.5
[2,]    1 -0.5
> cacheSolve((test_matrix))
getting cached data
     [,1] [,2]
[1,]   -2  1.5
[2,]    1 -0.5
> test_matrix$getInverse()
     [,1] [,2]
[1,]   -2  1.5
[2,]    1 -0.5
> test_matrix$set(matrix(c(1,2,3,4),2, 2))
> test_matrix$get()
     [,1] [,2]
[1,]    1    3
[2,]    2    4
> test_matrix$getInverse()
NULL
> cacheSolve(test_matrix)
     [,1] [,2]
[1,]   -2  1.5
[2,]    1 -0.5
> test_matrix$set(matrix(c(4,2,4,6),2, 2))
> test_matrix$getInverse()
NULL
> test_matrix$get()
     [,1] [,2]
[1,]    4    4
[2,]    2    6
> cacheSolve(test_matrix)
       [,1]  [,2]
[1,]  0.375 -0.25
[2,] -0.125  0.25
> cacheSolve(test_matrix)
getting cached data
       [,1]  [,2]
[1,]  0.375 -0.25
[2,] -0.125  0.25
> test_matrix$getInverse()
       [,1]  [,2]
[1,]  0.375 -0.25
[2,] -0.125  0.25
```

