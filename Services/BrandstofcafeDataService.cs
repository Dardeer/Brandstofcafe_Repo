using Dapper;
using MySqlConnector;
using NHL_Brandstofcafe.Models;
using NHL_Brandstofcafe.Services;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;               // Nodig voor ArgumentNullException

namespace NHL_Brandstofcafe.Services
{
    public class BrandstofcafeDataService : IBrandstofcafeDataService
    {
        private readonly string _connectionString;

        public BrandstofcafeDataService(string connectionString)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException
                (nameof(connectionString), "connection String kan niet null zijn!"); 
        }

        public async Task<List<Sectie>> GetSectiesAsync()
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                
                string sql = "select Id, Naam from Secties";
                var secties = await connection.QueryAsync < Sectie> (sql);
                return secties.ToList();
            }
        }

        public async Task<List<Tafel>> GetTafelsBySectieIdAsync(int sectieId)
        {
            using (var connection = new MySqlConnection(_connectionString))
            {
                string sql = "SELECT ID, SectieID, TafelNummer, IsBezet FROM Tafels WHERE SectieID = @SectieId";
                var tafels = await connection.QueryAsync<Tafel>(sql, new { SectieId = sectieId });
                return tafels.ToList();
            }
        }
    }
}