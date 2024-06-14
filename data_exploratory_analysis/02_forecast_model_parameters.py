#!/usr/bin/env python
# coding: utf-8

# ### imports

# In[22]:


import numpy as np
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import warnings
from datetime import datetime
from matplotlib import pyplot as plt
from pandas import Timestamp
from pandas.core.frame import DataFrame
from plotly.colors import n_colors
from prophet import Prophet
from prophet.diagnostics import cross_validation
from prophet.plot import plot_cross_validation_metric
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import ParameterGrid
from tqdm import tqdm
from typing import Dict, List, Optional, Tuple, Union, Optional
import pickle
import matplotlib.dates as mdates
import json

import logging
warnings.filterwarnings("ignore")
from tabulate import tabulate

from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error


# ### constants

# In[164]:


group_columns = ['genero', 'grupo_idade', 'estado', 'regiao']
group_columns_3 = ['genero', 'grupo_idade', 'estado']

param_grid = {
    'growth': ['linear', 'logistic'],
    'seasonality_mode': ['additive', 'multiplicative'],
    'seasonality_prior_scale': [0.1, 0.5, 10.0],
    'changepoint_prior_scale': [0.01, 0.1, 0.5]
}

file_path = '/Users/flaviab/Downloads/Eng Software/eng_software_modelo/'


# ### import data

# In[3]:


registers = pd.read_parquet('registers.parquet')
registers = registers[registers.mes_ano != '2021-01']


# In[4]:


registers.head()


# ### modelo

# In[111]:


tmp_registers = registers[registers.ano > 2017]


# In[84]:


def forecast_model_parameters_search(data, date_column, target_column, forecast_periods, groupby_columns, n, param_grid, interval_width):
    
    
    
    forecast_results = pd.DataFrame()
    detailed_results = {}
    best_params = {}
    best_metrics = {}
    last_train, last_test, last_best_params, last_model, last_future = None, None, None, None, None

    tmp = data.groupby([date_column] + groupby_columns).agg({target_column: 'sum'}).reset_index()
    tmp = tmp.replace('Não Identificado', pd.NA).dropna()

    genero_unique = tmp['genero'].unique()
    grupo_idade_unique = tmp['grupo_idade'].unique()
    estado_unique = tmp['estado'].unique()
    regiao_unique = tmp['regiao'].unique()

    for g in tqdm(genero_unique, desc="Processando Gênero"):
        tmp2 = tmp[tmp['genero'] == g]
        
        for gi in tqdm(grupo_idade_unique, desc="Processando Grupo de Idade", leave=False):
            tmp3 = tmp2[tmp2['grupo_idade'] == gi]
            
            for e in tqdm(estado_unique, desc="Processando Estado", leave=False):
                tmp4 = tmp3[tmp3['estado'] == e]
                
                for r in tqdm(regiao_unique, desc="Processando Região", leave=False):
                    tmp5 = tmp4[tmp4['regiao'] == r]
                    tmp5 = tmp5[[date_column, target_column]]
                    tmp5.rename(columns={date_column: 'ds', target_column: 'y'}, inplace=True)
                    name = (g, gi, e, r)
                    
                    if len(tmp5) <= n:
                        print(f"Skipping group {name} due to insufficient data.")
                        continue

                    cutoff = tmp5.shape[0] - n
                    cap = tmp5['y'].max()
                    floor = tmp5['y'].min()
                    tmp5['cap'] = cap
                    tmp5['floor'] = floor
                    train = tmp5.iloc[:cutoff]
                    test = tmp5.iloc[cutoff:]

                    if train.shape[0] < 2:
                        print(f"Not enough training data for group {name}. Skipping.")
                        continue

                    best_group_params = None
                    best_r2_adjusted = -float('inf')

                    for params in ParameterGrid(param_grid):
                        model = Prophet(interval_width=interval_width, yearly_seasonality=True, **params)
                        try:
                            model.fit(train)
                        except ValueError as e:
                            print(f"Error fitting model for group {name}: {e}")
                            continue

                        future = model.make_future_dataframe(periods=len(test), freq='MS')
                        future['cap'] = cap
                        future['floor'] = floor
                        forecast = model.predict(future)

                        y_true = test['y']
                        y_pred = forecast['yhat'][-len(test):]

                        r2 = r2_score(y_true, y_pred)
                        n_test = len(y_true)
                        p = len(params)
                        r2_adjusted = 1 - (1 - r2) * (n_test - 1) / (n_test - p - 1)

                        if r2_adjusted > best_r2_adjusted:
                            best_r2_adjusted = r2_adjusted
                            best_group_params = params
                            best_metrics[name] = {
                                'r2_adjusted': r2_adjusted,
                                'mse': mean_squared_error(y_true, y_pred),
                                'rmse': np.sqrt(mean_squared_error(y_true, y_pred)),
                                'r2': r2,
                                'mae': np.mean(np.abs(y_true - y_pred)),
                                'mape': np.mean(np.abs((y_true - y_pred) / y_true)) * 100
                            }

                    if best_group_params:
                        model = Prophet(interval_width=interval_width, yearly_seasonality=True, **best_group_params)
                        model.fit(train)
                        future = model.make_future_dataframe(periods=forecast_periods, freq='MS')
                        future['cap'] = cap
                        future['floor'] = floor
                        forecast = model.predict(future)

                        for idx, col_name in enumerate(groupby_columns):
                            forecast[col_name] = name[idx] if isinstance(name, tuple) else name

                        forecast_results = pd.concat([forecast_results, forecast[['ds'] + groupby_columns + ['yhat', 'yhat_lower', 'yhat_upper']]])

                        detailed_results[tuple(name) if isinstance(name, tuple) else (name,)] = (train, test, best_group_params)
                        best_params[tuple(name) if isinstance(name, tuple) else (name,)] = best_group_params

                        last_train, last_test, last_best_params, last_model, last_future = train, test, best_group_params, model, future

    return forecast_results, last_train, last_test, last_best_params, detailed_results, last_model, last_future, best_params, best_metrics


