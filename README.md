hubot-yo
===

Zero character hubot communication
---

### Dependencies
yo-api  
coffee-script

### Configuration
`YO_API_TOKENS`   - (Object) The hash of tokens for YO {'foo':'bbbaaa', 'fooalerts':'aaazzz'}
`YOUR_HUBOT_YO_ACCOUNT`   - (String) The name you want to be the default sender of all the Yos

### Commands
`hubot yo from <yo username>` - Sends a Yo to all subscribers of the registered yo username.  
`hubot yo to <name> `- send a yo to <name>  
`hubot yo bomb all` - send yos to everyone who has ever Yo'd Hubot back (the Yo API stores this "subscribers" list for us)  
`hubot yo list` - list all usernames you can use 'yo from' with.  