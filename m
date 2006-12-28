From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lhype on 2.6.20-rc2: Guest didn't handle trap 6 at c071b594
	(cr2=00000000,err=0)
Date: Fri, 29 Dec 2006 10:34:43 +1100
Message-ID: <1167348883.30506.47.camel@localhost.localdomain>
References: <20061227132520.GA32685@outpost.ds9a.nl>
	<1167272613.30506.5.camel@localhost.localdomain>
	<20061228114542.GB18047@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-V0tFGOEInEUYZmeKcdof"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061228114542.GB18047@outpost.ds9a.nl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


--=-V0tFGOEInEUYZmeKcdof
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-12-28 at 12:45 +0100, bert hubert wrote:
> On Thu, Dec 28, 2006 at 01:23:33PM +1100, Rusty Russell wrote:
> 
> > 	Ah, this is your clue, here: looks like the kernel ran BUG() or
> > otherwise failed at address 0xc071b594...  can you send your .config and
> > I can see if I can reproduce?  Your System.map should indicate what's at
> > that address, to...
> 
> c071b562 T bootmem_bootmap_pages
> c071b571 t get_mapsize
> c071b588 t reserve_bootmem_core
> c071b5e2 t free_bootmem_core
> 
> With some gdb trickery, this appears to be line 124 of mm/bootmem.c:

Yep, my bad... As a bonus, your config also found a paravirt problem in
the raid code (patch sent upstream, and attached below).

Here's the two-liner patch (already rolled into the lhype.patch, so you
can simply update).

Thanks very much for the bug report!
Rusty.

diff -r 4ff048622391 arch/i386/kernel/lhype.c
--- a/arch/i386/kernel/lhype.c	Thu Dec 28 16:52:54 2006 +1100
+++ b/arch/i386/kernel/lhype.c	Fri Dec 29 10:21:20 2006 +1100
@@ -446,14 +446,16 @@ static __attribute_used__ __init void lh
 	acpi_disabled = 1;
 	acpi_ht = 0;
 #endif
-
-	INITRD_START = init_pg_tables_end;
-	INITRD_SIZE = lhype_page.initrd_size;
-	LOADER_TYPE = (LHYPE_LOADER_TYPE << 4) | LHYPE_LOADER_VERSION;
-
-	/* Bootmem puts allocator bitmap immediately after boot page tables,
-	   so tell it pagetables cover this, too. */
-	init_pg_tables_end += lhype_page.initrd_size;
+	if (lhype_page.initrd_size) {
+		INITRD_START = init_pg_tables_end;
+		INITRD_SIZE = lhype_page.initrd_size;
+		LOADER_TYPE = (LHYPE_LOADER_TYPE << 4) | LHYPE_LOADER_VERSION;
+
+		/* Bootmem puts allocator bitmap immediately after
+		   boot page tables, so tell it pagetables cover this, too. */
+		init_pg_tables_end += lhype_page.initrd_size;
+	}
+
 	start_kernel();
 }
 


--=-V0tFGOEInEUYZmeKcdof
Content-Disposition: attachment; filename=raid-paravirt.patch
Content-Type: text/x-patch; name=raid-paravirt.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Use correct macros in raid code, not raw asm.

This make sure it's paravirtualized correctly when CONFIG_PARAVIRT=y.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 4ff048622391 drivers/md/raid6x86.h
--- a/drivers/md/raid6x86.h	Thu Dec 28 16:52:54 2006 +1100
+++ b/drivers/md/raid6x86.h	Fri Dec 29 10:09:38 2006 +1100
@@ -75,13 +75,14 @@ static inline unsigned long raid6_get_fp
 	unsigned long cr0;
 
 	preempt_disable();
-	asm volatile("mov %%cr0,%0 ; clts" : "=r" (cr0));
+	cr0 = read_cr0();
+	clts();
 	return cr0;
 }
 
 static inline void raid6_put_fpu(unsigned long cr0)
 {
-	asm volatile("mov %0,%%cr0" : : "r" (cr0));
+	write_cr0(cr0);
 	preempt_enable();
 }
 

--=-V0tFGOEInEUYZmeKcdof
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--=-V0tFGOEInEUYZmeKcdof--
