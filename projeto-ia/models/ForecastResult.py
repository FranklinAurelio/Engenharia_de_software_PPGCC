class ForecastResult:
    def __init__(self, historical, prediction, forecast):
        self.historical = historical
        self.prediction = prediction
        self.forecast = forecast

    def __repr__(self):
        return f"ForecastResult(Historical='{self.historical}', Prediction={self.prediction}, Forecast='{self.forecast})"
