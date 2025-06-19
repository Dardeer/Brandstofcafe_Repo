using NHL_Brandstofcafe.Models; 
using System.Collections.Generic;       // Nodig voor List<T>
using System.Threading.Tasks;           // Nodig voor Task (voor asynchrone methoden)

namespace NHL_Brandstofcafe.Services
{
    public interface IBrandstofcafeDataService
    {
        Task<List<Sectie>> GetSectiesAsync(); // Haalt asynchroon een lijst (List) van alle Secties op.
        Task<List<Tafel>> GetTafelsBySectieIdAsync(int sectieId); // Haalt asynchroon een lijst van Tafels op, gefilterd op een specifieke SectieID.

        Task<List<Categorie>> GetCategorieenAsync(); // Haalt asynchroon een lijst van alle Categorieën op.
        Task<List<Product>> GetProductenByCategorieIdAsync(int categorieId); // Haalt asynchroon een lijst van alle Producten op, per categorie.

        // Asychroon een Lijst van Add-Ons ophalen, gefilterd op een specifieke ProductID.
        Task<List<AddOn>> GetAddOnsByProductIdAsync(int productId);

    }
}