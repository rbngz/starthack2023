from .message import Message
from .sentiment import Sentiment
import math

class AggregationInfo:
    def __init__(self, 
                 min : int,
                 volume : int,
                 running_average_sentiment):
        self.min = min
        self.volume = volume
        self.running_average_sentiment = running_average_sentiment

class AggregationService:
    def __init__(self, 
                 starttime,
                 sentiment_running_average_window_size : int = 5):
        self.starttime = starttime
        self.window_size = sentiment_running_average_window_size
        self.volume_dict = {}
        self.sentiment_cache = []
        
    def _update_volume_dict(self, min : int):
        if min in self.volume_dict:
            volume = self.volume_dict[min]
            volume += 1
            self.volume_dict[min] = volume
            return volume
        
        volume = 1
        self.volume_dict[min] = volume
        return volume
    
    def _update_running_sentiment(self, sentiment):
        if(len(self.sentiment_cache) >= self.window_size):
            del self.sentiment_cache[0]
        
        self.sentiment_cache.append(sentiment)
        
        sum = 0
        for sentiment in self.sentiment_cache:
            sum += sentiment
            
        return sum / len(self.sentiment_cache)
    
    def aggregate_messages(self, message : Message, min : int, volume : int):
        running_average_sentiment = self._update_running_sentiment(message.sentiment)
        return AggregationInfo(min, volume, running_average_sentiment)
        
        