using System;
using System.Collections.Generic;
using NHibernate;
using OpenEhs.Data.Common;
using OpenEhs.Domain;

namespace OpenEhs.Data
{
    /// <summary>
    /// Location Repository that handles the management and access of locations
    /// </summary>
    public class LocationRepository : ILocationRepository
    {
        private ISession Session
        {
            get { return UnitOfWork.CurrentSession; }
        }

        public Location Get(int id)
        {
            return Session.Get<Location>(id);
        }

        public IList<Location> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Location>();
            return criteria.List<Location>();
        }

        public PagedList<Location> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Location entity)
        {
            Session.Save(entity);
        }

        public void Remove(Location entity)
        {
            Session.Delete(entity);
        }
    }
}