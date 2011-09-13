using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenEhs.Data.Common;
using OpenEhs.Domain;
using NHibernate;

namespace OpenEhs.Data
{
    /// <summary>
    /// Surgery Staff Repository that handles the management and access of staff in a surgery
    /// </summary>
    public class SurgeryStaffRepository : ISurgeryStaffRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }
        public SurgeryStaff Get(int id)
        {
            return Session.Get<SurgeryStaff>(id);
        }
        public IList<SurgeryStaff> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<SurgeryStaff>();
            return criteria.List<SurgeryStaff>();
        }

        public PagedList<SurgeryStaff> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(SurgeryStaff entity)
        {
            Session.Save(entity);
        }
        public void Remove(SurgeryStaff entity)
        {
            Session.Delete(entity);
        }
    }
}
