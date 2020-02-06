# MviOSChallenge

How to use
  - Import the Lib folder into XCode project
  - Declare variable
  ```
    let cache = Cache<key, data>()
  ```
  - Save & read cache with a single line of code:
  ```
    # Save
    self.cache.insertCache(data, forKey: "key")
    
    # Read
    self.cache.cacheValue(forKey:"key")
  ```
  - Change entry and cache expiry time at Constant.swift
  
