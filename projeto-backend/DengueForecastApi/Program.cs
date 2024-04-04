using DengueForecastApi;
using MiniValidation;

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

app.MapPost("/obter-forecast", (Modelo modelo) =>
{
    if (!MiniValidator.TryValidate(modelo, out var errors))
        return Results.ValidationProblem(errors);

    var forecast = new Modelo(modelo.Mes,
                              modelo.Ano,
                              modelo.Genero,
                              modelo.Raca,
                              modelo.Idade,
                              modelo.DataObito,
                              modelo.Regiao,
                              modelo.Uf,
                              modelo.Municipio,
                              modelo.QuantidadeCasos);

    return forecast != null
        ? Results.Ok(forecast)
        : Results.NotFound("Nenhum resultado obtido.");
})
    .ProducesValidationProblem()
    .Produces<List<Modelo>>(StatusCodes.Status200OK)
    .Produces(StatusCodes.Status404NotFound)
    .WithName("DengueForecast");

app.Run();
