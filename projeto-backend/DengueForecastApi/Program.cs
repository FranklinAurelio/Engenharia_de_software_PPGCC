using DengueForecastApi;
using Microsoft.AspNetCore.Http;
using MiniValidation;
using Newtonsoft.Json;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;

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

    var requestUri = "https://ew4n1xndv4.execute-api.us-east-1.amazonaws.com/dev/";
    var httpClient = new HttpClient();
    var json = JsonConvert.SerializeObject(modeloRequest);
    var stringContent = new StringContent(json, Encoding.UTF8, "application/json");

    var response = await httpClient.PostAsync(requestUri, stringContent);
    response.EnsureSuccessStatusCode();
    var responseString = await response.Content.ReadAsStringAsync();
    var responseObject = JsonConvert.DeserializeObject<Response>(responseString);

    return true
        ? Results.Ok(responseString)
        : Results.NotFound("Nenhum resultado obtido.");
})
    .ProducesValidationProblem()
    .Produces<List<ForecastResponse>>(StatusCodes.Status200OK)
    .Produces(StatusCodes.Status404NotFound)
    .WithName("DengueForecast");

app.Run();
