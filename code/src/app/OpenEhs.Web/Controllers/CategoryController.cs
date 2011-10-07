using System.Web.Mvc;
using OpenEhs.Data;
using OpenEhs.Domain;

namespace OpenEhs.Web.Controllers
{
    /// <summary>
    /// Category Controller contains the necessary functions to control the views of the category page and 
    /// to manage category creation and details
    /// </summary>
    [Authorize]
    public class CategoryController : Controller
    {
        /// <summary>
        /// Gets the main page for categories
        /// /Category/
        /// </summary>
        /// <returns>main page view</returns>
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
