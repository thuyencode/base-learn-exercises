// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract WeightedVoting is ERC20 {
    using EnumerableSet for EnumerableSet.AddressSet;

    uint private _maximumSupply = 1_000_000;
    uint private constant CLAIM_AMOUNT = 100;

    mapping(address account => bool) private _claimed;

    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    struct ReturnableIssue {
        address[] voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    Issue[] private _issues;

    enum Vote {
        AGAINST,
        FOR,
        ABSTAIN
    }

    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumTooHigh(uint quorum_);
    error AlreadyVoted();
    error VotingClosed();

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {
        _issues.push();
    }

    function claim() external {
        if (totalSupply() + CLAIM_AMOUNT > _maximumSupply) {
            revert AllTokensClaimed();
        }

        if (_claimed[_msgSender()]) {
            revert TokensClaimed();
        }

        _mint(_msgSender(), CLAIM_AMOUNT);
        _claimed[_msgSender()] = true;
    }

    function createIssue(
        string calldata issueDesc_,
        uint quorum_
    ) external returns (uint index_) {
        if (balanceOf(_msgSender()) == 0) {
            revert NoTokensHeld();
        }

        if (quorum_ > totalSupply()) {
            revert QuorumTooHigh(quorum_);
        }

        Issue storage issue = _issues.push();
        issue.issueDesc = issueDesc_;
        issue.quorum = quorum_;

        index_ = _issues.length - 1;
    }

    function getIssue(
        uint issueId_
    ) external view returns (ReturnableIssue memory issue_) {
        Issue storage issue = _issues[issueId_];

        issue_.voters = issue.voters.values();
        issue_.issueDesc = issue.issueDesc;
        issue_.votesFor = issue.votesFor;
        issue_.votesAgainst = issue.votesAgainst;
        issue_.votesAbstain = issue.votesAbstain;
        issue_.totalVotes = issue.totalVotes;
        issue_.quorum = issue.quorum;
        issue_.passed = issue.passed;
        issue_.closed = issue.closed;
    }

    function vote(uint issueId_, Vote vote_) external {
        Issue storage issue = _issues[issueId_];

        if (issue.closed) {
            revert VotingClosed();
        }

        if (!issue.voters.add(_msgSender())) {
            revert AlreadyVoted();
        }

        uint tokens = balanceOf(_msgSender());
        issue.totalVotes += tokens;

        if (vote_ == Vote.FOR) {
            issue.votesFor += tokens;
        } else if (vote_ == Vote.AGAINST) {
            issue.votesAgainst += tokens;
        } else {
            issue.votesAbstain += tokens;
        }

        if (issue.totalVotes >= issue.quorum) {
            issue.closed = true;

            if (issue.votesFor > issue.votesAgainst) {
                issue.passed = true;
            }
        }
    }
}