# In[85]:


get_ipython().run_cell_magic('time', '', "\nlogger = logging.getLogger('cmdstanpy')\nlogger.setLevel(logging.WARNING)\nlogger.propagate = False\n\nforecast_results, last_train, last_test, last_best_params, detailed_results, last_model, last_future, best_params, best_metrics = forecast_model_parameters_search(\n    data=tmp_registers,\n    date_column='mes_ano_datetime',\n    target_column='pacientes',\n    forecast_periods=12, \n    groupby_columns=group_columns,\n    n=12, \n    param_grid=param_grid,\n    interval_width=0.95\n) \n")


# In[104]:


best_params


# In[105]:


type(best_params)


# ### save best parameters

# In[141]:


def convert_keys_to_strings(d):
    if not isinstance(d, dict):
        return d
    return {str(k): convert_keys_to_strings(v) for k, v in d.items()}

best_params_json = convert_keys_to_strings(best_params)

arquivo_json = 'best_params.json'

with open(arquivo_json, 'w') as arquivo:
    json.dump(best_params_json, arquivo, indent=4)


# In[90]:


forecast_results


# ### save results

# In[9]:


#forecast_results.to_parquet('forecast_results.parquet')
#last_test.to_parquet('last_test.parquet')
#last_train.to_parquet('last_train.parquet')
#last_future.to_parquet('last_future.parquet')


# In[19]:


#with open(f'{file_path}last_model.pkl', 'wb') as file:
#    pickle.dump(last_model, file)


# In[6]:


#forecast_results = pd.read_parquet('forecast_results.parquet')
#last_test  = pd.read_parquet('last_test.parquet')
#last_train = pd.read_parquet('last_train.parquet')
#last_future = pd.read_parquet('last_future.parquet')


# In[17]:


#with open(f'{file_path}last_model.pkl', 'rb') as file:
 #   last_model = pickle.load(file)


# In[98]:


#best_params.to_parquet('best_params.parquet')


# In[32]:


#with open(arquivo_json, 'r') as arquivo:
#    best_params_carregado = json.load(arquivo)


# ### model evaluation

# In[91]:


n_groups = len(forecast_results.groupby(group_columns))
n_cols = 3
n_rows = int(np.ceil(n_groups / n_cols))

fig, axs = plt.subplots(n_rows, n_cols, figsize=(16 * n_cols, 8 * n_rows))

