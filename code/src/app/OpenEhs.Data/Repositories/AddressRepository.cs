using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NHibernate;
using OpenEhs.Domain;
using OpenEhs.Data.Common;

namespace OpenEhs.Data
{
    /// <summary>
    /// Address Repository that handles the management and access of addresses
    /// </summary>
    public class AddressRepository : IAddressRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }
        public Address Get(int id)
        {
            return Session.Get<Address>(id);
        }
        public IList<Address> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Address>();
            return criteria.List<Address>();
        }

        public PagedList<Address> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Address entity)
        {
            Session.Save(entity);
        }
        public void Remove(Address entity)
        {
            Session.Delete(entity);
        }
    }
}
