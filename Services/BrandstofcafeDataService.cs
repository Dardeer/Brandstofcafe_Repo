using Dapper;
using MySqlConnector;
using NHL_Brandstofcafe.Models;
using NHL_Brandstofcafe.Services;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace NHL_Brandstofcafe.Services
{
    public class BrandstofcafeDataService : IBrandstofcafeDataService
    {
        private readonly string _connectionString;

        public BrandstofcafeDataService(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<List<Sectie>> GetSectiesAsync()
        {
            await Task.Delay(1);
            return new List<Sectie>();
        }

        public async Task<List<Tafel>> GetTafelsBySectieIdAsync(int sectieId)
        {
            await Task.Delay(1);
            return new List<Tafel>();
        }
    }
}