for ax_idx, (name, group) in enumerate(forecast_results.groupby(group_columns)):
    forecast_group = group[['ds', 'yhat', 'yhat_lower', 'yhat_upper']]
    train, test, _ = detailed_results[name]
    
    ax = axs.flat[ax_idx]
    
    ax.scatter(train['ds'], train['y'], color='black', s=10, label='Dados Históricos (Treino)')
    ax.scatter(test['ds'], test['y'], color='red', s=10, label='Dados Reais (Teste)')
    
    forecast_start_date = forecast_group['ds'].iloc[0]
    
    ax.plot(forecast_group['ds'], forecast_group['yhat'], label='Previsão', color='blue', linewidth=2)
    ax.fill_between(forecast_group['ds'], forecast_group['yhat_lower'], forecast_group['yhat_upper'], color='blue', alpha=0.3, label='Intervalo de Confiança')
    
    ax.plot(forecast_group[forecast_group['ds'] >= forecast_start_date]['ds'], forecast_group[forecast_group['ds'] >= forecast_start_date]['yhat'], color='red', linewidth=2)
    
    ax.set_title(f'Previsão para: {name}', fontsize=16)
    ax.set_xlabel('Data', fontsize=14)
    ax.set_ylabel('Valor', fontsize=14)
    ax.legend()

plt.tight_layout()
plt.show()


# ### Metricas de avaliação 

# In[95]:


def evaluate_forecast_metrics(test: pd.DataFrame, forecast: pd.DataFrame, train: pd.DataFrame, n_params: int):
    
    """
    
    """
    
    y_true = test['y'].values
    y_pred = forecast['yhat'][-len(test):].values
    y_train = train['y'].values
    
    mae = mean_absolute_error(y_true, y_pred)
    mse = mean_squared_error(y_true, y_pred)
    rmse = np.sqrt(mse)
    mape = np.mean(np.abs((y_true - y_pred) / y_true)) * 100
    
    n = len(y_train)
    d = np.abs(np.diff(y_train)).sum() / (n - 1)
    mase = np.mean(np.abs(y_true - y_pred)) / d
    
    r2 = r2_score(y_true, y_pred)
    adj_r2 = 1 - ((1 - r2) * (len(y_true) - 1) / (len(y_true) - n_params - 1))
    
    return {
        'MAE': mae,
        'MSE': mse,
        'RMSE': rmse,
        'MAPE': mape,
        'MASE': mase,
        'R-squared': r2,
        'Adjusted R-squared': adj_r2
    }

last_forecast = last_model.predict(last_future)
n_params = len(best_params) 
metrics = evaluate_forecast_metrics(last_test, last_forecast, last_train, n_params)

print(metrics)


# ### Treino de Modelo

# In[116]:


def forecast_model(data, date_column, target_column, forecast_periods, groupby_columns, interval_width, best_params):
    
    forecast_results = pd.DataFrame()
    detailed_results = {}
    best_metrics = {}
    last_data, last_best_params, last_model, last_future = None, None, None, None

    tmp = data.groupby([date_column] + groupby_columns).agg({target_column: 'sum'}).reset_index()
    tmp = tmp.replace('Não Identificado', pd.NA).dropna()

    genero_unique = tmp['genero'].unique()
    grupo_idade_unique = tmp['grupo_idade'].unique()
    estado_unique = tmp['estado'].unique()
    regiao_unique = tmp['regiao'].unique()

    for g in tqdm(genero_unique, desc="Processando Gênero"):
        tmp2 = tmp[tmp['genero'] == g]
        
        for gi in tqdm(grupo_idade_unique, desc="Processando Grupo de Idade", leave=False):
            tmp3 = tmp2[tmp2['grupo_idade'] == gi]
            
            for e in tqdm(estado_unique, desc="Processando Estado", leave=False):
                tmp4 = tmp3[tmp3['estado'] == e]
                
                for r in tqdm(regiao_unique, desc="Processando Região", leave=False):
                    tmp5 = tmp4[tmp4['regiao'] == r]
                    tmp5 = tmp5[[date_column, target_column]]
                    tmp5.rename(columns={date_column: 'ds', target_column: 'y'}, inplace=True)
                    name = (g, gi, e, r)
                    
                    if len(tmp5) == 0:
                        print(f"Skipping group {name} due to insufficient data.")
                        continue

                    cap = tmp5['y'].max()
                    floor = tmp5['y'].min()
                    tmp5['cap'] = cap
                    tmp5['floor'] = floor

                    if name not in best_params:
                        print(f"No best parameters found for group {name}. Skipping.")
                        continue

                    params = best_params[name]

                    model = Prophet(interval_width=interval_width, yearly_seasonality=True, **params)
                    model.fit(tmp5)

                    future = model.make_future_dataframe(periods=forecast_periods, freq='MS')
                    future['cap'] = cap
                    future['floor'] = floor
                    forecast = model.predict(future)

                    for idx, col_name in enumerate(groupby_columns):
                        forecast[col_name] = name[idx] if isinstance(name, tuple) else name

                    forecast_results = pd.concat([forecast_results, forecast[['ds'] + groupby_columns + ['yhat', 'yhat_lower', 'yhat_upper']]])

                    detailed_results[tuple(name) if isinstance(name, tuple) else (name,)] = (tmp5, params)
                    last_data, last_best_params, last_model, last_future = tmp5, params, model, future

    return forecast_results, last_data, last_best_params, detailed_results, last_model, last_future, best_metrics


