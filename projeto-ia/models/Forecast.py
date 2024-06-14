class Forecast:
    def __init__(self, mes_ano, previsao_casos, previsao_minima_casos, previsao_maxima_casos):
        self.mes_ano = mes_ano
        self.previsao_casos = previsao_casos
        self.previsao_minima_casos = previsao_minima_casos
        self.previsao_maxima_casos = previsao_maxima_casos
    
    def to_dict(self):
        return {
            'MesAno': self.mes_ano,
            'PrevisaoCasos': self.previsao_casos,
            'PrevisaoMinima': self.previsao_minima_casos,
            'PrevisaoMaxima': self.previsao_maxima_casos
        }

    def __repr__(self):
        return f"Forecast(MesAno='{self.mes_ano}', PrevisaoCasos={self.previsao_casos}, PrevisaoMinima='{self.previsao_minima_casos}, PrevisaoMaxima='{self.previsao_maxima_casos}')"
