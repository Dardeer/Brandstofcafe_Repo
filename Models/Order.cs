namespace NHL_Brandstofcafe.Models
{
    public class Order
    {
        public int ID { get; set; }
        public int TafelID { get; set; }
        public DateTime BestelDatum { get; set; }
        public decimal TotaalPrijs { get; set; }
        public string Status { get; set; } = "Open";

        public List<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
    }
}
