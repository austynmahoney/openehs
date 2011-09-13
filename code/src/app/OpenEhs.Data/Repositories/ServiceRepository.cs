/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: 14-Feb-2011
 * 
 * Author: Peter Litster (aholibamah@gmail.com)
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
    /// Service Repository that handles the management and access of services
    /// </summary>
    public class ServiceRepository : IServiceRepository
    {
        private ISession Session
        {
            get { return UnitOfWork.CurrentSession; }
        }

        public Service Get(int id)
        {
            return Session.Get<Service>(id);
        }

        public IList<Service> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Service>();
            return criteria.List<Service>();
        }

        public PagedList<Service> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Service service)
        {
            Session.Save(service);
        }

        public void Remove(Service service)
        {
            Session.Delete(service);
        }

        public IList<Service> GetActiveServices()
        {
            ICriteria criteria = Session.CreateCriteria<Service>()
                .Add(Restrictions.Eq("IsActive", true));

            return criteria.List<Service>();
        }

        public IList<Service> GetInactiveServices()
        {
            ICriteria criteria = Session.CreateCriteria<Service>()
                .Add(Restrictions.Eq("IsActive", false));

            return criteria.List<Service>();
        }

        public IList<Service> GetByCategory(Category category)
        {
            throw new NotImplementedException();
        }
    }
}
