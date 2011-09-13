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
    /// Allergy Repository that handles the management and access of allergies
    /// </summary>
    public class AllergyRepository : IAllergyRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }
        public Allergy Get(int id)
        {
            return Session.Get<Allergy>(id);
        }
        public IList<Allergy> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Allergy>();
            return criteria.List<Allergy>();
        }

        public PagedList<Allergy> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Allergy entity)
        {
            Session.Save(entity);
        }
        public void Remove(Allergy entity)
        {
            Session.Delete(entity);
        }
    }
}