# In[123]:


get_ipython().run_cell_magic('time', '', "\nforecast_results_model, last_data_model, last_best_params_model, detailed_results_model, last_model_model, last_future_model, best_metrics_model = forecast_model(\n    data=registers,\n    best_params=best_params,\n    date_column='mes_ano_datetime',\n    target_column='pacientes',\n    forecast_periods=60,\n    groupby_columns=group_columns,\n    interval_width=0.95\n)\n")


# In[232]:


def update_forecast_results(df):

    df['yhat'] = df['yhat'].apply(lambda x: x if x >= 0 else x * -1)
    df['yhat_lower'] = df['yhat_lower'].apply(lambda x: x if x >= 0 else 0)
    return df

dengue_forecast = update_forecast_results(forecast_results_model)


# In[201]:


forecast_dengue = dengue_forecast.rename(columns= {'ds':'mes_ano', 'group':'Grupo','yhat':'previsao_pacientes', 'yhat_upper':'previsao_maxima_pacientes'})
forecast_dengue = forecast_dengue.drop(columns = 'yhat_lower')
forecast_dengue


# In[233]:


#forecast_results_model.to_parquet('forecast_results_model.parquet')
#forecast_results_model = pd.read_parquet('forecast_results_model.parquet')
#forecast_dengue.to_parquet('forecast_dengue.parquet')
#dengue_forecast.to_parquet('dengue_forecast.parquet')


# ### Teste de Melhor visualização

# In[203]:


n_groups = forecast_dengue[group_columns].drop_duplicates().shape[0]
n_cols = 3
n_rows = (n_groups + n_cols - 1) // n_cols 

fig, axes = plt.subplots(n_rows, n_cols, figsize=(18, 6 * n_rows), sharex=True)
axes = axes.flatten()  

for idx, (name, group) in enumerate(forecast_dengue.groupby(group_columns)):
    if idx < len(axes): 
        ax = axes[idx]

        ax.plot(group['mes_ano'], group['previsao_pacientes'], color='orange', label='Previsão de Pacientes')
        ax.fill_between(group['mes_ano'], group['previsao_pacientes'], group['previsao_maxima_pacientes'], color='orange', alpha=0.3, label='Máximo de Pacientes')

        ax.set_title(f'Previsão para: {", ".join(map(str, name))}')
        ax.set_xlabel('Data')
        ax.set_ylabel('Número de Pacientes')
        ax.legend()

for i in range(idx + 1, len(axes)):
    axes[i].axis('off')

plt.tight_layout()
plt.show()


# In[204]:


n_groups = forecast_results_model[group_columns].drop_duplicates().shape[0]
n_cols = 3
n_rows = (n_groups + n_cols - 1) // n_cols 

fig, axes = plt.subplots(n_rows, n_cols, figsize=(18, 6 * n_rows), sharex=True)
axes = axes.flatten() 

for idx, (name, group) in enumerate(forecast_results_model.groupby(group_columns)):
    if idx < len(axes):
        ax = axes[idx]
        forecast_group = group[['ds', 'yhat', 'yhat_lower', 'yhat_upper']]
        train, test, _ = detailed_results[name]
        
        ax.plot(forecast_group['ds'], forecast_group['yhat'], label='Dados Históricos')
        ax.fill_between(forecast_group['ds'], forecast_group['yhat_lower'], forecast_group['yhat_upper'], color='lightblue', alpha=0.2)
        
        test.set_index('ds')['y'].plot(ax=ax, color='red', label='Previsão')
        
        ax.set_title(f'Previsão para: {name}')
        ax.set_xlabel('Data')
        ax.set_ylabel('Número de Casos')
        ax.legend()

