/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: 1-Feb-2011
 * 
 * Author: Matthew Kimber (matthew.kimber@gmail.com)
 *****************************************************************************/

using System;
using System.IO;
using System.Xml;
using NHibernate;
using NHibernate.Cfg;

namespace OpenEhs.Data
{
    /// <summary>
    /// Initializes a Unit of Work from the Hibernate Configuration XML file ('hibernate.cfg.xml') to create
    /// a session that can be used in the Unit of Work implementor
    /// </summary>
    public class UnitOfWorkFactory : IUnitOfWorkFactory
    {
        #region Fields

        private const string DefaultHibernateConfig = "hibernate.cfg.xml";

        private static ISession _currentSession;
        private ISessionFactory _sessionFactory;
        private Configuration _configuration;

        #endregion


        #region Properties

        public Configuration Configuration
        {
            get
            {
                if (_configuration == null)
                {
                    _configuration = new Configuration();
                    var hibernateConfig = DefaultHibernateConfig;

                    // If not rooted, assume path from base directory.
                    if (Path.IsPathRooted(hibernateConfig) == false)
                    {
                        hibernateConfig = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, hibernateConfig);
                    }

                    if (File.Exists(hibernateConfig))
                    {
                        _configuration.Configure(new XmlTextReader(hibernateConfig));
                    }
                }

                return _configuration;
            }
        }

        public ISession CurrentSession
        {
            get
            {
                if (_currentSession == null)
                    throw new InvalidOperationException("You are not in a unit of work.");

                return _currentSession;
            }
            set
            {
                _currentSession = value;
            }
        }

        public ISessionFactory SessionFactory
        {
            get
            {
                if (_sessionFactory == null)
                    _sessionFactory = Configuration.BuildSessionFactory();

                return _sessionFactory;
            }
        }

        #endregion


        #region Constructor

        internal UnitOfWorkFactory()
        {}

        #endregion


        #region Methods

        public IUnitOfWork Create()
        {
            ISession session = CreateSession();
            session.FlushMode = FlushMode.Commit;
            _currentSession = session;

            return new UnitOfWorkImplementor(this, session);
        }

        private ISession CreateSession()
        {
            return SessionFactory.OpenSession();
        }

        public void DisposeUnitOfWork(IUnitOfWorkImplementor adapter)
        {
            CurrentSession = null;
            UnitOfWork.DisposeUnitOfWork(adapter);
        }

        #endregion
    }
}
