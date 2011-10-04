using System.Web.Mvc;
using OpenEhs.Data;
using OpenEhs.Domain;

namespace OpenEhs.Web.Controllers
{
    /// <summary>
    /// Product Controller contains the functionality for creating, deleting, and viewing products
    /// </summary>
    [Authorize(Roles="Administrators")]
    public class ProductController : Controller
    {
        //
        // GET: /Product/

        /// <summary>
        /// Get the index for the products page
        /// /Product/
        /// </summary>
        /// <returns>View for the product index</returns>
        public ActionResult Index()
        {
            var products = new ProductRepository().GetAll();
            return View(products);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Product product)
        {
            new ProductRepository().Add(product);
            return View();
        }

        public ActionResult Details(int id)
        {
            var product = new ProductRepository().Get(id);
            return View(product);
        }

        public ActionResult Delete(int id)
        {
            return View();
        }
    }
}
