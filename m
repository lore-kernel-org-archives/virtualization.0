From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 21/24] Xen-paravirt_ops: Add Xen grant table support
Date: Wed, 21 Feb 2007 12:53:15 -0800
Message-ID: <20070221205324.063557617@goop.org>
References: <20070221205254.169835700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=xen-grant-table.patch
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add Xen 'grant table' driver which allows granting of access to
selected local memory pages by other virtual machines and,
symmetrically, the mapping of remote memory pages which other virtual
machines have granted access to.

This driver is a prerequisite for many of the Xen virtual device
drivers, which grant the 'device driver domain' restricted and
temporary access to only those memory pages that are currently
involved in I/O operations.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/xen/Makefile      |    1
 drivers/xen/grant-table.c |  446 +++++++++++++++++++++++++++++++++++++++++=
++++
 include/xen/grant_table.h |  107 ++++++++++
 3 files changed, 554 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,1 +1,2 @@ obj-y	+=3D hvc-console.o
+obj-y	+=3D grant-table.o
 obj-y	+=3D hvc-console.o
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/xen/grant-table.c
@@ -0,0 +1,454 @@
+/*************************************************************************=
*****
+ * grant_table.c
+ *
+ * Granting foreign access to our memory reservation.
+ *
+ * Copyright (c) 2005, Christopher Clark
+ * Copyright (c) 2004-2005, K A Fraser
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modi=
fy,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Softw=
are,
+ * and to permit persons to whom the Software is furnished to do so, subje=
ct to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <xen/interface/xen.h>
+#include <xen/page.h>
+#include <xen/grant_table.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/sync_bitops.h>
+
+
+/* External tools reserve first few grant table entries. */
+#define NR_RESERVED_ENTRIES 8
+
+#define NR_GRANT_ENTRIES \
+	(NR_GRANT_FRAMES * PAGE_SIZE / sizeof(struct grant_entry))
+#define GNTTAB_LIST_END (NR_GRANT_ENTRIES + 1)
+
+static grant_ref_t gnttab_list[NR_GRANT_ENTRIES];
+static int gnttab_free_count;
+static grant_ref_t gnttab_free_head;
+static DEFINE_SPINLOCK(gnttab_list_lock);
+
+static struct grant_entry *shared;
+
+static struct gnttab_free_callback *gnttab_free_callback_list;
+
+static int get_free_entries(int count)
+{
+	unsigned long flags;
+	int ref;
+	grant_ref_t head;
+	spin_lock_irqsave(&gnttab_list_lock, flags);
+	if (gnttab_free_count < count) {
+		spin_unlock_irqrestore(&gnttab_list_lock, flags);
+		return -1;
+	}
+	ref =3D head =3D gnttab_free_head;
+	gnttab_free_count -=3D count;
+	while (count-- > 1)
+		head =3D gnttab_list[head];
+	gnttab_free_head =3D gnttab_list[head];
+	gnttab_list[head] =3D GNTTAB_LIST_END;
+	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+	return ref;
+}
+
+#define get_free_entry() get_free_entries(1)
+
+static void do_free_callbacks(void)
+{
+	struct gnttab_free_callback *callback, *next;
+
+	callback =3D gnttab_free_callback_list;
+	gnttab_free_callback_list =3D NULL;
+
+	while (callback !=3D NULL) {
+		next =3D callback->next;
+		if (gnttab_free_count >=3D callback->count) {
+			callback->next =3D NULL;
+			callback->fn(callback->arg);
+		} else {
+			callback->next =3D gnttab_free_callback_list;
+			gnttab_free_callback_list =3D callback;
+		}
+		callback =3D next;
+	}
+}
+
+static inline void check_free_callbacks(void)
+{
+	if (unlikely(gnttab_free_callback_list))
+		do_free_callbacks();
+}
+
+static void put_free_entry(grant_ref_t ref)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&gnttab_list_lock, flags);
+	gnttab_list[ref] =3D gnttab_free_head;
+	gnttab_free_head =3D ref;
+	gnttab_free_count++;
+	check_free_callbacks();
+	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+}
+
+static void update_grant_entry(grant_ref_t ref, domid_t domid,
+			       unsigned long frame, unsigned flags)
+{
+	/*
+	 * Introducing a valid entry into the grant table:
+	 *  1. Write ent->domid.
+	 *  2. Write ent->frame:
+	 *      GTF_permit_access:   Frame to which access is permitted.
+	 *      GTF_accept_transfer: Pseudo-phys frame slot being filled by new
+	 *                           frame, or zero if none.
+	 *  3. Write memory barrier (WMB).
+	 *  4. Write ent->flags, inc. valid type.
+	 */
+	shared[ref].frame =3D frame;
+	shared[ref].domid =3D domid;
+	wmb();
+	shared[ref].flags =3D flags;
+}
+
+/*
+ * Public grant-issuing interface functions
+ */
+void gnttab_grant_foreign_access_ref(grant_ref_t ref, domid_t domid,
+				     unsigned long frame, int readonly)
+{
+	update_grant_entry(ref, domid, frame,
+			   GTF_permit_access | (readonly ? GTF_readonly : 0));
+}
+EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access_ref);
+
+int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
+				int readonly)
+{
+	int ref;
+
+	if (unlikely((ref =3D get_free_entry()) =3D=3D -1))
+		return -ENOSPC;
+
+	gnttab_grant_foreign_access_ref(ref, domid, frame, readonly);
+
+	return ref;
+}
+EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);
+
+int gnttab_query_foreign_access(grant_ref_t ref)
+{
+	u16 nflags;
+
+	nflags =3D shared[ref].flags;
+
+	return (nflags & (GTF_reading|GTF_writing));
+}
+EXPORT_SYMBOL_GPL(gnttab_query_foreign_access);
+
+int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly)
+{
+	u16 flags, nflags;
+
+	nflags =3D shared[ref].flags;
+	do {
+		if ((flags =3D nflags) & (GTF_reading|GTF_writing)) {
+			printk(KERN_ALERT "WARNING: g.e. still in use!\n");
+			return 0;
+		}
+	} while ((nflags =3D sync_cmpxchg(&shared[ref].flags, flags, 0)) !=3D
+		 flags);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(gnttab_end_foreign_access_ref);
+
+void gnttab_end_foreign_access(grant_ref_t ref, int readonly,
+			       unsigned long page)
+{
+	if (gnttab_end_foreign_access_ref(ref, readonly)) {
+		put_free_entry(ref);
+		if (page !=3D 0)
+			free_page(page);
+	} else {
+		/* XXX This needs to be fixed so that the ref and page are
+		   placed on a list to be freed up later. */
+		printk(KERN_WARNING
+		       "WARNING: leaking g.e. and page still in use!\n");
+	}
+}
+EXPORT_SYMBOL_GPL(gnttab_end_foreign_access);
+
+int gnttab_grant_foreign_transfer(domid_t domid, unsigned long pfn)
+{
+	int ref;
+
+	if (unlikely((ref =3D get_free_entry()) =3D=3D -1))
+		return -ENOSPC;
+	gnttab_grant_foreign_transfer_ref(ref, domid, pfn);
+
+	return ref;
+}
+EXPORT_SYMBOL_GPL(gnttab_grant_foreign_transfer);
+
+void gnttab_grant_foreign_transfer_ref(grant_ref_t ref, domid_t domid,
+				       unsigned long pfn)
+{
+	update_grant_entry(ref, domid, pfn, GTF_accept_transfer);
+}
+EXPORT_SYMBOL_GPL(gnttab_grant_foreign_transfer_ref);
+
+unsigned long gnttab_end_foreign_transfer_ref(grant_ref_t ref)
+{
+	unsigned long frame;
+	u16           flags;
+
+	/*
+	 * If a transfer is not even yet started, try to reclaim the grant
+	 * reference and return failure (=3D=3D 0).
+	 */
+	while (!((flags =3D shared[ref].flags) & GTF_transfer_committed)) {
+		if (sync_cmpxchg(&shared[ref].flags, flags, 0) =3D=3D flags)
+			return 0;
+		cpu_relax();
+	}
+
+	/* If a transfer is in progress then wait until it is completed. */
+	while (!(flags & GTF_transfer_completed)) {
+		flags =3D shared[ref].flags;
+		cpu_relax();
+	}
+
+	rmb();	/* Read the frame number /after/ reading completion status. */
+	frame =3D shared[ref].frame;
+	BUG_ON(frame =3D=3D 0);
+
+	return frame;
+}
+EXPORT_SYMBOL_GPL(gnttab_end_foreign_transfer_ref);
+
+unsigned long gnttab_end_foreign_transfer(grant_ref_t ref)
+{
+	unsigned long frame =3D gnttab_end_foreign_transfer_ref(ref);
+	put_free_entry(ref);
+	return frame;
+}
+EXPORT_SYMBOL_GPL(gnttab_end_foreign_transfer);
+
+void gnttab_free_grant_reference(grant_ref_t ref)
+{
+	put_free_entry(ref);
+}
+EXPORT_SYMBOL_GPL(gnttab_free_grant_reference);
+
+void gnttab_free_grant_references(grant_ref_t head)
+{
+	grant_ref_t ref;
+	unsigned long flags;
+	int count =3D 1;
+	if (head =3D=3D GNTTAB_LIST_END)
+		return;
+	spin_lock_irqsave(&gnttab_list_lock, flags);
+	ref =3D head;
+	while (gnttab_list[ref] !=3D GNTTAB_LIST_END) {
+		ref =3D gnttab_list[ref];
+		count++;
+	}
+	gnttab_list[ref] =3D gnttab_free_head;
+	gnttab_free_head =3D head;
+	gnttab_free_count +=3D count;
+	check_free_callbacks();
+	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+}
+EXPORT_SYMBOL_GPL(gnttab_free_grant_references);
+
+int gnttab_alloc_grant_references(u16 count, grant_ref_t *head)
+{
+	int h =3D get_free_entries(count);
+
+	if (h =3D=3D -1)
+		return -ENOSPC;
+
+	*head =3D h;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gnttab_alloc_grant_references);
+
+int gnttab_empty_grant_references(const grant_ref_t *private_head)
+{
+	return (*private_head =3D=3D GNTTAB_LIST_END);
+}
+EXPORT_SYMBOL_GPL(gnttab_empty_grant_references);
+
+int gnttab_claim_grant_reference(grant_ref_t *private_head)
+{
+	grant_ref_t g =3D *private_head;
+	if (unlikely(g =3D=3D GNTTAB_LIST_END))
+		return -ENOSPC;
+	*private_head =3D gnttab_list[g];
+	return g;
+}
+EXPORT_SYMBOL_GPL(gnttab_claim_grant_reference);
+
+void gnttab_release_grant_reference(grant_ref_t *private_head,
+				    grant_ref_t release)
+{
+	gnttab_list[release] =3D *private_head;
+	*private_head =3D release;
+}
+EXPORT_SYMBOL_GPL(gnttab_release_grant_reference);
+
+void gnttab_request_free_callback(struct gnttab_free_callback *callback,
+				  void (*fn)(void *), void *arg, u16 count)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&gnttab_list_lock, flags);
+	if (callback->next)
+		goto out;
+	callback->fn =3D fn;
+	callback->arg =3D arg;
+	callback->count =3D count;
+	callback->next =3D gnttab_free_callback_list;
+	gnttab_free_callback_list =3D callback;
+	check_free_callbacks();
+out:
+	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+}
+EXPORT_SYMBOL_GPL(gnttab_request_free_callback);
+
+void gnttab_cancel_free_callback(struct gnttab_free_callback *callback)
+{
+	struct gnttab_free_callback **pcb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gnttab_list_lock, flags);
+	for (pcb =3D &gnttab_free_callback_list; *pcb; pcb =3D &(*pcb)->next) {
+		if (*pcb =3D=3D callback) {
+			*pcb =3D callback->next;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&gnttab_list_lock, flags);
+}
+EXPORT_SYMBOL_GPL(gnttab_cancel_free_callback);
+
+#ifndef __ia64__
+static int map_pte_fn(pte_t *pte, struct page *pmd_page,
+		      unsigned long addr, void *data)
+{
+	unsigned long **frames =3D (unsigned long **)data;
+
+	set_pte_at(&init_mm, addr, pte, mfn_pte((*frames)[0], PAGE_KERNEL));
+	(*frames)++;
+	return 0;
+}
+
+static int unmap_pte_fn(pte_t *pte, struct page *pmd_page,
+			unsigned long addr, void *data)
+{
+
+	set_pte_at(&init_mm, addr, pte, __pte(0));
+	return 0;
+}
+#endif
+
+int gnttab_resume(void)
+{
+	struct gnttab_setup_table setup;
+	unsigned long frames[NR_GRANT_FRAMES];
+	int rc;
+
+	setup.dom        =3D DOMID_SELF;
+	setup.nr_frames  =3D NR_GRANT_FRAMES;
+	setup.frame_list =3D frames;
+
+	rc =3D HYPERVISOR_grant_table_op(GNTTABOP_setup_table, &setup, 1);
+	if (rc =3D=3D -ENOSYS)
+		return -ENOSYS;
+
+	BUG_ON(rc || setup.status);
+
+#ifndef __ia64__
+	{
+		void *pframes =3D frames;
+		struct vm_struct *area;
+
+		if (shared =3D=3D NULL) {
+			area =3D get_vm_area(PAGE_SIZE * NR_GRANT_FRAMES,
+					   VM_IOREMAP);
+			BUG_ON(area =3D=3D NULL);
+			shared =3D area->addr;
+		}
+		rc =3D apply_to_page_range(&init_mm, (unsigned long)shared,
+					 PAGE_SIZE * NR_GRANT_FRAMES,
+					 map_pte_fn, &pframes);
+		BUG_ON(rc);
+	}
+#else
+	shared =3D __va(frames[0] << PAGE_SHIFT);
+	printk("grant table at %p\n", shared);
+#endif
+
+	return 0;
+}
+
+int gnttab_suspend(void)
+{
+
+#ifndef __ia64__
+	apply_to_page_range(&init_mm, (unsigned long)shared,
+			    PAGE_SIZE * NR_GRANT_FRAMES,
+			    unmap_pte_fn, NULL);
+#endif
+
+	return 0;
+}
+
+static int __init gnttab_init(void)
+{
+	int i;
+
+	if (!is_running_on_xen())
+		return -ENODEV;
+
+	if (gnttab_resume() < 0)
+		return -ENODEV;
+
+	for (i =3D NR_RESERVED_ENTRIES; i < NR_GRANT_ENTRIES; i++)
+		gnttab_list[i] =3D i + 1;
+	gnttab_free_count =3D NR_GRANT_ENTRIES - NR_RESERVED_ENTRIES;
+	gnttab_free_head  =3D NR_RESERVED_ENTRIES;
+
+	printk("Grant table initialized\n");
+	return 0;
+}
+
+core_initcall(gnttab_init);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/include/xen/grant_table.h
@@ -0,0 +1,107 @@
+/*************************************************************************=
*****
+ * grant_table.h
+ * =

+ * Two sets of functionality:
+ * 1. Granting foreign access to our memory reservation.
+ * 2. Accessing others' memory reservations via grant references.
+ * (i.e., mechanisms for both sender and recipient of grant references)
+ * =

+ * Copyright (c) 2004-2005, K A Fraser
+ * Copyright (c) 2005, Christopher Clark
+ * =

+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * =

+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modi=
fy,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Softw=
are,
+ * and to permit persons to whom the Software is furnished to do so, subje=
ct to
+ * the following conditions:
+ * =

+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ * =

+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef __ASM_GNTTAB_H__
+#define __ASM_GNTTAB_H__
+
+#include <asm/xen/hypervisor.h>
+#include <xen/interface/grant_table.h>
+
+/* NR_GRANT_FRAMES must be less than or equal to that configured in Xen */
+#define NR_GRANT_FRAMES 4
+
+struct gnttab_free_callback {
+	struct gnttab_free_callback *next;
+	void (*fn)(void *);
+	void *arg;
+	u16 count;
+};
+
+int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
+				int readonly);
+
+/*
+ * End access through the given grant reference, iff the grant entry is no
+ * longer in use.  Return 1 if the grant entry was freed, 0 if it is still=
 in
+ * use.
+ */
+int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly);
+
+/*
+ * Eventually end access through the given grant reference, and once that
+ * access has been ended, free the given page too.  Access will be ended
+ * immediately iff the grant entry is not in use, otherwise it will happen
+ * some time later.  page may be 0, in which case no freeing will occur.
+ */
+void gnttab_end_foreign_access(grant_ref_t ref, int readonly,
+			       unsigned long page);
+
+int gnttab_grant_foreign_transfer(domid_t domid, unsigned long pfn);
+
+unsigned long gnttab_end_foreign_transfer_ref(grant_ref_t ref);
+unsigned long gnttab_end_foreign_transfer(grant_ref_t ref);
+
+int gnttab_query_foreign_access(grant_ref_t ref);
+
+/*
+ * operations on reserved batches of grant references
+ */
+int gnttab_alloc_grant_references(u16 count, grant_ref_t *pprivate_head);
+
+void gnttab_free_grant_reference(grant_ref_t ref);
+
+void gnttab_free_grant_references(grant_ref_t head);
+
+int gnttab_empty_grant_references(const grant_ref_t *pprivate_head);
+
+int gnttab_claim_grant_reference(grant_ref_t *pprivate_head);
+
+void gnttab_release_grant_reference(grant_ref_t *private_head,
+				    grant_ref_t release);
+
+void gnttab_request_free_callback(struct gnttab_free_callback *callback,
+				  void (*fn)(void *), void *arg, u16 count);
+void gnttab_cancel_free_callback(struct gnttab_free_callback *callback);
+
+void gnttab_grant_foreign_access_ref(grant_ref_t ref, domid_t domid,
+				     unsigned long frame, int readonly);
+
+void gnttab_grant_foreign_transfer_ref(grant_ref_t, domid_t domid,
+				       unsigned long pfn);
+
+#define gnttab_map_vaddr(map) ((void *)(map.host_virt_addr))
+
+#endif /* __ASM_GNTTAB_H__ */

-- =
