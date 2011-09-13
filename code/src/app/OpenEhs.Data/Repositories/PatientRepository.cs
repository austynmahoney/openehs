/*****************************************************************************
 * Project: Open Electronic Healthcare System
 * Group: Ghana Team
 * Date: 23-Jan-2011
 * 
 * Author: Matthew Kimber (matthew.kimber@gmail.com)
 *****************************************************************************/

using System;
using System.Collections.Generic;
using NHibernate;
using NHibernate.Criterion;
using OpenEhs.Data.Common;
using OpenEhs.Domain;

namespace OpenEhs.Data
{
    /// <summary>
    /// Patient Repository that handles the management and access of patients
    /// </summary>
    public class PatientRepository : IPatientRepository
    {
        private ISession Session
        {
            get
            {
                return UnitOfWork.CurrentSession;
            }
        }

        public Patient Get(int id)
        {
            return Session.Get<Patient>(id);
        }

        public PagedList<Patient> GetPaged(int pageIndex, int pageSize)
        {
            throw new NotImplementedException();
        }

        public void Add(Patient entity)
        {
            Session.Save(entity);
        }

        public void Remove(Patient entity)
        {
            Session.Delete(entity);
        }

        public IList<Patient> GetAll()
        {
            ICriteria criteria = Session.CreateCriteria<Patient>();

            return criteria.List<Patient>();
        }

        public IList<Patient> GetTop25()
        {
            ICriteria criteria = Session.CreateCriteria<Patient>();
            criteria.SetMaxResults(25);
            criteria.AddOrder(Order.Desc("Id"));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByPhoneNumber(string phoneNumber)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>().Add(Restrictions.Like("PhoneNumber", phoneNumber, MatchMode.Anywhere));
            criteria = criteria.AddOrder(Order.Asc("LastName"));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByFirstName(string firstName)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>().Add(Restrictions.Like("FirstName", firstName, MatchMode.Anywhere));
            criteria = criteria.AddOrder(Order.Asc("LastName"));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByMiddleName(string middleName)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>().Add(Restrictions.Like("MiddleName", middleName, MatchMode.Anywhere));
            criteria = criteria.AddOrder(Order.Asc("LastName"));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByLastName(string lastName)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>().Add(Restrictions.Like("LastName",lastName, MatchMode.Anywhere));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByDateOfBirth(DateTime dateOfBirth)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>().Add(Restrictions.Eq("DateOfBirth", dateOfBirth));
            criteria = criteria.AddOrder(Order.Asc("DateOfBirth"));
            criteria = criteria.AddOrder(Order.Asc("LastName"));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByDateOfBirthPiece(string dateOfBirth)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>();
            criteria = criteria.AddOrder(Order.Asc("DateOfBirth"));
            criteria = criteria.AddOrder(Order.Asc("LastName"));

            List<Patient> patients = new List<Patient>();

            foreach (Patient patient in criteria.List<Patient>())
            {
                //If the DOB year matches my search criteria then return this Patient
                if(!string.IsNullOrEmpty(patient.DateOfBirth.Year.ToString()))
                    if (patient.DateOfBirth.Year.ToString().Contains(dateOfBirth)) 
                        patients.Add(patient);
            }

            return patients;
        }

        public IList<Patient> FindByOldPhysicalRecord(string number)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>().Add(Restrictions.Like("OldPhysicalRecordNumber", number, MatchMode.Anywhere));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByOldPhysicalRecordPiece(string number)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>();

            List<Patient> patients = new List<Patient>();

            foreach (Patient patient in criteria.List<Patient>())
            {
                //If the Old Physical Record Number matches my search criteria then return this Patient
                if(!string.IsNullOrEmpty(patient.OldPhysicalRecordNumber))
                    if (patient.OldPhysicalRecordNumber.Contains(number))
                        patients.Add(patient);
            }

            return patients;
        }

        public IList<Patient> FindByPatientId(int number)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>().Add(Restrictions.Eq("Id", number));

            return criteria.List<Patient>();
        }

        public IList<Patient> FindByPatientIdPiece(string number)
        {
            ICriteria criteria = Session.CreateCriteria<Patient>();

            List<Patient> patients = new List<Patient>();

            foreach (Patient patient in criteria.List<Patient>())
            {
                //If the Old Physical Record Number matches my search criteria then return this Patient
                if (patient.Id.ToString().Contains(number))
                    patients.Add(patient);
            }

            return patients;
        }

        public IList<Patient> FindByLocation(Location location)
        {
            var patientCriteria = Session.CreateCriteria<Patient>()
                .CreateCriteria("PatientCheckIns")
                .Add(Restrictions.Eq("CheckOutTime", DateTime.MinValue))
                .CreateCriteria("Location")
                .Add(Restrictions.Eq("Department", location.Department));

            return patientCriteria.List<Patient>();
        }
    }
}
