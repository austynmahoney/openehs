﻿using System.Web.Mvc;
using OpenEhs.Data;
using OpenEhs.Domain;

namespace OpenEhs.Web.Controllers
{
    public class CategoryController : Controller
    {
        //
        // GET: /Category/
        public ActionResult Index()
        {
            var categories = new CategoryRepository().GetAll();
            return View(categories);
            //return View(new CategoryRepository().GetAll());
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Category category)
        {
            return View();
        }

        public ActionResult Details(int id)
        {
            var category = new CategoryRepository().Get(id);

            return View(category);
        }
    }
}
