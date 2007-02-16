From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 12/21] Xen-paravirt: Allocate and free vmalloc areas
Date: Thu, 15 Feb 2007 18:25:01 -0800
Message-ID: <20070216022531.417300365@goop.org>
References: <20070216022449.739760547@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=alloc-vm-area.patch
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Allocate/destroy a 'vmalloc' VM area: alloc_vm_area and free_vm_area
The alloc function ensures that page tables are constructed for the
region of kernel virtual address space and mapped into init_mm.

Lock an area so that PTEs are accessible in the current address space:
lock_vm_area and unlock_vm_area.  The lock function prevents context
switches to a lazy mm that doesn't have the area mapped into its page
tables.  It also ensures that the page tables are mapped into the
current mm by causing the page fault handler to copy the page
directory pointers from init_mm into the current mm.

These functions are not particularly Xen-specific, so they're put into
mm/vmalloc.c.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: "Jan Beulich" <JBeulich@novell.com>

--
 include/linux/vmalloc.h |    8 +++++
 mm/vmalloc.c            |   62 +++++++++++++++++++++++++++++++++++++++++++=
+++
 2 files changed, 70 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -68,6 +68,14 @@ extern int map_vm_area(struct vm_struct =

 			struct page ***pages);
 extern void unmap_vm_area(struct vm_struct *area);
 =

+/* Allocate/destroy a 'vmalloc' VM area. */
+extern struct vm_struct *alloc_vm_area(unsigned long size);
+extern void free_vm_area(struct vm_struct *area);
+
+/* Lock an area so that PTEs are accessible in the current address space. =
*/
+extern void lock_vm_area(struct vm_struct *area);
+extern void unlock_vm_area(struct vm_struct *area);
+
 /*
  *	Internals.  Dont't use..
  */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -747,3 +747,65 @@ out_einval_locked:
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
 =

+static int f(pte_t *pte, struct page *pmd_page, unsigned long addr, void *=
data)
+{
+	/* apply_to_page_range() does all the hard work. */
+	return 0;
+}
+
+struct vm_struct *alloc_vm_area(unsigned long size)
+{
+	struct vm_struct *area;
+
+	area =3D get_vm_area(size, VM_IOREMAP);
+	if (area =3D=3D NULL)
+		return NULL;
+
+	/*
+	 * This ensures that page tables are constructed for this region
+	 * of kernel virtual address space and mapped into init_mm.
+	 */
+	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
+				area->size, f, NULL)) {
+		free_vm_area(area);
+		return NULL;
+	}
+
+	return area;
+}
+EXPORT_SYMBOL_GPL(alloc_vm_area);
+
+void free_vm_area(struct vm_struct *area)
+{
+	struct vm_struct *ret;
+	ret =3D remove_vm_area(area->addr);
+	BUG_ON(ret !=3D area);
+	kfree(area);
+}
+EXPORT_SYMBOL_GPL(free_vm_area);
+
+void lock_vm_area(struct vm_struct *area)
+{
+	unsigned long i;
+	char c;
+
+	/*
+	 * Prevent context switch to a lazy mm that doesn't have this area
+	 * mapped into its page tables.
+	 */
+	preempt_disable();
+
+	/*
+	 * Ensure that the page tables are mapped into the current mm. The
+	 * page-fault path will copy the page directory pointers from init_mm.
+	 */
+	for (i =3D 0; i < area->size; i +=3D PAGE_SIZE)
+		(void)__get_user(c, (char __user *)area->addr + i);
+}
+EXPORT_SYMBOL_GPL(lock_vm_area);
+
+void unlock_vm_area(struct vm_struct *area)
+{
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(unlock_vm_area);

-- =
