From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 11/21] Xen-paravirt: Add apply_to_page_range() which applies a
	function to a pte range.
Date: Tue, 13 Feb 2007 14:17:40 -0800
Message-ID: <20070213221830.313475541@goop.org>
References: <20070213221729.772002682@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=apply-to-page-range.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Christoph Lameter <clameter@sgi.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add a new mm function apply_to_page_range() which applies a given
function to every pte in a given virtual address range in a given mm
structure. This is a generic alternative to cut-and-pasting the Linux
idiomatic pagetable walking code in every place that a sequence of
PTEs must be accessed.

Although this interface is intended to be useful in a wide range of
situations, it is currently used specifically by several Xen
subsystems, for example: to ensure that pagetables have been allocated
for a virtual address range, and to construct batched special
pagetable update requests to map I/O memory (in ioremap()).

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Christoph Lameter <clameter@sgi.com>

---
 include/linux/mm.h |    5 ++
 mm/memory.c        |   94 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 99 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1130,6 +1130,11 @@ struct page *follow_page(struct vm_area_
 =

 unsigned long __follow_page(void *vaddr);
 =

+typedef int (*pte_fn_t)(pte_t *pte, struct page *pmd_page, unsigned long a=
ddr,
+			void *data);
+extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
+			       unsigned long size, pte_fn_t fn, void *data);
+
 #ifdef CONFIG_PROC_FS
 void vm_stat_account(struct mm_struct *, unsigned long, struct file *, lon=
g);
 #else
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1414,6 +1414,100 @@ int remap_pfn_range(struct vm_area_struc
 }
 EXPORT_SYMBOL(remap_pfn_range);
 =

+static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
+				     unsigned long addr, unsigned long end,
+				     pte_fn_t fn, void *data)
+{
+	pte_t *pte;
+	int err;
+	struct page *pmd_page;
+	spinlock_t *ptl;
+
+	pte =3D (mm =3D=3D &init_mm) ?
+		pte_alloc_kernel(pmd, addr) :
+		pte_alloc_map_lock(mm, pmd, addr, &ptl);
+	if (!pte)
+		return -ENOMEM;
+
+	BUG_ON(pmd_huge(*pmd));
+
+	pmd_page =3D pmd_page(*pmd);
+
+	do {
+		err =3D fn(pte, pmd_page, addr, data);
+		if (err)
+			break;
+	} while (pte++, addr +=3D PAGE_SIZE, addr !=3D end);
+
+	if (mm !=3D &init_mm)
+		pte_unmap_unlock(pte-1, ptl);
+	return err;
+}
+
+static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
+				     unsigned long addr, unsigned long end,
+				     pte_fn_t fn, void *data)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	int err;
+
+	pmd =3D pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -ENOMEM;
+	do {
+		next =3D pmd_addr_end(addr, end);
+		err =3D apply_to_pte_range(mm, pmd, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pmd++, addr =3D next, addr !=3D end);
+	return err;
+}
+
+static int apply_to_pud_range(struct mm_struct *mm, pgd_t *pgd,
+				     unsigned long addr, unsigned long end,
+				     pte_fn_t fn, void *data)
+{
+	pud_t *pud;
+	unsigned long next;
+	int err;
+
+	pud =3D pud_alloc(mm, pgd, addr);
+	if (!pud)
+		return -ENOMEM;
+	do {
+		next =3D pud_addr_end(addr, end);
+		err =3D apply_to_pmd_range(mm, pud, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pud++, addr =3D next, addr !=3D end);
+	return err;
+}
+
+/*
+ * Scan a region of virtual memory, filling in page tables as necessary
+ * and calling a provided function on each leaf page table.
+ */
+int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
+			unsigned long size, pte_fn_t fn, void *data)
+{
+	pgd_t *pgd;
+	unsigned long next;
+	unsigned long end =3D addr + size;
+	int err;
+
+	BUG_ON(addr >=3D end);
+	pgd =3D pgd_offset(mm, addr);
+	do {
+		next =3D pgd_addr_end(addr, end);
+		err =3D apply_to_pud_range(mm, pgd, addr, next, fn, data);
+		if (err)
+			break;
+	} while (pgd++, addr =3D next, addr !=3D end);
+	return err;
+}
+EXPORT_SYMBOL_GPL(apply_to_page_range);
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry
  * which was read non-atomically.  Before making any commitment, on

-- =
