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
    /// Patient Medication Repository that handles the management and access of patient medications
    /// </summary>
    public class PatientMedicationRepositiry : IPatientMedicationRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }
        public PatientMedication Get(int id)
        {
            return Session.Get<PatientMedication>(id);
        }
        public IList<PatientMedication> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<PatientMedication>();
            return criteria.List<PatientMedication>();
        }

        public PagedList<PatientMedication> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(PatientMedication entity)
        {
            Session.Save(entity);
        }
        public void Remove(PatientMedication entity)
        {
            Session.Delete(entity);
        }
    }
}
