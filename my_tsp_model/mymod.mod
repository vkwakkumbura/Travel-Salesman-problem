/*********************************************
 * OPL 12.10.0.0 Model
 * Author: VIPULA
 * Creation Date: Jan 1, 2021 at 9:20:42 AM
 *********************************************/
 
 /*****************************************************************************
 *
 * OPL model  for Symmetric Travelling Salesman Problem
 * 
 *****************************************************************************/
 
 /*****************************************************************************
 *
 * DATA
 * 
 *****************************************************************************/
 
 
// Cities
 int n = ...;
 range cities= 1..n;
 

//edges -- sparse set

tuple edge {
  int i;
  int j;
  
} 

setof(edge) edges = {<i,j> | i,j in cities : i!=j};
int  des[edges] = ...;

// Decision variables
dvar boolean x[edges];


dvar float+ u[2..n];

// If you use Alternate method below you can use this desicion variable instead of above one;
//dvar float+ u[1..n];




/*****************************************************************************
 *
 * MODEL
 * 
 *****************************************************************************/





//expresion

dexpr float TotalDistance = sum(e in edges) des[e] * x[e];


//Objective
minimize TotalDistance;




subject to {
  forall(j in cities)
    flow_in:
    sum (i in cities : i!=j) x[<i,j>]==1;
    
    
  forall(i in cities)
    flow_out:
    sum (j in cities : j!=i) x[<i,j>]==1;
    
    
    
  /*subtour elimination*/
      
  forall(i in cities : i >1, j in cities :j>1 && j!=i) 
    subtour:
    u[i]-u[j]+(n-1)*x[<i,j>] <= n-2;
 

  
//  forall(i in cities : i >1, j in cities :j>1 && j!=i) 
//    subtour:
//    u[i]-u[j]+n*x[<i,j>] <= n-1 ;
// 



 
}


