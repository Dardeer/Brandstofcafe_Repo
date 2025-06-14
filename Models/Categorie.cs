namespace NHL_Brandstofcafe.Models
{
    public class Categorie
    {
        public int ID { get; set; }
        public string Naam { get; set; } = string.Empty;
        
        public int? BovenCategorieID { get; set; }
    }
}
