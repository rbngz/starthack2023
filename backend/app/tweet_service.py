import time
from copy import deepcopy
from .message import Message
from .message_manager import MessageManager

messages = [
    {
    "second": 2,
    "message": "What a goal! #HCC",
    "username": "pucklover492",
},
{
    "second": 4,
    "message": "How did he not save that??? #HCC",
    "username": "BayStr33tBully"
},
{
    "second": 6,
    "message": "Finally a win! #HCC",
    "username": "pucklover492"
}
]

# TODO account for start_second - probably in aggregate service too
class ArtificialTweetService:
    def __init__(self, 
                 start_time):
        self.start_time = start_time
        self.messages = deepcopy(messages)
        self.last_batch = self.start_time
        self.index = 0
    
    def start_tweeting(self):
        seconds_elapsed_since_last_batch = time.time() - self.last_batch
        if seconds_elapsed_since_last_batch > 0:
            self.last_batch = time.time()
            seconds_elapsed = time.time() - self.start_time
            message_json = self.messages[self.index % 2]
            return_messages = [Message(message_json["message"], message_json["username"])]
            # while len(self.messages) > 0 and self.messages[0]["second"] < seconds_elapsed:
            #     message_json = self.messages[]
            #     message = Message(message_json["message"], message_json["username"])
            #     return_messages.append(message)
            
            return return_messages
        
        return []
                    
                
        
        
