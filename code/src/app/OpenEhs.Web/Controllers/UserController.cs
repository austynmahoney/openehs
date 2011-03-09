﻿using System;
using System.Web.Mvc;
using OpenEhs.Data;
using OpenEhs.Web.Models;

namespace OpenEhs.Web.Controllers
{
    public class UserController : Controller
    {
        private readonly IUserRepository _userRepository;
        private readonly IRoleRepository _roleRepository;

        public UserController()
        {
            _userRepository = new UserRepository();
            _roleRepository = new RoleRepository();
        }

        public ActionResult Index(int? page)
        {
            var pageIndex = page ?? 1;
            var users = _userRepository.GetPaged(pageIndex, 10);

            return View(new UserViewModel(users));
        }

        public ActionResult Details(int id)
        {
            return View(new UserDetailsViewModel(_userRepository.Get(id)));
        }

        [HttpPost]
        public ActionResult Details(UserDetailsViewModel model)
        {
            var user = _userRepository.Get(model.UserId);

            user.Password = model.Password;
            user.Staff.Address = model.Staff.Address;
            user.Staff.FirstName = model.Staff.FirstName;
            user.Staff.MiddleName = model.Staff.MiddleName;
            user.Staff.LastName = model.Staff.LastName;
            user.Staff.PhoneNumber = model.Staff.PhoneNumber;
            user.EmailAddress = model.EmailAddress;

            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult AddRole(int id, int userId)
        {
            var roleToAdd = _roleRepository.Get(id);
            var user = _userRepository.Get(userId);

            try
            {
                user.AddRole(roleToAdd);
            }
            catch (ArgumentException ex)
            {
                return Json(new {success = false, error = ex.Message});
            }

            UnitOfWork.CurrentSession.Flush();

            return Json(new {success = true, RoleName = roleToAdd.Name, RoleId = roleToAdd.Id});
        }

        [HttpPost]
        public ActionResult RemoveRole(int id, int userId)
        {
            var roleToRemove = _roleRepository.Get(id);
            var user = _userRepository.Get(userId);

            user.RemoveRole(roleToRemove);

            UnitOfWork.CurrentSession.Flush();

            return Json(new {success = true});
        }

        [HttpPost]
        public ActionResult ApproveUser(int id)
        {
            var user = _userRepository.Get(id);

            user.IsApproved = !user.IsApproved;

            return Json(new { success = true });
        }
    }
}