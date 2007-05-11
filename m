From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 01/28]xen: Allocate and free vmalloc areas
Date: Thu, 10 May 2007 17:06:44 -0700
Message-ID: <20070511001155.200690000@goop.org>
References: <20070511000643.025196000@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=alloc-vm-area.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Ian Pratt <ian.pratt@xensource.com>, Andi Kleen <ak@muc.de>, lkml <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Allocate/destroy a 'vmalloc' VM area: alloc_vm_area and free_vm_area
The alloc function ensures that page tables are constructed for the
region of kernel virtual address space and mapped into init_mm.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: "Jan Beulich" <JBeulich@novell.com>
Cc: "Andi Kleen" <ak@muc.de>

---
 include/linux/vmalloc.h |    4 +++
 mm/vmalloc.c            |   53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

===================================================================
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -69,6 +69,10 @@ extern int map_vm_area(struct vm_struct 
 			struct page ***pages);
 extern void unmap_vm_area(struct vm_struct *area);
 
+/* Allocate/destroy a 'vmalloc' VM area. */
+extern struct vm_struct *alloc_vm_area(unsigned long size);
+extern void free_vm_area(struct vm_struct *area);
+
 /*
  *	Internals.  Dont't use..
  */
===================================================================
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -762,3 +762,56 @@ void  __attribute__((weak)) vmalloc_sync
 void  __attribute__((weak)) vmalloc_sync_all(void)
 {
 }
+
+
+static int f(pte_t *pte, struct page *pmd_page, unsigned long addr, void *data)
+{
+	/* apply_to_page_range() does all the hard work. */
+	return 0;
+}
+
+/**
+ *	alloc_vm_area - allocate a range of kernel address space
+ *	@size:		size of the area
+ *	@returns:	NULL on failure, vm_struct on success
+ *
+ *	This function reserves a range of kernel address space, and
+ *	allocates pagetables to map that range.  No actual mappings
+ *	are created.  If the kernel address space is not shared
+ *	between processes, it syncs the pagetable across all
+ *	processes.
+ */
+struct vm_struct *alloc_vm_area(unsigned long size)
+{
+	struct vm_struct *area;
+
+	area = get_vm_area(size, VM_IOREMAP);
+	if (area == NULL)
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
+	/* Make sure the pagetables are constructed in process kernel
+	   mappings */
+	vmalloc_sync_all();
+
+	return area;
+}
+EXPORT_SYMBOL_GPL(alloc_vm_area);
+
+void free_vm_area(struct vm_struct *area)
+{
+	struct vm_struct *ret;
+	ret = remove_vm_area(area->addr);
+	BUG_ON(ret != area);
+	kfree(area);
+}
+EXPORT_SYMBOL_GPL(free_vm_area);

-- 
