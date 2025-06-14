namespace NHL_Brandstofcafe.Models
{
    public class AddOn
    {
        public int ID { get; set; }
        public string Naam { get; set; } = string.Empty; // Prevent NullReferenceException
        public decimal Prijs { get; set; }
        public int ProductID { get; set; } // Foreign key to Product
        
        public int? GroepID { get; set; } // mag null zijn, vreemde sleutel naar Groep.
    }
}
