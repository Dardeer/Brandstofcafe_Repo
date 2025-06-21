using Dapper;
using Microsoft.Extensions.Configuration; // Nodig voor IConfiguratie
using MySqlConnector;
using NHL_Brandstofcafe.Models;
using NHL_Brandstofcafe.Services;
using System;               // Nodig voor ArgumentNullException
using System.Collections.Generic;
using System.Threading.Tasks;
//using static NHL_Brandstofcafe.Components.Pages.Home;

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

        public async Task SaveOrderAsync(Order order) 
        { 
            using var connection = GetConnection();
            { 
                await connection.OpenAsync();
                using (var transaction = connection.BeginTransaction())
                {
                    try 
                    {
                        string orderSql;
                        if (order.ID == 0)  //geen bestaande order, maak een nieuwe 
                        {
                            orderSql = @"
                                insert into Orders
                                (TafelID, BestelDatum, TotaalPrijs, Status)
                                values (@TafelID, @BestelDatum, @TotaalPrijs, @Status);
                                select last_insert_id();";
                            order.ID = await connection.ExecuteScalarAsync<int>(orderSql, order, transaction);
                        }
                        else  // bestaande order (Order.ID > 0) 
                        {
                            orderSql = @"
                            update Orders
                            set TafelID = @TafelID, BestelDatum = BestelDatum,
                            `TotaalPrijs = @TotaalPrijs, Status = @Status
                            where ID = @ID;" ;
                            await connection.ExecuteAsync(orderSql, order, transaction);
                            await connection.ExecuteAsync("delete from OrderItemAddOns " +
                                "where OrderItemID in (select ID form OrderItems where OrderID = @OrderID);", new { OrderID = order.ID}, transaction );
                            await connection.ExecuteAsync("delete from OrderItems " +
                                "where OrderID = @OrderID", new { OrderID = order.ID}, transaction);
                        }

                        foreach (var item in order.OrderItems)
                        {
                            item.OrderID = order.ID;
                            string itemSql = @"
                            insert into OrderItems (OrderID, ProductID, ProductName, ProductPrijs, Quantity)
                            values (@OrderID, @ProductID, @ProductName, @ProductPrijs, @Quantity);
                            select last_insert_id();";
                            item.ID = await connection.ExecuteScalarAsync<int>(itemSql, item, transaction);

                            foreach (var addOn in item.OrderItemAddOns)
                            {
                                addOn.OrderItemID = item.ID;
                                string addOnSql = @"
                                insert into OrderItemAddOns
                                (OrderItemID, AddOnID, AddOnName, AddOnPrijs)
                                values(@OrderItemID, @AddOnID, @AddOnName, @AddOnPrijs)";
                                await connection.ExecuteAsync(addOnSql, addOn, transaction);
                            }
                        }

                        transaction.Commit();
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        Console.WriteLine($"Fout bij het opslaan van de order: {ex.Message}");
                        throw;
                    }
                }
            }
        }

        public async Task<List<Order>> GetOpenOrdersForTableAsync(int tafelId) 
        {
            using (var connection = GetConnection()) 
            { 
                await connection.OpenAsync();

                string sql = @"
                select
                    o.ID, o.TafelID, o.BestelDatum, o.TotaalPrijs, o.Status,
                        oi.ID, oi.OrderID, oi.ProductID, oi.ProductName, oi.ProductPrijs, oi.Quantity,
                        oia.ID, oia.OrderItemID, oia.AddOnID, oia.AddOnName, oia.AddOnPrijs
                from Orders o
                left join OrderItems oi on o.ID = Order.ID
                left join OrderItemAddOns oia on oi.ID = oia.OrderItemID
                where
                o.TafelID = @TafelID and o.Status ='Open'
                order by 
                o.ID, oi.ID, oia.ID;";

                var orderDictionary = new Dictionary<int, Order>();
                var orders = await connection.QueryAsync<Order, OrderItem, OrderItemAddOn, Order>(
                    sql,
                    (order, orderItem, orderItemAddOn) =>
                    {
                        if (!orderDictionary.TryGetValue(order.ID, out var currentOrder)) {
                            currentOrder = order;
                            currentOrder.OrderItems = new List<OrderItem>(); 
                            orderDictionary.Add(currentOrder.ID, currentOrder);
                        }

                        if (orderItem != null) {
                            var existingOrderItem = currentOrder.OrderItems.FirstOrDefault(i => i.ID == orderItem.ID);
                            if (existingOrderItem == null) 
                            {
                                existingOrderItem = orderItem;
                                existingOrderItem.OrderItemAddOns = new List<OrderItemAddOn>(); // Initialiseer de lijst
                                currentOrder.OrderItems.Add(existingOrderItem);
                            }
                            if (orderItemAddOn != null)
                            {
                                existingOrderItem.OrderItemAddOns.Add(orderItemAddOn);
                            }
                        }
                        return currentOrder;
                    },
                    new { TafelID = tafelId },
                    splitOn: "ID,ID,ID"
                    );

                return orderDictionary.Values.ToList();
            }
        }

        public async Task UpdateTafelStatusAsync(int tafelId, bool isBezet)
        {
            using (var connection = GetConnection()) // Gebruik de hulpmethode
            {
                await connection.OpenAsync();
                string sql = "UPDATE tafels SET IsBezet = @IsBezet WHERE ID = @TafelID;";
                await connection.ExecuteAsync(sql, new { IsBezet = isBezet, TafelID = tafelId });
            }
        }

        
    }
}    
        
