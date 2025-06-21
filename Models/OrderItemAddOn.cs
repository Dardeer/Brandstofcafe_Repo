namespace NHL_Brandstofcafe.Models
{
    public class OrderItemAddOn
    {
        public int ID { get; set; }
        public int OrderItemID { get; set; }
        public int AddOnID { get; set; }
        public string AddOnName { get; set; } = string.Empty;
        public decimal AddOnPrijs { get; set; }
    }
}
