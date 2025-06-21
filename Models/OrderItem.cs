namespace NHL_Brandstofcafe.Models
{
    public class OrderItem
    {
        public int ID { get; set; }
        public int OrderID { get; set; }
        public int ProductID { get; set; }
        public string ProductName { get; set; } = string.Empty;
        public decimal ProductPrijs { get; set; }
        public int Quantity { get; set; }

        public List<OrderItemAddOn> OrderItemAddOns { get; set; } = new List<OrderItemAddOn>();
    }
}
