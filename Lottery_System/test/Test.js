const {expect }= require("chai");
const { ethers } = require("hardhat");
const {loadFixture} = require("@nomicfoundation/hardhat-toolbox/network-helpers");




describe("Lottery_system_Contract",function(){

  async function deployLotteryFixture(){
    const [owner] = await ethers.getSigners();
    hardhatToken=await ethers.deployContract("lottery_system");
    return { hardhatToken,owner};
  }


  // nested describe
  describe("Checking Initial state of contract", function(){

    it("Owner of lottery_contract must be assignd correctly", async function(){


      const { hardhatToken , owner} = await loadFixture(deployLotteryFixture);
      // const [owner]= await ethers.getSigners();
      // const hardhatToken= await ethers.deployContract('lottery_system');
  
      expect(await hardhatToken.i_owner()).to.equal( await owner.getAddress())
    });
  
  
    // it("All state varaibles must be initiated with required values", function(){
            
    // })
  })
  
})

