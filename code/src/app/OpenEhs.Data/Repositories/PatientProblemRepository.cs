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
    /// Patient Problem Repository that handles the management and access of patient problems
    /// </summary>
    public class PatientProblemRepository : IPatientProblemRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }
        public PatientProblem Get(int id)
        {
            return Session.Get<PatientProblem>(id);
        }
        public IList<PatientProblem> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<PatientProblem>();
            return criteria.List<PatientProblem>();
        }

        public PagedList<PatientProblem> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(PatientProblem entity)
        {
            Session.Save(entity);
        }
        public void Remove(PatientProblem entity)
        {
            Session.Delete(entity);
        }
    }
}
