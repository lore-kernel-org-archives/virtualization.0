From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: someone screwed something up
Date: Tue, 27 Mar 2007 11:26:09 +1000
Message-ID: <1174958769.12230.16.camel@localhost.localdomain>
References: <20070326011447.35d121de.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070326011447.35d121de.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-03-26 at 01:14 -0800, Andrew Morton wrote:
> arch/i386/lguest/lguest.c:496: warning: assignment from incompatible poin=
ter type
> arch/i386/lguest/lguest.c:497: warning: assignment from incompatible poin=
ter type
> arch/i386/lguest/lguest.c:498: warning: assignment from incompatible poin=
ter type
> =

>         paravirt_ops.write_ldt_entry =3D lguest_write_ldt_entry;
>         paravirt_ops.write_gdt_entry =3D lguest_write_gdt_entry;
>         paravirt_ops.write_idt_entry =3D lguest_write_idt_entry;

And here it is:
=3D=3D
The prototype for paravirt_ops write_lgt_entry, write_gdt_entry and
write_idt_entry was type-corrected, so change lguest to match.  We can
also use the "write_dt_entry" which was exported by that same cleanup
patch, rather than write our own.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r f52fef6a1f2d arch/i386/lguest/lguest.c
--- a/arch/i386/lguest/lguest.c	Mon Mar 26 10:16:33 2007 +1000
+++ b/arch/i386/lguest/lguest.c	Tue Mar 27 10:59:21 2007 +1000
@@ -362,30 +362,24 @@ static void __init lguest_init_IRQ(void)
 	irq_ctx_init(smp_processor_id());
 }
 =

-static inline void native_write_dt_entry(void *dt, int entry, u32 entry_lo=
w, u32 entry_high)
-{
-	u32 *lp =3D (u32 *)((char *)dt + entry*8);
-	lp[0] =3D entry_low;
-	lp[1] =3D entry_high;
-}
-
-static fastcall void lguest_write_ldt_entry(void *dt, int entrynum, u32 lo=
w, u32 high)
+static fastcall void lguest_write_ldt_entry(struct desc_struct *dt,
+					    int entrynum, u32 low, u32 high)
 {
 	/* FIXME: Allow this. */
 	BUG();
 }
 =

-static fastcall void lguest_write_gdt_entry(void *dt, int entrynum,
-					   u32 low, u32 high)
-{
-	native_write_dt_entry(dt, entrynum, low, high);
+static fastcall void lguest_write_gdt_entry(struct desc_struct *dt,
+					    int entrynum, u32 low, u32 high)
+{
+	write_dt_entry(dt, entrynum, low, high);
 	hcall(LHCALL_LOAD_GDT, __pa(dt), GDT_ENTRIES, 0);
 }
 =

-static fastcall void lguest_write_idt_entry(void *dt, int entrynum,
-					   u32 low, u32 high)
-{
-	native_write_dt_entry(dt, entrynum, low, high);
+static fastcall void lguest_write_idt_entry(struct desc_struct *dt,
+					    int entrynum, u32 low, u32 high)
+{
+	write_dt_entry(dt, entrynum, low, high);
 	hcall(LHCALL_LOAD_IDT_ENTRY, entrynum, low, high);
 }
 =
