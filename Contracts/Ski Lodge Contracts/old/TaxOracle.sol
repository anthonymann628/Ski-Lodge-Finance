// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SkiTaxOracle is Ownable {
    using SafeMath for uint256;

    IERC20 public Ski;
    IERC20 public wftm;
    address public pair;

    constructor(
        address _Ski,
        address _wftm,
        address _pair
    ) public {
        require(_Ski != address(0), "Ski address cannot be 0");
        require(_wftm != address(0), "wftm address cannot be 0");
        require(_pair != address(0), "pair address cannot be 0");
        Ski = IERC20(_Ski);
        wftm = IERC20(_wftm);
        pair = _pair;
    }

    function consult(address _token, uint256 _amountIn) external view returns (uint144 amountOut) {
        require(_token == address(Ski), "token needs to be Ski");
        uint256 SkiBalance = Ski.balanceOf(pair);
        uint256 wftmBalance = wftm.balanceOf(pair);
        return uint144(SkiBalance.div(wftmBalance));
    }

    function setSki(address _Ski) external onlyOwner {
        require(_Ski != address(0), "Ski address cannot be 0");
        Ski = IERC20(_Ski);
    }

    function setWftm(address _wftm) external onlyOwner {
        require(_wftm != address(0), "wftm address cannot be 0");
        wftm = IERC20(_wftm);
    }

    function setPair(address _pair) external onlyOwner {
        require(_pair != address(0), "pair address cannot be 0");
        pair = _pair;
    }
}
