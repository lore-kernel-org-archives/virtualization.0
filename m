From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: proposed interface change for setting the ldt
Date: Fri, 18 Aug 2006 11:42:43 +0100
Message-ID: <44E599A3.6020907@goop.org>
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
To: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

At the moment, all the places where the LDT are set in the kernel are of =

the form:

    set_ldt_desc(cpu, segments, count);
    load_LDT_desc();

(two instances in asm-i386/desc.h).  set_ldt_desc() sets an LDT =

descriptor in the GDT, and load_LDT_desc() is basically just lldt. These =

map to the write_gdt_entry and load_ldt_desc paravirt ops.

This doesn't work well for Xen, because you set the ldt directly by =

passing the base+size into the hypervisor.  In fact, it doesn't allow =

you to set an LDT-type descriptor into the GDT, so this current =

interface requires the Xen backend to decode the descriptor passed to =

write_gdt_entry, look to see if its an LDT; if so, store the base+size =

somewhere, and then when load_ldt_desc() is called, do the appropriate =

Xen hypercall.

A better interface for us would be simply:

	set_ldt(const struct desc_struct *ldt, int num_entries);

since this maps directly to the appropriate Xen hypercall.  If you still =

want to implement it by plugging the LDT descriptor into the GDT and =

then lldt, then there's no reason you can't implement it that way.

Thoughts?

    J
