using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NHibernate;
using OpenEhs.Data.Common;
using OpenEhs.Domain;

namespace OpenEhs.Data
{
    /// <summary>
    /// Medication Repository that handles the management and access of medications
    /// </summary>
    public class MedicationRepository : IMedicationRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }
        public Medication Get(int id)
        {
            return Session.Get<Medication>(id);
        }
        public IList<Medication> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Medication>();
            return criteria.List<Medication>();
        }

        public PagedList<Medication> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Medication entity)
        {
            Session.Save(entity);
        }
        public void Remove(Medication entity)
        {
            Session.Delete(entity);
        }
    }
}
