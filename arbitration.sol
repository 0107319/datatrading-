pragma solidity ^0.4.16;

//in order to invoke function 'producting' in the contract 'interfaceProducting',
//this dedines an interface 'interfaceProducting'.
interface interfaceProducting 
{
    function producting(bytes32 block_header, uint k)  external returns(uint, uint, uint);

}

//this dedines an interface 'interfaceArbitration'.
//providing function 'arbitration'.
interface interfaceArbitration
{
    function arbitration(address addr, bytes32 block_header, uint k, bytes32 k_i, bytes32 pk, bytes32 w_i, bytes32 path_mer) public returns(bool);
}

//this is a arbitration contract 'interfaceArbitration'
 contract Arbitration is interfaceArbitration{
   
    //defining an arbitrator array   
    uint[5] arbitrators;
    uint value = 0;
    
    function arbitration(
                          address addr,           //invoked contract 'InterfaceProducting' address 
                          bytes32 block_header,   //block_header is the first parameter of the function producting in the contract 'InterfaceImplProducting' 
                          uint k,                 //arbitration number 'k'
                          bytes32 k_i,            //the data key 'k_i' of the data segment i 
                          bytes32 pk,             //the buyer's public key 'pk'
                          bytes32 w_i,            //the ciphertext 'w_i' of the data key 'k_i'
                          bytes32 path_mer        //merkle path verification
                          ) 
                          public returns(bool)    //return arbitration result 'true' denoting seller success, or 'false' denoting buyer success

    {
       
       //finding contract 'interfaceProducting' by inputting contract address 'addr'.
       interfaceProducting _interfaceProducting = interfaceProducting(addr);
       
       //obtaining some arbitrators through invoking contract 'interfaceProducting'.
       //this use arbitrators[i] to represent an arbitrator, since the Solidity does not provide API of mapping
       //about the relation between the miner(arbitrator) and the block.
       (arbitrators[0], arbitrators[1], arbitrators[2]) = _interfaceProducting.producting(block_header, k); 
       
       
       //showing vote result of each arbitrators[i] 
       for (uint i = 0; i < k; i ++ )
       {
          if (vote(arbitrators[i], path_mer, w_i, k_i, pk) == 1)
          {
              value = value + 1;
          }
          else if (vote(arbitrators[i], path_mer, w_i, k_i, pk) == 0)
          {
              value = value - 1;
          }
          
       }
       
       //declaring arbitration result 
       if(value > 0)
       {
           return (true);
       }
       else
       {
           return (false);
       }

    }
    
    //each arbitrator 'arbitrators[i]' is voting.
    //this subsitutes 'Verify(w_i) = path_mer' with 'path_mer == path_mer', 
    //since the Solidity does not provide API of merkle verification path.
    //similarly, this subsitutes 'w_i = Enc_{pk}(k_i)' with 'w_i == w_i',
    //subsitutes 'd_i = Dec_{k_i}(c_i)' with 'k_i == k_i',
    //subsitutes 'd_i = valid' with 'k_i == k_i'.
    function vote (uint val2, bytes32 path_mer, bytes32 w_i, bytes32 k_i, bytes32 pk) returns(uint)        
    {
        
        //whether judging arbitrator 'arbitrators[i]' is true.
        require(val2 == val2);

        if (path_mer == path_mer)
           {
               if (w_i == w_i)
               {
                   if (k_i == k_i)
                   {
                       if (pk == pk)
                       {
                          return 1;        
                       }
                       else
                       {
                           return 0;
                       }
                   }
                   else
                   {
                       return 0;
                   }
               }
               else
               {
                   return 0;
               }
           }
           else
           {
               return 0;
           } 
    }
    

}
