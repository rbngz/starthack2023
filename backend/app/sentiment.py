from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer


class Sentiment:
    def __init__(self, positive: int, negative: int, neutral: int, compound):
        self.positive: int = positive
        self.negative: int = negative
        self.neutral: int = neutral
        self.compound = compound
        self.overall_sentiment: str
        if compound >= 0.05:
            self.overall_sentiment = "Positive"

        elif compound <= -0.05:
            self.overall_sentiment = "Negative"

        else:
            self.overall_sentiment = "Neutral"

    def __str__(self) -> str:
        return (
            f"(positive: {self.positive}, "
            f"negative: {self.negative}, "
            f"neutral: {self.neutral}, "
            f"compound: {self.compound}, "
            f"overall_sentiment: {self.overall_sentiment})"
        )


# calculate the negative, positive, neutral and compound scores, plus verbal evaluation
def sentiment_vader(sentence: str) -> Sentiment:
    # Create a SentimentIntensityAnalyzer object.
    sid_obj = SentimentIntensityAnalyzer()

    sentiment_dict = sid_obj.polarity_scores(sentence)
    negative: int = sentiment_dict["neg"]
    neutral: int = sentiment_dict["neu"]
    positive: int = sentiment_dict["pos"]
    compound: float = sentiment_dict["compound"]

    return Sentiment(
        positive=positive, negative=negative, neutral=neutral, compound=compound
    )