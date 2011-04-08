﻿using System.Web.Mvc;

namespace OpenEhs.Web.Controllers {
    public class HelpController : Controller {
        //
        // GET: /Help/

        public ActionResult Index() {
            return View();
        }

        /// <summary>
        /// Show the help for the Dashboard.
        /// Nothing more than a link to Dashboard.cshtml.
        /// </summary>
        /// <returns>ActionResult to display.</returns>
        public ActionResult Dashboard()
        {
            return View();
        }

        public ActionResult PatientSearch()
        {
            return View();
        }

        public ActionResult PatientCreation() {
            return View();
        }

        /// <summary>
        /// Show the help for Patient Resources. Basically just a link to the 
        /// PatientResources.cshtml in the help.
        /// </summary>
        /// <returns>ActionResult to display.</returns>
        public ActionResult PatientResources() {
            return View();
        }


        public ActionResult BillingSearch() {
            return View();
        }

        /// <summary>
        /// Show the help for Billing Details.
        /// Nothing more than a link to BillingDetails.cshtml.
        /// </summary>
        /// <returns></returns>
        public ActionResult BillingDetails()
        {
            return View();
        }

        public ActionResult PrinterSetup()
        {
            return View();
        }

        public ActionResult PrintExistingPatientBarcode()
        {
            return View();
        }

    }
}