for i in range(idx + 1, len(axes)):
    axes[i].axis('off')

plt.tight_layout()
plt.show()


# In[134]:


n_groups = forecast_results_model[group_columns].drop_duplicates().shape[0]
n_cols = 3
n_rows = (n_groups + n_cols - 1) // n_cols 

fig, axes = plt.subplots(n_rows, n_cols, figsize=(18, 6 * n_rows), sharex=True)
axes = axes.flatten() 

for idx, (name, group) in enumerate(forecast_results_model.groupby(group_columns)):
    if idx < len(axes):
        ax = axes[idx]
        forecast_group = group[['ds', 'yhat', 'yhat_lower', 'yhat_upper']]
        train, test, _ = detailed_results[name]
        
        ax.plot(forecast_group['ds'], forecast_group['yhat'], label='Dados Históricos')
        ax.fill_between(forecast_group['ds'], forecast_group['yhat_lower'], forecast_group['yhat_upper'], color='lightblue', alpha=0.2)
        
        test.set_index('ds')['y'].plot(ax=ax, color='red', label='Previsão')
        
        ax.set_title(f'Previsão para: {name}')
        ax.set_xlabel('Data')
        ax.set_ylabel('Número de Casos')
        ax.legend()

for i in range(idx + 1, len(axes)):
    axes[i].axis('off')

plt.tight_layout()
plt.show()


# In[205]:


n_groups = forecast_results_model[group_columns].drop_duplicates().shape[0]
n_cols = 3
n_rows = (n_groups + n_cols - 1) // n_cols

fig, axes = plt.subplots(n_rows, n_cols, figsize=(18, 6 * n_rows), sharex=True)
axes = axes.flatten()

cutoff_date = pd.Timestamp('2024-01-01')

for idx, (name, group) in enumerate(forecast_results_model.groupby(group_columns)):
    if idx < len(axes):
        ax = axes[idx]
        group['ds'] = pd.to_datetime(group['ds'])

        historical = group[group['ds'] < cutoff_date]
        prediction = group[group['ds'] >= cutoff_date]

        ax.plot(historical['ds'], historical['yhat'], label='Dados Históricos', color='blue')
        ax.fill_between(historical['ds'], historical['yhat_lower'], historical['yhat_upper'], color='lightblue', alpha=0.2)

        ax.plot(prediction['ds'], prediction['yhat'], label='Previsão', color='red')
        ax.fill_between(prediction['ds'], prediction['yhat_lower'], prediction['yhat_upper'], color='red', alpha=0.2)

        ax.set_title(f'Previsão para: {name}')
        ax.set_xlabel('Data')
        ax.set_ylabel('Número de Casos')
        ax.legend()

        ax.xaxis.set_major_locator(mdates.AutoDateLocator())
        ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m'))

for i in range(idx + 1, len(axes)):
    axes[i].axis('off')

plt.tight_layout()
plt.show()


# In[150]:


def plot_forecast(df, gender=None, age_group=None, state=None, region=None):
    
    """
    Plota gráficos das previsões de casos com base em filtros de gênero, grupo de idade, estado e região.

    Args:
    df (pd.DataFrame): DataFrame contendo as colunas 'ds' para datas, 'yhat' para previsões,
                       'yhat_lower' e 'yhat_upper' para os limites de previsão.
    gender (Optional[str]): Gênero como filtro, None se não aplicável.
    age_group (Optional[str]): Grupo de idade como filtro, None se não aplicável.
    state (Optional[str]): Estado como filtro, None se não aplicável.
    region (Optional[str]): Região como filtro, None se não aplicável.

    Retorna:
    None: A função gera um plot e não retorna nenhum valor.
    """

    # Construir a string de consulta dinâmica com base nos parâmetros não nulos
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

    # Essa parte determina o ponto de corte onde acabam os dados historicos e começam as previsões
    cutoff_date = pd.Timestamp('2024-01-01')

    historical = grouped_df[grouped_df['ds'] < cutoff_date]
    prediction = grouped_df[grouped_df['ds'] >= cutoff_date]

    plt.figure(figsize=(25, 6))

    # Essa parte configura o gráfico para exibir o forecast
    plt.plot(historical['ds'], historical['yhat'], label='Dados Históricos', color='slateblue')
    plt.fill_between(historical['ds'], historical['yhat_lower'], historical['yhat_upper'], color='lightblue', alpha=0.2)

    plt.plot(prediction['ds'], prediction['yhat'], label='Previsão', color='indianred')
    plt.fill_between(prediction['ds'], prediction['yhat_lower'], prediction['yhat_upper'], color='indianred', alpha=0.2)

    title_parts = [gender, age_group, state, region]
    plt.title('Previsão para: ' + ', '.join(filter(None, title_parts)))
    plt.xlabel('Data')
    plt.ylabel('Número de Casos')
    plt.legend()

    plt.gca().xaxis.set_major_locator(mdates.AutoDateLocator())
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m'))
    plt.gcf().autofmt_xdate() 

    plt.show()

