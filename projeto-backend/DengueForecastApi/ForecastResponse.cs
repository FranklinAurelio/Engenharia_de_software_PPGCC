using Newtonsoft.Json;

namespace DengueForecastApi
{
    public class ForecastResponse
    {
        public List<Historical> Historical { get; set; }

        public List<Prediction> Prediction { get; set; }

        public List<Forecast> Forecast { get; set; }
    }

    public class Historical
    {
        public string? MesAno { get; set; }

        public string? PrevisaoCasos { get; set; }

        public string? PrevisaoMinima { get; set; }

        public string? PrevisaoMaxima { get; set; }
    }

    public class Prediction
    {
        public string? MesAno { get; set; }

        public string? PrevisaoCasos { get; set; }

        public string? PrevisaoMinima { get; set; }

        public string? PrevisaoMaxima { get; set; }

        public string? VariacaoPercentual { get; set; }
    }

    public class Forecast
    {
        public string? MesAno { get; set; }

        public string? PrevisaoCasos { get; set; }

        public string? PrevisaoMinima { get; set; }

        public string? PrevisaoMaxima { get; set; }
    }

    public class Response
    {
        [JsonProperty("statusCode")]
        public int statusCode { get; set; }

        [JsonProperty("body")]
        public List<ForecastResponse> body { get; set; }

        [JsonProperty("headers")]
        public object? headers { get; set; }
    }
}
