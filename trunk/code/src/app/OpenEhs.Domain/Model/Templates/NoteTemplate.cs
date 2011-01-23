﻿namespace OpenEhs.Domain
{
    public class NoteTemplate : ITemplate
    {
        public int Id { get; private set; }
        public string Body { get; set; }
        public bool IsActive { get; set; }
    }
}
