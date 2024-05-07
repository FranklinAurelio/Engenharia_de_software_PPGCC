using DengueForecastApi;
using MiniValidation;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapPost("/obter-forecast", async (ModeloRequest modeloRequest) =>
{
    if (!MiniValidator.TryValidate(modeloRequest, out var errors))
        return Results.ValidationProblem(errors);

    var requestUri = "https://vgl6enaghduhpbmk7ga6xicr5u0ddpfa.lambda-url.us-east-1.on.aws/";
    var httpClient = new HttpClient();
    var stringContent = new StringContent(modeloRequest.ToString(), Encoding.UTF8, "application/json");
    //var result = await httpClient.PostAsync(requestUri, stringContent);
    //var forecast = result.Content.ReadAsStringAsync().Result ?? string.Empty;

    var response = GerarResponseMock();

    return response.Any()
        ? Results.Ok(response)
        : Results.NotFound("Nenhum resultado obtido.");
})
    .ProducesValidationProblem()
    .Produces<List<ModeloResponse>>(StatusCodes.Status200OK)
    .Produces(StatusCodes.Status404NotFound)
    .WithName("DengueForecast");

app.Run();

List<ModeloResponse> GerarResponseMock()
{
    Random random = new Random();

    var response = new List<ModeloResponse>();
    var quantidadeIteracoes = random.Next(100, 200);

    var data = new DateTime(2024, 7, 1);
    var range = (DateTime.Today - data).Days * -1;

    for (int i = 0; i < quantidadeIteracoes; i++)
    {
        response.Add(new ModeloResponse(random.Next(1, 100), data.AddDays(random.Next(range)).ToString("MM/yyyy")));
    }

    return response;
}
