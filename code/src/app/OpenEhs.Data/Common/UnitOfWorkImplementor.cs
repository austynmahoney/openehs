/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: 1-Feb-2011
 * 
 * Author: Matthew Kimber (matthew.kimber@gmail.com)
 *****************************************************************************/

using System;
using System.Data;
using NHibernate;

namespace OpenEhs.Data
{
    /// <summary>
    /// Follows the 'Unit of Work' pattern that manages the transactions and commits to the database
    /// </summary>
    public class UnitOfWorkImplementor : IUnitOfWorkImplementor
    {
        #region Fields

        private readonly UnitOfWorkFactory _factory;
        private readonly ISession _session;

        #endregion


        #region Properties

        public bool IsInActiveTransaction
        {
            get
            {
                return _session.Transaction.IsActive;
            }
        }

        public IUnitOfWorkFactory Factory
        {
            get
            {
                return _factory;
            }
        }

        public ISession Session
        {
            get
            {
                return _session;
            }
        }

        #endregion


        #region Constructor

        public UnitOfWorkImplementor(UnitOfWorkFactory factory, ISession session)
        {
            _factory = factory;
            _session = session;
        }

        #endregion


        #region Methods

        public IGenericTransaction BeginTransaction()
        {
            return new GenericTransaction(_session.BeginTransaction());
        }

        public IGenericTransaction BeginTransaction(IsolationLevel isolationLevel)
        {
            return new GenericTransaction(_session.BeginTransaction(isolationLevel));
        }

        public void TransactionalFlush()
        {
            TransactionalFlush(IsolationLevel.ReadCommitted);
        }

        public void TransactionalFlush(IsolationLevel isolationLevel)
        {
            IGenericTransaction tx = BeginTransaction(isolationLevel);

            try
            {
                tx.Commit();
            }
            catch
            {
                tx.Rollback();
                throw;
            }
            finally
            {
                tx.Dispose();
            }
        }

        public void Flush()
        {
            _session.Flush();
        }

        public void IncrementUsages()
        {
            throw new NotImplementedException();
        }

        #region IDisposable Implementation

        public void Dispose()
        {
            _factory.DisposeUnitOfWork(this);
            _session.Dispose();
        }

        #endregion

        #endregion
    }
}