using System;
using System.Collections.Generic;
using NHibernate;
using OpenEhs.Data.Common;
using OpenEhs.Domain;

namespace OpenEhs.Data
{
    /// <summary>
    /// Category Repository that handles the management and access of categories
    /// </summary>
    public class CategoryRepository : ICategoryRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }

        public Category Get(int id)
        {
            return Session.Get<Category>(id);
        }

        public IList<Category> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Category>();

            return criteria.List<Category>();
        }

        public PagedList<Category> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Category entity)
        {
            Session.Save(entity);
        }

        public void Remove(Category entity)
        {
            Session.Delete(entity);
        }
    }
}
