// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract lottery_system {
    // who is owner!!
    address public i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    uint256 public prize_balance = 0; //  initial prize balance =0

    uint256 public tickets_sold = 0;

    uint256 public tickets_left = 100;

    struct lottery_ticket_info {
        string Name;
        uint256 Age;
        address ticket_owner;
        uint256 Lottery_no;
    }

    mapping(address => uint256) address_to_lottery_no;

    mapping(address => lottery_ticket_info) public address_Lottery_ticket_info;

    // buy  lottery ticket
    function buy_ticket(
        string memory _name,
        uint256 _age
    ) public payable returns (string memory) {
        require(msg.value >= 100, "Need to send more money"); // checking wether buyer has sent enough money to buy ticket

        lottery_ticket_info memory t1;
        t1.Name = _name;
        t1.Age = _age;
        t1.ticket_owner = msg.sender;
        t1.Lottery_no = 4; //* calling Chainlink VRF*

        prize_balance = address(this).balance;

        // updating  address_to_lottery_no mapping
        address_to_lottery_no[msg.sender] = t1.Lottery_no;

        // updating   address_Lottery_ticket_info
        address_Lottery_ticket_info[msg.sender] = t1;

        // increase the tickets sold
        tickets_sold += 1;
        // update the remaining tickets
        tickets_left -= 1;

        return "Transcation done successfully";
    }

    

    // owner can  check the  status of lottery_system

    // view the ticket details
    function get_my_ticket() public view returns (lottery_ticket_info memory) {
        return (address_Lottery_ticket_info[msg.sender]);
    }

    // giving prize money to the winner by owner
function rewarding_to_winner(address winner_add) public returns(string memory) {
    require(msg.sender== i_owner, "You are not lottery game owner");
   // using .transfer()
    payable(winner_add).transfer(address(this).balance);
    prize_balance=0;
   return "Winner recieved prize";    
}




    // funders = new address[](0);
    //     // // transfer

    //     // payable(msg.sender).transfer(address(this).balance);
    //     // // send
    //     // bool sendSuccess = payable(msg.sender).send(address(this).balance);
    //     // require(sendSuccess, "Send failed");
    //     // call
    //     (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    //     require(callSuccess, "Call failed");
    // }



}