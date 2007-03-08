From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 01/13] HV VM Fix map area for HV.
Date: Thu, 08 Mar 2007 12:38:31 -0500
Message-ID: <1173375511.32170.3.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
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
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (hvvm.patch)
OK, some explaination is needed here. The goal of lguest with paravirt
ops, is to have one kernel that can be loaded both as a host and a guest.
To do this, we need to map an area in virtual memory that both the host
and guest share. But I don't want any conflicts with the guest.

One solution is just to do a single area for boot up, and then
use the vmalloc to map. But this gets quite complex, since we need to
force the guest to map a given area, after the fact, hoping that
it didn't map it someplace else before we get to the code to map it.
This can be done, but doing it this way is (for now) much easier.

What I've done here, is to make a large area in the FIXMAP region.
The guest will not use this area for anything, since it is reserved
for only running a HV. So by making a FIXMAP area, we force this
area reserved for HV use.  Now the host can load the hypervisor
text section into this area and force it mapped to the guest without
worrying that the guest will want to use this area for anything else.

Each guest will have it's own shared data placed in this section too.
The guest will only get the hypervisor text and its own section data
mapped into this area.  But the host will map the hypervisor text
and all guest shared areas in this region.  And what makes this so
easy, is that the virtual addresses between the host and guest for
these locations will be the same!

To explain this a little better, here's what the virtual addresses
of the host and guests will look like:


    Host            Guest1          Guest2
 +-----------+   +-----------+  +-----------+
 |           |   |           |  |           |
 +-----------+   +-----------+  +-----------+
 | HV FIXMAP |   | HV FIXMAP |  | HV FIXMAP |
 |   TEXT    |   |   TEXT    |  |   TEXT    |
 +-----------+   +-----------+  +-----------+
 | GUEST 1   |   | GUEST 1   |  | UNMAPPED  |
 |SHARED DATA|   |SHARED DATA|  |           |
 +-----------+   +-----------+  +-----------+
 | GUEST 2   |   | UNMAPPED  |  | GUEST 2   |
 |SHARED DATA|   |           |  |SHARED DATA|
 +-----------+   |           |  +-----------+
 |           |   |           |  |           |



Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Cc: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Ingo Molnar <mingo@elte.hu>