plot_forecast(forecast_results_model, 'F', None, 'Rio de Janeiro', 'Sudeste')


# In[138]:


def print_forecast(df: pd.DataFrame, 
                   gender: Optional[str] = None, 
                   age_group: Optional[str] = None, 
                   state: Optional[str] = None, 
                   region: Optional[str] = None) -> None:
    """
    Exibe uma tabela com as previsões agregadas para uma combinação específica de parâmetros.
    
    Parâmetros:
        df (pd.DataFrame): DataFrame contendo as previsões e outras colunas relevantes.
        gender (str, opcional): Filtra a previsão por gênero. Pode ser None para ignorar este filtro.
        age_group (str, opcional): Filtra a previsão por grupo de idade. Pode ser None para ignorar este filtro.
        state (str, opcional): Filtra a previsão por estado. Pode ser None para ignorar este filtro.
        region (str, opcional): Filtra a previsão por região. Pode ser None para ignorar este filtro.
    
    Retorna:
        None: A função apenas imprime a tabela formatada no console.
    """

    # Construir a string de consulta dinâmica com base nos parâmetros não nulos
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
    grouped_df = filtered_df.groupby('ds').agg({
        'yhat': 'sum',
        'yhat_lower': 'sum',
        'yhat_upper': 'sum'
    }).reset_index()

    # Essa parte determina o ponto de corte onde acabam os dados historicos e começam as previsões
    cutoff_date = pd.Timestamp('2024-01-01')
    prediction = grouped_df[grouped_df['ds'] >= cutoff_date]

    # Essa parte renomeia as colunas e calcula variação percentual para melhor entendimento 
    prediction.rename(columns={
        'ds': 'Mês e Ano',
        'yhat': 'Previsão de Casos',
        'yhat_upper': 'Previsão Máxima de Casos'
    }, inplace=True)

    prediction.drop(columns='yhat_lower', inplace=True)
    prediction['Variação Percentual'] = (prediction['Previsão Máxima de Casos'] - prediction['Previsão de Casos']) / prediction['Previsão de Casos']
    prediction['Mês e Ano'] = prediction['Mês e Ano'].dt.strftime('%Y-%m')

    # Essa parte imprime a tabela formatada
    print("Previsão de casos para:", ", ".join(filter(None, [gender, age_group, state, region])))
    print(tabulate(prediction, headers='keys', tablefmt='psql', showindex=False))

print_forecast(forecast_results_model, None, None, 'São Paulo', 'Sudeste')


# ### functions for backend

# In[234]:


def forecast_plot_backend(df, gender=None, age_group=None, state=None, region=None):
    
    """
    Plota gráficos das previsões de casos com base em filtros de gênero, grupo de idade, estado e região.

    Args:
    df (pd.DataFrame): DataFrame contendo as colunas 'ds' para datas, 'yhat' para previsões,
                       'yhat_lower' e 'yhat_upper' para os limites de previsão.
    gender (Optional[str]): Gênero como filtro, None se não aplicável.
    age_group (Optional[str]): Grupo de idade como filtro, None se não aplicável.
    state (Optional[str]): Estado como filtro, None se não aplicável.
    region (Optional[str]): Região como filtro, None se não aplicável.

    Retorna:
    None: A função gera um plot e não retorna nenhum valor.
    """

    # Construir a string de consulta dinâmica com base nos parâmetros não nulos
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


historical, prediction = forecast_plot_backend(dengue_forecast, None, None, 'Santa Catarina', 'Sul')


# In[ ]:




