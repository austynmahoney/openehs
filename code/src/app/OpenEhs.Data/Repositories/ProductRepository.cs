/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: 23-Jan-2011
 * 
 * Author: Matthew Kimber (matthew.kimber@gmail.com)
 *****************************************************************************/

using System;
using System.Collections.Generic;
using NHibernate;
using NHibernate.Criterion;
using OpenEhs.Data.Common;
using OpenEhs.Domain;

namespace OpenEhs.Data
{
    /// <summary>
    /// Product Repository that handles the management and access of products
    /// </summary>
    public class ProductRepository : IProductRepository
    {
        private ISession Session
        {
            get { return UnitOfWork.CurrentSession; }
        }

        public Product Get(int id)
        {
            return Session.Get<Product>(id);
        }

        public IList<Product> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Product>();
            return criteria.List<Product>();
        }

        public PagedList<Product> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Product product)
        {
            Session.Save(product);
        }

        public void Remove(Product product)
        {
            Session.Delete(product);
        }

        public IList<Product> GetActiveProducts()
        {
            ICriteria criteria = Session.CreateCriteria<Product>()
                .Add(Restrictions.Eq("IsActive", true));

            return criteria.List<Product>();
        }

        public IList<Product> GetInactiveProducts()
        {
            ICriteria criteria = Session.CreateCriteria<Product>()
                .Add(Restrictions.Eq("IsActive", false));

            return criteria.List<Product>();
        }

        public IList<Product> GetByCategory(Category category)
        {
            throw new NotImplementedException();
        }
    }
}
