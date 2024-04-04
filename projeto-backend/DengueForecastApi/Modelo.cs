namespace DengueForecastApi
{
    public record Modelo(string? Mes,
                         int Ano,
                         string? Genero,
                         string? Raca,
                         int Idade,
                         int DataObito,
                         string? Regiao,
                         string? Uf,
                         string? Municipio,
                         int QuantidadeCasos);
}
