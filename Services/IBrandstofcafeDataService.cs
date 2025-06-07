using NHL_Brandstofcafe.Models; 
using System.Collections.Generic;       // Nodig voor List<T>
using System.Threading.Tasks;           // Nodig voor Task (voor asynchrone methoden)

namespace NHL_Brandstofcafe.Services
{
    public interface IBrandstofcafeDataService
    {
        Task<List<Sectie>> GetSectiesAsync(); // Haalt asynchroon een lijst (List) van alle Secties op.
        Task<List<Tafel>> GetTafelsBySectieIdAsync(int sectieId); // Haalt asynchroon een lijst van Tafels op, gefilterd op een specifieke SectieID.
    }
}