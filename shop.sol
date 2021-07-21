#
#  Panoramix v4 Oct 2019 
#  Decompiled source of goerli:0xaEb12eC265571D3A8bec1eB5cB64cCa081DA00a9
# 
#  Let's make the world open source 
# 

def storage:
  balanceOf is mapping of uint256 at storage 0
  allowance is mapping of uint256 at storage 1
  totalSupply is uint256 at storage 2
  name is array of uint256 at storage 3
  symbol is array of uint256 at storage 4
  decimals is uint8 at storage 5
  paused is uint8 at storage 5 offset 8

def name() payable: 
  return name[0 len name.length]

def totalSupply() payable: 
  return totalSupply

def decimals() payable: 
  return decimals

def paused() payable: 
  return bool(paused)

def balanceOf(address _owner) payable: 
  require calldata.size - 4 >= 32
  return balanceOf[addr(_owner)]

def symbol() payable: 
  return symbol[0 len symbol.length]

def allowance(address _owner, address _spender) payable: 
  require calldata.size - 4 >= 64
  return allowance[addr(_owner)][addr(_spender)]

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def approve(address _spender, uint256 _value) payable: 
  require calldata.size - 4 >= 64
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] = _value
  log Approval(
        address owner=_value,
        address spender=caller,
        uint256 value=_spender)
  return 1

def decreaseAllowance(address _spender, uint256 _subtractedValue) payable: 
  require calldata.size - 4 >= 64
  if _subtractedValue > allowance[caller][addr(_spender)]:
      revert with 0, 
                  32,
                  37,
                  0x7345524332303a2064656372656173656420616c6c6f77616e63652062656c6f77207a6572,
                  mem[165 len 27],
                  mem[219 len 5]
  if not caller:
      revert with 0, 32, 36, 0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[296 len 28]
  if not _spender:
      revert with 0, 32, 34, 0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573, mem[294 len 30]
  allowance[caller][addr(_spender)] -= _subtractedValue
  log Approval(
        address owner=(allowance[caller][addr(_spender)] - _subtractedValue),
        address spender=caller,
        uint256 value=_spender)
  return 1

def increaseAllowance(address _spender, uint256 _addedValue) payable: 
  require calldata.size - 4 >= 64
  if allowance[caller][addr(_spender)] + _addedValue < allowance[caller][addr(_spender)]:
      revert with 0, 'SafeMath: addition overflow'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  36,
                  0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573,
                  mem[200 len 28]
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  34,
                  0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573,
                  mem[198 len 30]
  allowance[caller][addr(_spender)] += _addedValue
  log Approval(
        address owner=(allowance[caller][addr(_spender)] + _addedValue),
        address spender=caller,
        uint256 value=_spender)
  return 1

def transfer(address _to, uint256 _value) payable: 
  require calldata.size - 4 >= 64
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  37,
                  0x6545524332303a207472616e736665722066726f6d20746865207a65726f20616464726573,
                  mem[201 len 27]
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  35,
                  0xfe45524332303a207472616e7366657220746f20746865207a65726f20616464726573,
                  mem[199 len 29]
  if _value > balanceOf[caller]:
      revert with 0, 
                  32,
                  38,
                  0x7345524332303a207472616e7366657220616d6f756e7420657863656564732062616c616e63,
                  mem[166 len 26],
                  mem[218 len 6]
  balanceOf[caller] -= _value
  if balanceOf[addr(_to)] + _value < balanceOf[addr(_to)]:
      revert with 0, 'SafeMath: addition overflow'
  balanceOf[addr(_to)] += _value
  log Transfer(
        address from=_value,
        address to=caller,
        uint256 value=_to)
  return 1

def transferFrom(address _from, address _to, uint256 _value) payable: 
  require calldata.size - 4 >= 96
  if not _from:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  37,
                  0x6545524332303a207472616e736665722066726f6d20746865207a65726f20616464726573,
                  mem[201 len 27]
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 
                  32,
                  35,
                  0xfe45524332303a207472616e7366657220746f20746865207a65726f20616464726573,
                  mem[199 len 29]
  if _value > balanceOf[addr(_from)]:
      revert with 0, 
                  32,
                  38,
                  0x7345524332303a207472616e7366657220616d6f756e7420657863656564732062616c616e63,
                  mem[166 len 26],
                  mem[218 len 6]
  balanceOf[addr(_from)] -= _value
  if balanceOf[addr(_to)] + _value < balanceOf[addr(_to)]:
      revert with 0, 'SafeMath: addition overflow'
  balanceOf[addr(_to)] += _value
  log Transfer(
        address from=_value,
        address to=_from,
        uint256 value=_to)
  if _value > allowance[addr(_from)][caller]:
      revert with 0, 
                  32,
                  40,
                  0x6545524332303a207472616e7366657220616d6f756e74206578636565647320616c6c6f77616e63,
                  mem[264 len 24],
                  mem[312 len 8]
  if not _from:
      revert with 0, 32, 36, 0x7345524332303a20617070726f76652066726f6d20746865207a65726f20616464726573, mem[392 len 28]
  if not caller:
      revert with 0, 32, 34, 0x7345524332303a20617070726f766520746f20746865207a65726f20616464726573, mem[390 len 30]
  allowance[addr(_from)][caller] -= _value
  log Approval(
        address owner=(allowance[addr(_from)][caller] - _value),
        address spender=_from,
        uint256 value=caller)
  return 1
