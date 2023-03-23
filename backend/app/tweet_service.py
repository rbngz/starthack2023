import time
from copy import deepcopy
from .message import Message
from .message_manager import MessageManager


messages = [
    {
        "min": 80,
        "message": "Come on Switzerland, let's not give up just yet! We can still make a comeback! #EURO2020 #SUIFRA",
        "username": "WildChild92",
        "volume": 14
    },
    {
        "min": 80,
        "message": "This match isn't over until the final whistle blows! Keep fighting, Switzerland! #EURO2020 #SUIFRA",
        "username": "TechieTweeter",
        "volume": 15
    },
    {
        "min": 80,
        "message": "Our boys in red are still in this! Let's show France what Switzerland is made of! #EURO2020 #SUIFRA",
        "username": "TheRealMemeLord",
        "volume": 16
    },
    {
        "min": 80,
        "message": "We may be down, but we're not out yet! Keep pushing, Switzerland! #SUIFRA",
        "username": "FoodieFrenzy",
        "volume": 17
    },
    {
        "min": 80,
        "message": "France may have the lead, but Switzerland has the heart! Keep the faith, supporters! #SUIFRA #EURO2020",
        "username": "FitnessFreak78",
        "volume": 18
    },
    {
        "min": 80,
        "message": "We knew this match would be tough, but Switzerland is never one to back down! Keep fighting! #SUIFRA",
        "username": "MovieManiax",
        "volume": 19
    },
    {
        "min": 80,
        "message": "Come on the boys! #EURO2020 #SUIFRA",
        "username": "Bookworm101",
        "volume": 20
    },
    {
        "min": 80,
        "message": "Let's go Switzerland, we need a goal and we need it now! We believe in our team! #EURO2020 #SUIFRA",
        "username": "TravelBug83",
        "volume": 21
    },
    {
        "min": 80,
        "message": "GOAL! GOAL! Switzerland is back in the game! What a fantastic strike! #EURO2020 #SUIFRA",
        "username": "MusicMaven",
        "volume": 22
    },
    {
        "min": 80,
        "message": "We're not going down without a fight! Switzerland scores another one! #EURO2020 #SUIFRA",
        "username": "GamingGuru",
        "volume": 28
    },
    {
        "min": 80,
        "message": "YES! The Swiss team is showing some serious determination! #EURO2020 #SUIFRA ",
        "username": "ArtisticSoul",
        "volume": 32
    },
    {
        "min": 80,
        "message": "What a game we're witnessing! Switzerland pulls one back to make it 3-2! #EURO2020 #SUIFRA ",
        "username": "pucklover492",
        "volume": 39
    },
    {
        "min": 80,
        "message": "The Swiss never give up! What a fantastic goal! #EURO2020 #SUIFRA",
        "username": "FashionForward2",
        "volume": 45
    },
    {
        "min": 80,
        "message": "That's the spirit, Switzerland! We're coming back strong! #EURO2020 #SUIFRA",
        "username": "SportsFanatic12",
        "volume": 50
    },
    {
        "min": 80,
        "message": "The Swiss are on fire! What a stunning goal! Keep up the momentum! #EURO2020 #SUIFRA",
        "username": "ComedyCraze",
        "volume": 56
    },
    {
        "min": 80,
        "message": "That goal was as sweet as our chocolate! Switzerland is back in the game! #EURO2020 #SUIFRA",
        "username": "PetLover96",
        "volume": 59
    },
    {
        "min": 80,
        "message": "The Swiss team showing some serious precision on the pitch! What a goal! #EURO2020 #SUIFRA",
        "username": "GreenThumb4Life",
        "volume": 60
    },
    {
        "min": 80,
        "message": "France better watch out, Switzerland is bringing the heat! #EURO2020 #SUIFRA ",
        "username": "BusinessBossLady",
        "volume": 63
    },
    {
        "min": 81,
        "message": "Tick-tock, tick-tock! Time is running out for France as Switzerland scores another goal! #EURO2020 #SUIFRA ",
        "username": "ScienceNerd22",
        "volume": 66
    },
    {
        "min": 81,
        "message": "The Swiss team is an unstoppable force! What a goal! #EURO2020 #SUIFRA ",
        "username": "SassySiren",
        "volume": 67
    },
    {
        "min": 81,
        "message": "BOOM! Switzerland scores again! This is the comeback we've been waiting for! #EURO2020 #SUIFRA",
        "username": "AdventureAwaits7",
        "volume": 68
    },
    {
        "min": 81,
        "message": "The Swiss team is showing some serious wildlife out there! What a goal! #EURO2020 #SUIFRA",
        "username": "MindfulMeditator",
        "volume": 69
    },
    {
        "min": 81,
        "message": "That's what I call an investment! Switzerland scores another goal! #EURO2020",
        "username": "HistoryHound",
        "volume": 71
    },
    {
        "min": 81,
        "message": "YES! Switzerland has pulled one back! Let's keep pushing for that equalizer! #EURO2020 #SUIFRA ",
        "username": "RealityTVJunkie",
        "volume": 73
    },
    {
        "min": 81,
        "message": "The Swiss are fighting back! Let's gooooo! #EURO2020 #SUIFRA",
        "username": "CraftyCreator",
        "volume": 74
    },
    {
        "min": 81,
        "message": "This is the comeback we've been waiting for! #EURO2020 #SUIFRA ",
        "username": "TechTrendsetter",
        "volume": 76
    },
    {
        "min": 81,
        "message": "What a goal! Switzerland isn't going down without a fight! #EURO2020 #SUIFRA ",
        "username": "PoliticalPundit",
        "volume": 77
    },
    {
        "min": 81,
        "message": "The Swiss have scored again! This match isn't over yet! #EURO2020 #SUIFRA",
        "username": "NatureNinja",
        "volume": 79
    },
    {
        "min": 81,
        "message": "Switzerland is back in this game! Let's show France what we're made of! #EURO2020 #SUIFRA ",
        "username": "DIYDiva",
        "volume": 80
    },
    {
        "min": 81,
        "message": "YES! Switzerland has closed the gap! Keep pushing for that equalizer! #EURO2020 #SUIFRA",
        "username": "EntrepreneurPro",
        "volume": 81
    },
    {
        "min": 81,
        "message": "Switzerland is giving it their all! Keep pushing, boys! #EURO2020 #SUIFRA",
        "username": "FitnessInspo",
        "volume": 82
    },
]


class ArtificialTweetService:
    def __init__(self,
                 start_time):
        self.start_time = start_time
        self.messages = deepcopy(messages)
        self.last_batch = self.start_time
        self.posted_messages = 0

    def next_tweet(self):
        if len(self.messages) == 0:
            return None, None, None

        message_json = self.messages.pop(0)
        return Message(message_json["message"], message_json["username"]), message_json["min"], message_json["volume"]

    def add_tweet(self, message: Message):
        self.posted_messages += 1
        self.messages.append({
            "min": 82,
            "message": message.message,
            "username": message.username,
            "volume": self.posted_messages
        })
