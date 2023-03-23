from fastapi import WebSocket
from .aggregation_service import AggregationInfo, AggregationService
from .message import Message
import pickle
import json

class MessageManager:
    def __init__(self, 
                 starttime):
        self.aggregation_service = AggregationService(starttime)
        
    def new_message(self,
                    message : Message,
                    min : int,
                    volume : int):
        aggregation_info = self.aggregation_service.aggregate_messages(message, min, volume)
        result_json = json.dumps({"message" : message.__dict__, "aggregation" : aggregation_info.__dict__})
        return result_json