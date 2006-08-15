From: "Christian Limpach" <Christian.Limpach@xensource.com>
Subject: RE: Proposed interface change
Date: Tue, 15 Aug 2006 03:28:34 -0700
Message-ID: <BBC437B5B077FF46935BA1D8C9A2172A92C802@exch2.ad.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

> I would like to propose an interface change to the following =

> paravirt-ops calls:
> =

>         void (fastcall *write_ldt_entry)(void *dt, int =

> entrynum, u64 entry);
>         void (fastcall *write_gdt_entry)(void *dt, int =

> entrynum, u64 entry);
>         void (fastcall *write_idt_entry)(void *dt, int =

> entrynum, u64 entry);
> =

> =

> Can we consolidate the dt and entrynum parameters and just pass =

> dt+entrynum*8?  I don't know if this makes things harder for the Xen =

> case, but I seem to distantly recall that we used to pass a =

> pure pointer =

> - actually we used to have a pure post-update call, but changed the =

> interface to accommodate Xen.  When we did that, the =

> interface changed =

> to take the new descriptor value as a parameter, as a raw =

> write to the =

> GDT / LDT would not be allowed.  And during that step, the =

> new entrynum =

> parameter was added.

This is fine for GDT and LDT updates, the Xen hypercalls take a machine
address which can be computed from the virtual address.

> Since it's fairly easy to merely subtract the entry offset from the =

> descriptor base, and descriptor tables are virtually mapped, =

> obtaining =

> the page number, if it is required, is still a very easy task.

How do you do that if you don't know the base address?  If you knew the
base address, then why would you pass it in in the first place?

> I believe we added the entrynum field so the page number could be =

> computed, but I just don't remember why, and don't see any =

> reason for it now.

I think it was added to allow us to use the Xen interface for updating
the virtual trap table.

> So I propose changing the convention here to eliminate the entrynum =

> field, thus allowing all the parameters to fit within the fastcall =

> convention, which affords us three registers.  The primary motivation =

> being, the call to write_gdt_entry is on the fast path in =

> context switch.

I think this change is ok for GDT/LDT, I think for IDT it would be a
move in the wrong direction.  It would still work in the IDT case
because the base address is known (idt_table), but the whole interface
feels quite awkward and not very generic.

    Christian
