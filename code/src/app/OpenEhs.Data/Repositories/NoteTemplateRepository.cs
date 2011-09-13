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
    /// Note Template Repository that handles the management and access of note templates
    /// </summary>
    public class NoteTemplateRepository : INoteTemplateRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }
        public NoteTemplateCategory Get(int id)
        {
            return Session.Get<NoteTemplateCategory>(id);
        }
        public IList<NoteTemplateCategory> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<NoteTemplateCategory>();
            return criteria.List<NoteTemplateCategory>();
        }

        public PagedList<NoteTemplateCategory> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(NoteTemplateCategory entity)
        {
            Session.Save(entity);
        }
        public void Remove(NoteTemplateCategory entity)
        {
            Session.Delete(entity);
        }
    }
    
}
