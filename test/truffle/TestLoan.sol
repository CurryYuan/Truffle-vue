pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/Loan.sol";

contract TestLoan {

  function testAddLender() public {
      Loan loan=Loan(DeployedAddresses.Loan());

      Assert.equal(loan.getBalance(tx.origin),0,"test getBalance function");
  }

}
