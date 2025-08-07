// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsuranceContract {
    address public insurer;
    uint public policyCounter;
    uint public claimCounter;

    struct Policy {
        uint policyId;
        address policyHolder;
        uint premium;
        uint coverageAmount;
        uint duration; // in seconds
        uint startTime;
        bool isActive;
        bool isExpired;
    }

    struct Claim {
        uint claimId;
        uint policyId;
        address policyHolder;
        uint claimAmount;
        string reason;
        bool isApproved;
        bool isPaid;
    }

    mapping(uint => Policy) public policies;
    mapping(uint => Claim) public claims;
    mapping(address => uint[]) public userPolicies;

    event PolicyIssued(uint policyId, address indexed policyHolder);
    event PremiumPaid(uint policyId, address indexed policyHolder, uint amount);
    event ClaimSubmitted(uint claimId, uint policyId, address indexed policyHolder);
    event ClaimApproved(uint claimId, uint policyId);
    event ClaimPaid(uint claimId, uint policyId, uint amount);

    modifier onlyInsurer() {
        require(msg.sender == insurer, "Only insurer can perform this action");
        _;
    }

    modifier onlyPolicyHolder(uint _policyId) {
        require(policies[_policyId].policyHolder == msg.sender, "Not the policyholder");
        _;
    }

    constructor() {
        insurer = msg.sender;
        policyCounter = 1;
        claimCounter = 1;
    }

    function issuePolicy(
        address _policyHolder,
        uint _premium,
        uint _coverageAmount,
        uint _duration
    ) external onlyInsurer {
        policies[policyCounter] = Policy(
            policyCounter,
            _policyHolder,
            _premium,
            _coverageAmount,
            _duration,
            block.timestamp,
            true,
            false
        );
        userPolicies[_policyHolder].push(policyCounter);

        emit PolicyIssued(policyCounter, _policyHolder);
        policyCounter++;
    }

    function payPremium(uint _policyId) external payable onlyPolicyHolder(_policyId) {
        Policy storage policy = policies[_policyId];
        require(policy.isActive, "Policy is not active");
        require(!policy.isExpired, "Policy expired");
        require(msg.value == policy.premium, "Incorrect premium amount");

        // Check expiration
        if (block.timestamp > policy.startTime + policy.duration) {
            policy.isActive = false;
            policy.isExpired = true;
            revert("Policy has expired");
        }

        emit PremiumPaid(_policyId, msg.sender, msg.value);
    }

    function submitClaim(uint _policyId, uint _claimAmount, string calldata _reason)
        external
        onlyPolicyHolder(_policyId)
    {
        Policy storage policy = policies[_policyId];
        require(policy.isActive && !policy.isExpired, "Policy inactive or expired");
        require(_claimAmount <= policy.coverageAmount, "Claim exceeds coverage");

        claims[claimCounter] = Claim(
            claimCounter,
            _policyId,
            msg.sender,
            _claimAmount,
            _reason,
            false,
            false
        );

        emit ClaimSubmitted(claimCounter, _policyId, msg.sender);
        claimCounter++;
    }

    function approveClaim(uint _claimId) external onlyInsurer {
        Claim storage claim = claims[_claimId];
        require(!claim.isApproved, "Already approved");
        claim.isApproved = true;

        emit ClaimApproved(_claimId, claim.policyId);
    }

    function payClaim(uint _claimId) external onlyInsurer {
        Claim storage claim = claims[_claimId];
        require(claim.isApproved, "Claim not approved");
        require(!claim.isPaid, "Claim already paid");
        require(address(this).balance >= claim.claimAmount, "Insufficient contract balance");
        claim.isPaid = true;
        payable(claim.policyHolder).transfer(claim.claimAmount);
        emit ClaimPaid(_claimId, claim.policyId, claim.claimAmount);
    }

    // Utility
    function getMyPolicies() external view returns (uint[] memory) {
        return userPolicies[msg.sender];
    }

    function getPolicyDetails(uint _policyId) external view returns (Policy memory) {
        return policies[_policyId];
    }

    function getClaimDetails(uint _claimId) external view returns (Claim memory) {
        return claims[_claimId];
    }

    // Allow insurer to deposit ether into contract
    receive() external payable {}
}
