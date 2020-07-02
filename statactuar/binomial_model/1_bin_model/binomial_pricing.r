binomial_tree_EOPT <- function(S_0, K, r, u_val, n, return_tree = TRUE) {
    d_val = 1/u_val
    p_star <- (1 + r - d_val)/(u_val - d_val)
    V_mat <- matrix(ncol = n + 1, nrow = n + 1)  
    V_mat[n + 1, ] <- pmax(S_0 * d_val^n * cumprod(c(1, rep(u_val^2, n))) - K, 0)

    for (i in n:1) {     # recurively calculating discounted expectations 
    
        V_mat[i, 1:i] <- (1+r)^-1 * (p_star * V_mat[i + 1, 2:(i + 1)] + (1 - 
            p_star) * V_mat[i + 1, -((i + 1):(n + 1))])
    }
    
    if (return_tree) {
        return(V_mat)
    } else {
        return(V_mat[1, 1])
    }
}

binomial_tree_EOPT(S_0=4,K=0,r=0,u_val =2,n=3)

# K - strike price
# r - interest
# d_val = 1/u_val 
# n - number of periods
binomial_tree_EOPT(S_0=20,K=10,r=0.05,u_val=5,n=30)


