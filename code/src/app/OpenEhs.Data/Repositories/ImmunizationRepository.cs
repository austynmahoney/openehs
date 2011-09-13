/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: 23-Jan-2011
 * 
 * Author: Matthew Kimber (matthew.kimber@gmail.com)
 *****************************************************************************/

using System;
using System.Collections.Generic;
using OpenEhs.Data.Common;
using OpenEhs.Domain;
using NHibernate;
using NHibernate.Criterion;

namespace OpenEhs.Data
{
    /// <summary>
    /// Immunization Repository that handles the management and access of immunizations
    /// </summary>
    public class ImmunizationRepository : IImmunizationRepository 
    {
        private ISession Session 
        {
            get 
            {
                return UnitOfWork.CurrentSession;
            }
        }

        public Immunization Get(int id) 
        {
            return Session.Get<Immunization>(id);
        }

        public IList<Immunization> GetAll() 
        {
            ICriteria criteria = Session.CreateCriteria<Immunization>();
            return criteria.List<Immunization>();
        }

        public PagedList<Immunization> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Immunization entity) 
        {
            Session.Save(entity);
        }

        public void Remove(Immunization entity) 
        {
            Session.Delete(entity);
        }

        public Boolean ImmunizationExists(string vaccineType) 
        {
            ICriteria criteria = Session.CreateCriteria<Immunization>().Add(Restrictions.Eq("VaccineType", vaccineType));
            Immunization Immunization = criteria.UniqueResult<Immunization>();
            if (Immunization == null)
                return false;
            else
                return true;
        }
    }
}
