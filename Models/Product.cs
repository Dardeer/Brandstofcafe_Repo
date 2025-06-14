namespace NHL_Brandstofcafe.Models
{
    public class Product
    {
        public int ID {get; set;}
        public string Naam { get; set; } = string.Empty;  //NullReferenceException prevention
        public decimal Prijs { get; set; }
        public int CategorieID { get; set; }

    }
}
