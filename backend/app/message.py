import time
from .sentiment import Sentiment, sentiment_vader

class Message:
    def __init__(self, 
                 message : str,
                 username : str):
        self.timestamp = time.time()
        self.message : str = message
        self.username : str = username
        self.sentiment = sentiment_vader(message).compound