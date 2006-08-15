From: Zachary Amsden <zach@vmware.com>
Subject: Proposed interface change
Date: Tue, 15 Aug 2006 01:44:54 -0700
Message-ID: <44E18986.40900@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

I would like to propose an interface change to the following =

paravirt-ops calls:

        void (fastcall *write_ldt_entry)(void *dt, int entrynum, u64 entry);
        void (fastcall *write_gdt_entry)(void *dt, int entrynum, u64 entry);
        void (fastcall *write_idt_entry)(void *dt, int entrynum, u64 entry);


Can we consolidate the dt and entrynum parameters and just pass =

dt+entrynum*8?  I don't know if this makes things harder for the Xen =

case, but I seem to distantly recall that we used to pass a pure pointer =

- actually we used to have a pure post-update call, but changed the =

interface to accommodate Xen.  When we did that, the interface changed =

to take the new descriptor value as a parameter, as a raw write to the =

GDT / LDT would not be allowed.  And during that step, the new entrynum =

parameter was added.

Since it's fairly easy to merely subtract the entry offset from the =

descriptor base, and descriptor tables are virtually mapped, obtaining =

the page number, if it is required, is still a very easy task.  I =

believe we added the entrynum field so the page number could be =

computed, but I just don't remember why, and don't see any reason for it =

now.

So I propose changing the convention here to eliminate the entrynum =

field, thus allowing all the parameters to fit within the fastcall =

convention, which affords us three registers.  The primary motivation =

being, the call to write_gdt_entry is on the fast path in context switch.

Any objections?

Zach
