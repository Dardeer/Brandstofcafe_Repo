namespace NHL_Brandstofcafe.Models
{
    public class Tafel
    {
        public int ID { get; set; }
        public int SectieID { get; set; }
        public string TafelNummer { get; set; } = null!;
        public bool IsBezet { get; set; }
    }
}