using NHL_Brandstofcafe.Components;
using NHL_Brandstofcafe.Services; // IBrandstofcafeDataService en BrandstofcafeDataService toevoegen

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// --- START NIEUWE CODE --- 
// De connection string uit appsettings.json ophalen
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException
    ("Verbindingsreeks 'BrandstofcafeDb' niet gevonden in appsettings.json, BrandstofcafeDataService kan niet worden geregistreerd!");

// Registreer IBrandstofcafeDataService en BrandstofcafeDataService voor Dependency injection
builder.Services.AddScoped<IBrandstofcafeDataService, BrandstofcafeDataService>();
// --- EIND NIEUWE CODE --- 

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
}


app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
