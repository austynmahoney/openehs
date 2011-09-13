using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenEhs.Domain;
using OpenEhs.Data.Common;
using NHibernate;

namespace OpenEhs.Data
{
    /// <summary>
    /// Country Repository that handles the management and access of countries
    /// </summary>
    public class CountryRepository : ICountryRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }

        public Country Get(int id)
        {
            return Session.Get<Country>(id);
        }

        public IList<Country> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Country>();
            return criteria.List<Country>();
        }

        public PagedList<Country> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Country entity)
        {
            Session.Save(entity);
        }
        public void Remove(Country entity)
        {
            Session.Delete(entity);
        }
    }
}
