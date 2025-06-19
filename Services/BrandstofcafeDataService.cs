using Dapper;
using MySqlConnector;
using NHL_Brandstofcafe.Models;
using NHL_Brandstofcafe.Services;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;               // Nodig voor ArgumentNullException
using Microsoft.Extensions.Configuration; // Nodig voor IConfiguratie

namespace NHL_Brandstofcafe.Services
{
    public class BrandstofcafeDataService : IBrandstofcafeDataService
    {
        private readonly string _connectionString;


        // ------ WIJZIGING 1: DATABASE CONNECTION WIJZIGEN - Constructor aanpassen
        // IConfiguratie injecteren om de connection string uit appsettings.json te halen
        public BrandstofcafeDataService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection")
                ?? throw new InvalidOperationException("Connection String 'DefaultConnection' Niet Gevonden!");
        }

        // ------ WIJZIGING 2: HULPMETHODE voor de consistentie van de databaseconnectie
        private MySqlConnection GetConnection()
        {
            return new MySqlConnection(_connectionString);
        }

        // Sectie Methoden (Alle Secties ophalen)
        public async Task<List<Sectie>> GetSectiesAsync()
        {
            // ---- WIJZIGING 3: GetSectiesAsync gebruikt nu GetConnection()
            using (var connection = GetConnection())
            {
                string sql = "SELECT Id, Naam from Secties";
                var secties = await connection.QueryAsync<Sectie>(sql);
                return secties.ToList();
            }
        }
        // ---- WIJZIGING 3: GetTafelsBySectieIdAsync gebruikt nu GetConnection()
        // Tafel Methoden (Tafel ophalen per sectie)
        public async Task<List<Tafel>> GetTafelsBySectieIdAsync(int sectieId)
        {
            using (var connection = GetConnection())
            {
                string sql = "SELECT ID, SectieID, TafelNummer, IsBezet FROM Tafels WHERE SectieID = @SectieID"; //parameterNaam
                var tafels = await connection.QueryAsync<Tafel>(sql, new { SectieID = sectieId });
                return tafels.ToList();
            }
        }

        //Producten methoden(Producten ophalen per categorie)
        public async Task<List<Product>> GetProductenByCategorieIdAsync(int categorieId)
        {
            using (var connection = GetConnection())
            {

                string subCategoryIdsSql = @"
                SELECT ID  FROM Categorieen
                Where BovenCategorieID = @HoofdCategorieId";
                var subCategoryIds = (await connection.QueryAsync<int>(subCategoryIdsSql, new { HoofdCategorieId = categorieId })).ToList();
                var relevantCategoryIds = new List<int> { categorieId };
                relevantCategoryIds.AddRange(subCategoryIds);
                string productSql = @"SELECT ID, Naam, Prijs, CategorieID FROM Producten
                                WHERE CategorieID IN @RelevantCategoryIds";
                var Producten = await connection.QueryAsync<Product>(productSql, new { RelevantCategoryIds = relevantCategoryIds });
                return Producten.ToList();
            }
        }

        // Categorie methoden (Alle Categorieën ophalen)
        public async Task<List<Categorie>> GetCategorieenAsync()
        {
            using (var connection = GetConnection())
            {
                string sql = "SELECT ID, Naam, BovenCategorieID FROM Categorieen";
                var categorieen = await connection.QueryAsync<Categorie>(sql);
                return categorieen.ToList();
            }
        }
        // AddOn Methode ophalen voor een specifiek product
        public async Task<List<AddOn>> GetAddOnsByProductIdAsync (int productId)
        {
            using (var connection = GetConnection()) 
            {
                string sql =
                    @" Select ID, Naam, Prijs, ProductId, GroepID 
                        FROM AddOns 
                        Where ProductID = @ProductId
                    ";
                var addOns = await connection.QueryAsync<AddOn>(sql, new { ProductId = productId });
                return addOns.ToList();
            }
        }

    }    
        
}