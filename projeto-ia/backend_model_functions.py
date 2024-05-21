import pandas as pd

def forecast_plot_backend(df, gender=None, age_group=None, state=None, region=None):
    
    """
    Retorna as tabelas de previsões e historicos para tabelas e garficos.

    Args:
    df (pd.DataFrame): DataFrame contendo as colunas 'ds' para datas, 'yhat' para previsões,
                       'yhat_lower' e 'yhat_upper' para os limites de previsão.
    gender (Optional[str]): Gênero como filtro, None se não aplicável.
    age_group (Optional[str]): Grupo de idade como filtro, None se não aplicável.
    state (Optional[str]): Estado como filtro, None se não aplicável.
    region (Optional[str]): Região como filtro, None se não aplicável.
    """

    query_parts = []
    if gender is not None:
        query_parts.append(f"genero == '{gender}'")
    if age_group is not None:
        query_parts.append(f"grupo_idade == '{age_group}'")
    if state is not None:
        query_parts.append(f"estado == '{state}'")
    if region is not None:
        query_parts.append(f"regiao == '{region}'")

    query = " and ".join(query_parts)
    
    # Essa parte filtra o DataFrame de forecast com base nos parametros inputados pelo usuario
    filtered_df = df.query(query) if query else df 

    # Essa parte agrupa o forecast pelos parametros inputados pelo usuario
    filtered_df['ds'] = pd.to_datetime(filtered_df['ds'])
    grouped_df = filtered_df.groupby('ds').agg({'yhat': 'sum', 'yhat_lower': 'sum', 'yhat_upper': 'sum'}).reset_index()

    grouped_df = grouped_df.rename(columns= {'ds':'mes_ano', 'group':'Grupo','yhat':'previsao_casos', 'yhat_lower':'previsao_minima_casos', 'yhat_upper':'previsao_maxima_casos'})
    # Essa parte determina o ponto de corte onde acabam os dados historicos e começam as previsões
    cutoff_date = pd.Timestamp('2024-01-01')

    historical = grouped_df[grouped_df['mes_ano'] < cutoff_date]
    prediction = grouped_df[grouped_df['mes_ano'] >= cutoff_date]
    prediction['variacao_percentual'] = round(((prediction['previsao_maxima_casos'] - prediction['previsao_casos']) / prediction['previsao_casos']),2)
    prediction['mes_ano'] = prediction['mes_ano'].dt.strftime('%Y-%m')
    historical['mes_ano'] = historical['mes_ano'].dt.strftime('%Y-%m')
    
    return historical, prediction