Index: work-pv/arch/x86_64/lguest/hv_vm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/hv_vm.c
@@ -0,0 +1,367 @@
+/*
+ *  arch/x86_64/lguest/hv_vm.c
+ *
+ *  Copyright (C) 2007 Steven Rostedt <srostedt@redhat.com>, Red Hat
+ *
+ *  Some of this code was influenced by mm/vmalloc.c
+ *
+ *  FIXME: This should not be limited to lguest, but should be put
+ *         into the kernel proper, since this code should be
+ *         HV agnostic.
+ *
+ *  The purpose of the HV VM area is to create a virtual address
+ *  space that can be saved for use of sending information to and
+ *  from a guest.  A small hypervisor text section may be loaded
+ *  into this address and shared across all guests that use that
+ *  hypervisor.  Each guest may have a data page so that it can
+ *  communicate back and forth with the host.
+ *
+ *  The reason for this, is to allow an virtual address space that
+ *  will not be used by the guest for any other purpose.  This
+ *  allows a nice place to map code that will communicate to the guest.
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include <asm/hv_vm.h>
+
+static DEFINE_MUTEX(hvvm_lock);
+
+static DECLARE_BITMAP(hvvm_avail_pages, NR_HV_PAGES);
+
+
+static void hvvm_pte_unmap(pmd_t *pmd, unsigned long addr)
+{
+	pte_t *pte;
+	pte_t ptent;
+
+	pte =3D pte_offset_kernel(pmd, addr);
+	ptent =3D ptep_get_and_clear(&init_mm, addr, pte);
+	WARN_ON(!pte_none(ptent) && !pte_present(ptent));
+}
+
+static inline void hvvm_pmd_unmap(pud_t *pud, unsigned long addr)
+{
+	pmd_t *pmd;
+
+	pmd =3D pmd_offset(pud, addr);
+	if (pmd_none_or_clear_bad(pmd))
+		return;
+	hvvm_pte_unmap(pmd, addr);
+}
+
+static inline void hvvm_pud_unmap(pgd_t *pgd, unsigned long addr)
+{
+	pud_t *pud;
+
+	pud =3D pud_offset(pgd, addr);
+	if (pud_none_or_clear_bad(pud))
+		return;
+	hvvm_pmd_unmap(pud, addr);
+}
+
+static void hvvm_unmap_page(unsigned long addr)
+{
+	pgd_t *pgd;
+
+	pgd =3D pgd_offset_k(addr);
+	hvvm_pud_unmap(pgd, addr);
+}
+
+static int hvvm_pte_alloc(pmd_t *pmd, unsigned long addr,
+			  unsigned long page, pgprot_t prot)
+{
+	pte_t *pte;
+
+	pte =3D pte_alloc_kernel(pmd, addr);
+	if (!pte)
+		return -ENOMEM;
+
+	WARN_ON(!pte_none(*pte));
+	set_pte_at(&init_mm, addr, pte,
+		   mk_pte(pfn_to_page(page >> PAGE_SHIFT), prot));
+
+	return 0;
+}
+
+static inline int hvvm_pmd_alloc(pud_t *pud, unsigned long addr,
+				 unsigned long page, pgprot_t prot)
+{
+	pmd_t *pmd;
+
+	pmd =3D pmd_alloc(&init_mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+	if (hvvm_pte_alloc(pmd, addr, page, prot))
+		return -ENOMEM;
+	return 0;
+}
+
+static inline int hvvm_pud_alloc(pgd_t *pgd, unsigned long addr,
+				 unsigned long page, pgprot_t prot)
+{
+	pud_t *pud;
+
+	pud =3D pud_alloc(&init_mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
+	if (hvvm_pmd_alloc(pud, addr, page, prot))
+		return -ENOMEM;
+	return 0;
+}
+
+static int hvvm_alloc_page(unsigned long addr, unsigned long page, pgprot_=
t prot)
+{
+	pgd_t *pgd;
+	int err;
+
+	pgd =3D pgd_offset_k(addr);
+	err =3D hvvm_pud_alloc(pgd, addr, page, prot);
+	return err;
+}
+
+static unsigned long *get_vaddr(unsigned long paddr)
+{
+	paddr &=3D ~(0xfff);
+	return (unsigned long*)(paddr + PAGE_OFFSET);
+}
+
+unsigned long hvvm_get_actual_phys(void *addr, pgprot_t *prot)
+{
+	unsigned long vaddr;
+	unsigned long offset;
+	unsigned long cr3;
+	unsigned long pgd;
+	unsigned long pud;
+	unsigned long pmd;
+	unsigned long pte;
+	unsigned long mask;
+
+	unsigned long *p;
+
+	/*
+	 * Travers the page tables to get the actual
+	 * physical address. I want this to work for
+	 * all addresses, regardless of where they are mapped.
+	 */
+
+	/* FIXME: Do this better!! */
+
+	/* grab the start of the page tables */
+	asm ("movq %%cr3, %0" : "=3Dr"(cr3));
+
+	p =3D get_vaddr(cr3);
+
+	offset =3D (unsigned long)addr;
+	offset >>=3D PGDIR_SHIFT;
+	offset &=3D PTRS_PER_PGD-1;
+
+	pgd =3D p[offset];
+
+	if (!(pgd & 1))
+		return 0;
+
+	p =3D get_vaddr(pgd);
+
+	offset =3D (unsigned long)addr;
+	offset >>=3D PUD_SHIFT;
+	offset &=3D PTRS_PER_PUD-1;
+
+	pud =3D p[offset];
+
+	if (!(pud & 1))
+		return 0;
+
+	p =3D get_vaddr(pud);
+
+	offset =3D (unsigned long)addr;
+	offset >>=3D PMD_SHIFT;
+	offset &=3D PTRS_PER_PMD-1;
+
+	pmd =3D p[offset];
+
+	if (!(pmd & 1))
+		return 0;
+
+	/* Now check to see if we are 2M pages or 4K pages */
+	if (pmd & (1 << 7)) {
+		/* stop here, we are 2M pages */
+		pte =3D pmd;
+		mask =3D (1<<21)-1;
+		goto calc;
+	}
+
+	p =3D get_vaddr(pmd);
+
+	offset =3D (unsigned long)addr;
+	offset >>=3D PAGE_SHIFT;
+	offset &=3D PTRS_PER_PTE-1;
+
+	pte =3D p[offset];
+	mask =3D PAGE_SIZE-1;
+
+ calc:
+
+	if (!(pte & 1))
+		return 0;
+
+	vaddr =3D pte & ~(0xfff) & ~(1UL << 63);
+
+	if (prot)
+		pgprot_val(*prot) =3D pte & 0xfff;
+
+	offset =3D (unsigned long)addr;
+	offset &=3D mask;
+
+	vaddr +=3D offset;
+	/* Potentially clear the nx bit */
+	vaddr &=3D ~(1UL << 63);
+
+	return vaddr;
+}
+
+static unsigned long alloc_hv_pages(int pages)
+{
+	unsigned int bit =3D 0;
+	unsigned int found_bit;
+	int i;
+
+	/* FIXME : ADD LOCKING!!! */
+
+	/*
+	 * Scan the available bitmask for free pages.
+	 * 0 - available : 1 - used
+	 */
+	do {
+		bit =3D find_next_zero_bit(hvvm_avail_pages, NR_HV_PAGES, bit);
+		if (bit >=3D NR_HV_PAGES)
+			return 0;
+
+		found_bit =3D bit;
+
+		for (i=3D1; i < pages; i++) {
+			bit++;
+			if (test_bit(bit, hvvm_avail_pages))
+				break;
+		}
+	} while (i < pages);
+
+	if (i < pages)
+		return 0;
+
+	/*
+	 * OK we found a location where we can map our pages
+	 * so now we set them used, and do the mapping.
+	 */
+	bit =3D found_bit;
+	for (i=3D0; i < pages; i++)
+		set_bit(bit++, hvvm_avail_pages);
+
+	return HVVM_START + found_bit * PAGE_SIZE;
+}
+
+static void release_hv_pages(unsigned long addr, int pages)
+{
+	unsigned int bit;
+	int i;
+
+	/* FIXME : ADD LOCKING!!! */
+
+	bit =3D (addr - HVVM_START) / PAGE_SIZE;
+
+	for (i=3D0; i < pages; i++) {
+		BUG_ON(!test_bit(bit, hvvm_avail_pages));
+		clear_bit(bit++, hvvm_avail_pages);
+	}
+}
+
+
+/**
+ *	hvvm_map_pages - map an address to the HV VM area.
+ *	@vaddr:		virtual address to map
+ *	@pages:		Number of pages from that virtual address to map.
+ *	@hvaddr:	address returned that holds the mapping.
+ *
+ *	This function maps the pages represnted by addr into
+ * 	the HV VM area, and returns the address given to it.
+ *	NULL is returned on failure (no space left?)
+ */
+int hvvm_map_pages(void *vaddr, int pages, unsigned long *hvaddr)
+{
+	unsigned long paddr;
+	unsigned long addr;
+	pgprot_t prot;
+	int i;
+	int ret;
+
+	if ((unsigned long)vaddr & (PAGE_SIZE - 1)) {
+		printk("bad vaddr for hv mapping (%p)\n",
+		       vaddr);
+		return -EINVAL;
+	}
+
+	/*
+	 * First we need to find a place to allocate.
+	 */
+	/* FIXME - ADD LOCKING!!! */
+	addr =3D alloc_hv_pages(pages);
+	*hvaddr =3D addr;
+	printk("addr=3D%lx\n", addr);
+	if (!addr)
+		return -ENOMEM;
+
+	ret =3D -ENOMEM;
+
+	for (i=3D0; i < pages; i++, vaddr +=3D PAGE_SIZE, addr +=3D PAGE_SIZE) {
+		paddr =3D hvvm_get_actual_phys(vaddr, &prot);
+		printk("%d: paddr=3D%lx\n", i, paddr);
+		if (!paddr)
+			goto out;
+		ret =3D hvvm_alloc_page(addr, paddr, prot);
+		printk("%d: ret=3D%d addr=3D%lx\n", i, ret, addr);
+		if (ret < 0)
+			goto out;
+	}
+
+	addr =3D *hvaddr;
+	vaddr -=3D PAGE_SIZE * pages;
+	printk("vaddr=3D%p (%lx)\naddr=3D%p (%lx)\n",
+	       vaddr, *(unsigned long*)vaddr,
+	       (void*)addr, *(unsigned long*)addr);
+
+	return 0;
+out:
+	for (--i; i >=3D0; i--) {
+		addr -=3D PAGE_SIZE;
+		hvvm_unmap_page(addr);
+	}
+
+	release_hv_pages(addr, pages);
+	return ret;
+}
+
+void hvvm_unmap_pages(unsigned long addr, int pages)
+{
+	int i;
+
+	release_hv_pages(addr, pages);
+	for (i=3D0; i < pages; i++, addr +=3D PAGE_SIZE)
+		hvvm_unmap_page(addr);
+}
+
+void hvvm_release_all(void)
+{
+	int bit;
+	unsigned long vaddr =3D HVVM_START;
+
+	for (bit=3D0; bit < NR_HV_PAGES; bit++, vaddr +=3D PAGE_SIZE)
+		if (test_bit(bit, hvvm_avail_pages)) {
+			hvvm_unmap_page(vaddr);
+			clear_bit(bit, hvvm_avail_pages);
+		}
+}
Index: work-pv/include/asm-x86_64/fixmap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/include/asm-x86_64/fixmap.h
+++ work-pv/include/asm-x86_64/fixmap.h
@@ -16,6 +16,7 @@
 #include <asm/page.h>
 #include <asm/vsyscall.h>
 #include <asm/vsyscall32.h>
+#include <asm/hv_vm.h>
 =

 /*
  * Here we define all the compile-time 'special' virtual
@@ -40,6 +41,8 @@ enum fixed_addresses {
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 	FIX_IO_APIC_BASE_0,
 	FIX_IO_APIC_BASE_END =3D FIX_IO_APIC_BASE_0 + MAX_IO_APICS-1,
+	FIX_HV_BASE,
+	FIX_HV_BASE_END =3D FIX_HV_BASE + HV_VIRT_SIZE - 1,
 	__end_of_fixed_addresses
 };
 =

Index: work-pv/include/asm-x86_64/hv_vm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/include/asm-x86_64/hv_vm.h
@@ -0,0 +1,13 @@
+#ifndef _LINUX_HV_VM
+#define _LINUX_HV_VM
+
+#define NR_HV_PAGES  256 /* meg? */
+#define HV_VIRT_SIZE (NR_HV_PAGES << PAGE_SHIFT)
+
+#define HVVM_START (__fix_to_virt(FIX_HV_BASE_END))
+
+int hvvm_map_pages(void *vaddr, int pages, unsigned long *hvaddr);
+void hvvm_unmap_pages(unsigned long addr, int pages);
+void hvvm_release_all(void);
+
+#endif

--
