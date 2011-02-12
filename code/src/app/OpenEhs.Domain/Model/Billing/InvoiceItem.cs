﻿/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: Jan-12-2011
 * 
 * Author: Cameron Harp (charp5257@gmail.com)
 *****************************************************************************/

namespace OpenEhs.Domain
{
    public class InvoiceItem: IEntity
    {
        #region Properties

        public virtual int Id { get; private set; }
        public virtual Invoice Invoice { get; set; }
        public virtual Product Product { get; set; }
        public virtual Service Service { get; set; }
        public virtual decimal Quantity { get; set; }
        public virtual decimal Total
        {
            get
            {
                if (Service != null)
                    return Service.Price * Quantity;

                if (Product != null)
                    return Product.Price * Quantity;

                return 0.0m;
            }
        }
        public virtual bool IsActive { get; set; }

        #endregion
    }
}