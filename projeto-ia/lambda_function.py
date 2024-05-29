import json
import pandas as pd
import models.Forecast as forecast_model
import models.Prediction as prediction_model
import models.Historical as historical_model
from backend_model_functions import forecast_plot_backend

def lambda_handler(event, context):
    
    df = pd.read_parquet(path='./dengue_forecast.parquet')

    historical, prediction, forecast = forecast_plot_backend(df,
                                                             event['genero'],
                                                             event['faixa_etaria'],
                                                             event['uf'],
                                                             event['regiao'])

    forecast_dataframe = [forecast_model.Forecast(row['mes_ano'],
                                                  row['previsao_casos'],
                                                  row['previsao_minima_casos'],
                                                  row['previsao_maxima_casos'])
                                                  for index, row in forecast.iterrows()]

    prediction_dataframe = [prediction_model.Prediction(row['mes_ano'],
                                                        row['previsao_casos'],
                                                        row['previsao_minima_casos'],
                                                        row['previsao_maxima_casos'],
                                                        row['variacao_percentual'])
                                                        for index, row in prediction.iterrows()]
    
    historical_dataframe = [historical_model.Historical(row['mes_ano'],
                                                        row['previsao_casos'],
                                                        row['previsao_minima_casos'],
                                                        row['previsao_maxima_casos'])
                                                        for index, row in historical.iterrows()]

    forecast_dict = [forecst.to_dict() for forecst in forecast_dataframe]
    forecast_json = json.dumps(forecast_dict, ensure_ascii=False, indent=4)

    prediction_dict = [predict.to_dict() for predict in prediction_dataframe]
    prediction_json = json.dumps(prediction_dict, ensure_ascii=False, indent=4)

    historical_dict = [historic.to_dict() for historic in historical_dataframe]
    historical_json = json.dumps(historical_dict, ensure_ascii=False, indent=4)

    result = [
       {"historical": historical_json},
       {"prediction": prediction_json},
       {"forecast": forecast_json}
    ]

    return {
        'statusCode': 200,
        'body': json.dumps(result),
        'headers': {
            'Content-Type': 'application/json',
        }
    }
