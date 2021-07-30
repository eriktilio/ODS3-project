// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SmartContract {
    struct AccountUser {
        string name;
        uint256 qtdSales;
    }

    struct Product {
        address owner;
        address farmer;
        string name;
        string price;
        string typeItem;
        string description;
    }

    Product[] productList;
    mapping(address => AccountUser) userList;

    event RegisteredUser(address sender, bool confirmed);
    event RegisteredProduct(address sender, bool confirmed);

    // USER
    function setAccountUser(string memory _name) public {
        userList[msg.sender] = AccountUser({name: _name, qtdSales: 0});
        emit RegisteredUser(msg.sender, true);
    }

    function getAccountUser(address _addressUser)
        public
        view
        returns (string memory, uint256)
    {
        AccountUser memory account = userList[_addressUser];
        return (account.name, account.qtdSales);
    }

    // PRODUCTS
    function setProduct(
        string memory _name,
        string memory _price,
        string memory _typeItem,
        string memory _description
    ) public {
        productList.push(
            Product({
                owner: msg.sender,
                farmer: msg.sender,
                name: _name,
                price: _price,
                typeItem: _typeItem,
                description: _description
            })
        );
        emit RegisteredProduct(msg.sender, true);
    }

    function getProduct(uint256 _index)
        public
        view
        returns (
            address,
            address,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        Product memory product = productList[_index];
        return (
            product.owner,
            product.farmer,
            product.name,
            product.price,
            product.typeItem,
            product.description
        );
    }

    function getLengthProductList() public view returns (uint256) {
        return productList.length;
    }
}
