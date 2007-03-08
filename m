From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 09/13] lguest64 devices
Date: Thu, 08 Mar 2007 12:39:04 -0500
Message-ID: <1173375544.32170.11.camel@localhost.localdomain>
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

plain text document attachment (lguest64-device.patch)
We started working a little bit on the devices for lguest64.
This is still very much a work-in-progress and needs much more work.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>



Index: work-pv/include/asm-x86_64/lguest_device.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/include/asm-x86_64/lguest_device.h
@@ -0,0 +1,31 @@
+#ifndef _ASM_LGUEST_DEVICE_H
+#define _ASM_LGUEST_DEVICE_H
+/* Everything you need to know about lguest devices. */
+#include <linux/device.h>
+#include <asm/lguest.h>
+#include <asm/lguest_user.h>
+
+struct lguest_device {
+	/* Unique busid, and index into lguest_page->devices[] */
+	/* By convention, each device can use irq index+1 if it wants to. */
+	unsigned int index;
+
+	struct device dev;
+
+	/* Driver can hang data off here. */
+	void *private;
+};
+
+struct lguest_driver {
+	const char *name;
+	struct module *owner;
+	u16 device_type;
+	int (*probe)(struct lguest_device *dev);
+	void (*remove)(struct lguest_device *dev);
+
+	struct device_driver drv;
+};
+
+extern int register_lguest_driver(struct lguest_driver *drv);
+extern void unregister_lguest_driver(struct lguest_driver *drv);
+#endif /* _ASM_LGUEST_DEVICE_H */
Index: work-pv/arch/x86_64/lguest/lguest_bus.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/lguest_bus.c
@@ -0,0 +1,180 @@
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <asm/lguest_device.h>
+#include <asm/lguest.h>
+#include <asm/io.h>
+
+static ssize_t type_show(struct device *_dev,
+                         struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%hu", lguest_devices[dev->index].type);
+}
+static ssize_t features_show(struct device *_dev,
+                             struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%hx", lguest_devices[dev->index].features);
+}
+static ssize_t pfn_show(struct device *_dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%llu", lguest_devices[dev->index].pfn);
+}
+static ssize_t status_show(struct device *_dev,
+                           struct device_attribute *attr, char *buf)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	return sprintf(buf, "%hx", lguest_devices[dev->index].status);
+}
+static ssize_t status_store(struct device *_dev, struct device_attribute *=
attr,
+                            const char *buf, size_t count)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	if (sscanf(buf, "%hi", &lguest_devices[dev->index].status) !=3D 1)
+		return -EINVAL;
+	return count;
+}
+static struct device_attribute lguest_dev_attrs[] =3D {
+	__ATTR_RO(type),
+	__ATTR_RO(features),
+	__ATTR_RO(pfn),
+	__ATTR(status, 0644, status_show, status_store),
+	__ATTR_NULL
+};
+
+static int lguest_dev_match(struct device *_dev, struct device_driver *_dr=
v)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	struct lguest_driver *drv =3D container_of(_drv,struct lguest_driver,drv);
+
+	return (drv->device_type =3D=3D lguest_devices[dev->index].type);
+}
+
+struct lguest_bus {
+	struct bus_type bus;
+	struct device dev;
+};
+
+static struct lguest_bus lguest_bus =3D {
+	.bus =3D {
+		.name  =3D "lguest",
+		.match =3D lguest_dev_match,
+		.dev_attrs =3D lguest_dev_attrs,
+	},
+	.dev =3D {
+		.parent =3D NULL,
+		.bus_id =3D "lguest",
+	}
+};
+
+static int lguest_dev_probe(struct device *_dev)
+{
+	int ret;
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	struct lguest_driver *drv =3D container_of(dev->dev.driver,
+						struct lguest_driver, drv);
+
+	lguest_devices[dev->index].status |=3D LGUEST_DEVICE_S_DRIVER;
+	ret =3D drv->probe(dev);
+	if (ret =3D=3D 0)
+		lguest_devices[dev->index].status |=3D LGUEST_DEVICE_S_DRIVER_OK;
+	return ret;
+}
+
+static int lguest_dev_remove(struct device *_dev)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+	struct lguest_driver *drv =3D container_of(dev->dev.driver,
+						struct lguest_driver, drv);
+
+	if (dev->dev.driver && drv->remove)
+		drv->remove(dev);
+	put_device(&dev->dev);
+	return 0;
+}
+
+int register_lguest_driver(struct lguest_driver *drv)
+{
+	if (!lguest_devices)
+		return 0;
+
+	drv->drv.bus =3D &lguest_bus.bus;
+	drv->drv.name =3D drv->name;
+	drv->drv.owner =3D drv->owner;
+	drv->drv.probe =3D lguest_dev_probe;
+	drv->drv.remove =3D lguest_dev_remove;
+
+	return driver_register(&drv->drv);
+}
+EXPORT_SYMBOL_GPL(register_lguest_driver);
+
+void unregister_lguest_driver(struct lguest_driver *drv)
+{
+	if (!lguest_devices)
+		return;
+
+	driver_unregister(&drv->drv);
+}
+EXPORT_SYMBOL_GPL(unregister_lguest_driver);
+
+static void release_lguest_device(struct device *_dev)
+{
+	struct lguest_device *dev =3D container_of(_dev,struct lguest_device,dev);
+
+	lguest_devices[dev->index].status |=3D LGUEST_DEVICE_S_REMOVED_ACK;
+	kfree(dev);
+}
+
+static void add_lguest_device(unsigned int index)
+{
+	struct lguest_device *new;
+
+	lguest_devices[index].status |=3D LGUEST_DEVICE_S_ACKNOWLEDGE;
+	new =3D kmalloc(sizeof(struct lguest_device), GFP_KERNEL);
+	if (!new) {
+		printk(KERN_EMERG "Cannot allocate lguest device %u\n", index);
+		lguest_devices[index].status |=3D LGUEST_DEVICE_S_FAILED;
+		return;
+	}
+
+	new->index =3D index;
+	new->private =3D NULL;
+	memset(&new->dev, 0, sizeof(new->dev));
+	new->dev.parent =3D &lguest_bus.dev;
+	new->dev.bus =3D &lguest_bus.bus;
+	new->dev.release =3D release_lguest_device;
+	sprintf(new->dev.bus_id, "%u", index);
+	if (device_register(&new->dev) !=3D 0) {
+		printk(KERN_EMERG "Cannot register lguest device %u\n", index);
+		lguest_devices[index].status |=3D LGUEST_DEVICE_S_FAILED;
+		kfree(new);
+	}
+}
+
+static void scan_devices(void)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < LGUEST_MAX_DEVICES; i++)
+		if (lguest_devices[i].type)
+			add_lguest_device(i);
+}
+
+static int __init lguest_bus_init(void)
+{
+	if (strcmp(paravirt_ops.name, "lguest") !=3D 0)
+		return 0;
+
+	/* Devices are in page above top of "normal" mem. */
+	lguest_devices =3D ioremap(max_pfn << PAGE_SHIFT, PAGE_SIZE);
+
+	if (bus_register(&lguest_bus.bus) !=3D 0
+	    || device_register(&lguest_bus.dev) !=3D 0)
+		panic("lguest bus registration failed");
+
+	scan_devices();
+	return 0;
+}
+postcore_initcall(lguest_bus_init);
Index: work-pv/arch/x86_64/lguest/io.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/arch/x86_64/lguest/io.c
@@ -0,0 +1,425 @@
+/* Simple I/O model for guests, based on shared memory.
+ * Copyright (C) 2006 Rusty Russell IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
USA
+ */
+#include <linux/types.h>
+#include <linux/futex.h>
+#include <linux/jhash.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/uaccess.h>
+#include <asm/lguest.h>
+#include <asm/lguest_user.h>
+#include "lguest.h"
+
+static struct list_head dma_hash[64];
+
+/* FIXME: allow multi-page lengths. */
+static int check_dma_list(struct lguest_guest_info *linfo,
+				const struct lguest_dma *dma)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < LGUEST_MAX_DMA_SECTIONS; i++) {
+		if (!dma->len[i])
+			return 1;
+		if (!lguest_address_ok(linfo, dma->addr[i]))
+			goto kill;
+		if (dma->len[i] > PAGE_SIZE)
+			goto kill;
+		/* We could do over a page, but is it worth it? */
+		if ((dma->addr[i] % PAGE_SIZE) + dma->len[i] > PAGE_SIZE)
+			goto kill;
+	}
+	return 1;
+
+kill:
+	kill_guest(linfo, "bad DMA entry: %u@%#llx", dma->len[i], dma->addr[i]);
+	return 0;
+}
+
+static unsigned int hash(const union futex_key *key)
+{
+	return jhash2((u32*)&key->both.word,
+		      (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
+		      key->both.offset)
+		% ARRAY_SIZE(dma_hash);
+}
+
+/* Must hold read lock on dmainfo owner's current->mm->mmap_sem */
+static void unlink_dma(struct lguest_dma_info *dmainfo)
+{
+	BUG_ON(!mutex_is_locked(&lguest_lock));
+	dmainfo->interrupt =3D 0;
+	list_del(&dmainfo->list);
+	drop_futex_key_refs(&dmainfo->key);
+}
+
+static inline int key_eq(const union futex_key *a, const union futex_key *=
b)
+{
+	return (a->both.word =3D=3D b->both.word
+		&& a->both.ptr =3D=3D b->both.ptr
+		&& a->both.offset =3D=3D b->both.offset);
+}
+
+static u32 unbind_dma(struct lguest_guest_info *linfo,
+		      const union futex_key *key,
+		      unsigned long dmas)
+{
+	int i, ret =3D 0;
+
+	for (i =3D 0; i < LGUEST_MAX_DMA; i++) {
+		if (key_eq(key, &linfo->dma[i].key) && dmas =3D=3D linfo->dma[i].dmas) {
+			unlink_dma(&linfo->dma[i]);
+			ret =3D 1;
+			break;
+		}
+	}
+	return ret;
+}
+
+u32 bind_dma(struct lguest_guest_info *linfo, unsigned long addr,
+				unsigned long dmas, u16 numdmas, u8 interrupt)
+{
+	unsigned int i;
+	u32 ret =3D 0;
+	union futex_key key;
+
+	printk("inside the handler, with args: %lx, %lx, %x, %x\n",addr,dmas,numd=
mas,interrupt);
+	if (interrupt >=3D LGUEST_IRQS)
+		return 0;
+
+	mutex_lock(&lguest_lock);
+	down_read(&current->mm->mmap_sem);
+	printk("Trying to get futex key...  ");
+	if (get_futex_key((u32 __user *)addr, &key) !=3D 0) {
+		kill_guest(linfo, "bad dma address %#lx", addr);
+		goto unlock;
+	}
+	printk("Got it.\n");
+	get_futex_key_refs(&key);
+
+	if (interrupt =3D=3D 0)
+		ret =3D unbind_dma(linfo, &key, dmas);
+	else {
+		for (i =3D 0; i < LGUEST_MAX_DMA; i++) {
+			if (linfo->dma[i].interrupt =3D=3D 0) {
+				linfo->dma[i].dmas =3D dmas;
+				linfo->dma[i].num_dmas =3D numdmas;
+				linfo->dma[i].next_dma =3D 0;
+				linfo->dma[i].key =3D key;
+				linfo->dma[i].guest_id =3D linfo->guest_id;
+				linfo->dma[i].interrupt =3D interrupt;
+				list_add(&linfo->dma[i].list,
+					 &dma_hash[hash(&key)]);
+				ret =3D 1;
+				printk("Will return, holding a reference\n");
+				goto unlock;
+			}
+		}
+	}
+	printk("Will return, _without_ a reference\n");
+	drop_futex_key_refs(&key);
+unlock:
+ 	up_read(&current->mm->mmap_sem);
+	mutex_unlock(&lguest_lock);
+	return ret;
+}
+/* lhread from another guest */
+static int lhread_other(struct lguest_guest_info *linfo,
+			void *buf, u32 addr, unsigned bytes)
+{
+	if (addr + bytes < addr
+	    || !lguest_address_ok(linfo, addr+bytes)
+	    || access_process_vm(linfo->tsk, addr, buf, bytes, 0) !=3D bytes) {
+		memset(buf, 0, bytes);
+		kill_guest(linfo, "bad address in registered DMA struct");
+		return 0;
+	}
+	return 1;
+}
+
+/* lhwrite to another guest */
+static int lhwrite_other(struct lguest_guest_info *linfo, u32 addr,
+			 const void *buf, unsigned bytes)
+{
+	if (addr + bytes < addr
+	    || !lguest_address_ok(linfo, addr+bytes)
+	    || (access_process_vm(linfo->tsk, addr, (void *)buf, bytes, 1)
+		!=3D bytes)) {
+		kill_guest(linfo, "bad address writing to registered DMA");
+		return 0;
+	}
+	return 1;
+}
+
+static u32 copy_data(const struct lguest_dma *src,
+		     const struct lguest_dma *dst,
+		     struct page *pages[])
+{
+	unsigned int totlen, si, di, srcoff, dstoff;
+	void *maddr =3D NULL;
+
+	totlen =3D 0;
+	si =3D di =3D 0;
+	srcoff =3D dstoff =3D 0;
+	while (si < LGUEST_MAX_DMA_SECTIONS && src->len[si]
+	       && di < LGUEST_MAX_DMA_SECTIONS && dst->len[di]) {
+		u32 len =3D min(src->len[si] - srcoff, dst->len[di] - dstoff);
+
+		if (!maddr)
+			maddr =3D kmap(pages[di]);
+
+		/* FIXME: This is not completely portable, since
+		   archs do different things for copy_to_user_page. */
+		if (copy_from_user(maddr + (dst->addr[di] + dstoff)%PAGE_SIZE,
+				   (void *__user)src->addr[si], len) !=3D 0) {
+			totlen =3D 0;
+			break;
+		}
+
+		totlen +=3D len;
+		srcoff +=3D len;
+		dstoff +=3D len;
+		if (srcoff =3D=3D src->len[si]) {
+			si++;
+			srcoff =3D 0;
+		}
+		if (dstoff =3D=3D dst->len[di]) {
+			kunmap(pages[di]);
+			maddr =3D NULL;
+			di++;
+			dstoff =3D 0;
+		}
+	}
+
+	if (maddr)
+		kunmap(pages[di]);
+
+	return totlen;
+}
+
+/* Src is us, ie. current. */
+static u32 do_dma(struct lguest_guest_info *srclg, const struct lguest_dma=
 *src,
+		  struct lguest_guest_info *dstlg, const struct lguest_dma *dst)
+{
+	int i;
+	u32 ret;
+	struct page *pages[LGUEST_MAX_DMA_SECTIONS];
+
+	if (!check_dma_list(dstlg, dst) || !check_dma_list(srclg, src))
+		return 0;
+
+	/* First get the destination pages */
+	for (i =3D 0; i < LGUEST_MAX_DMA_SECTIONS; i++) {
+		if (dst->len[i] =3D=3D 0)
+			break;
+		if (get_user_pages(dstlg->tsk, dstlg->mm,
+				   dst->addr[i], 1, 1, 1, pages+i, NULL)
+		    !=3D 1) {
+			ret =3D 0;
+			goto drop_pages;
+		}
+	}
+
+	/* Now copy until we run out of src or dst. */
+	ret =3D copy_data(src, dst, pages);
+
+drop_pages:
+	while (--i >=3D 0)
+		put_page(pages[i]);
+	return ret;
+}
+
+/* We cache one process to wakeup: helps for batching & wakes outside lock=
s. */
+void set_wakeup_process(struct lguest_guest_info *linfo,
+						struct task_struct *p)
+{
+	if (p =3D=3D linfo->wake)
+		return;
+
+	if (linfo->wake) {
+		wake_up_process(linfo->wake);
+		put_task_struct(linfo->wake);
+	}
+	linfo->wake =3D p;
+	if (linfo->wake)
+		get_task_struct(linfo->wake);
+}
+
+static int dma_transfer(struct lguest_guest_info *srclg,
+			unsigned long udma,
+			struct lguest_dma_info *dst)
+{
+#if 0
+	struct lguest_dma dst_dma, src_dma;
+	struct lguest_guest_info *dstlg;
+	u32 i, dma =3D 0;
+
+	dstlg =3D &lguests[dst->guest_id];
+	/* Get our dma list. */
+	lhread(srclg, &src_dma, udma, sizeof(src_dma));
+
+	/* We can't deadlock against them dmaing to us, because this
+	 * is all under the lguest_lock. */
+	down_read(&dstlg->mm->mmap_sem);
+
+	for (i =3D 0; i < dst->num_dmas; i++) {
+		dma =3D (dst->next_dma + i) % dst->num_dmas;
+		if (!lhread_other(dstlg, &dst_dma,
+				  dst->dmas + dma * sizeof(struct lguest_dma),
+				  sizeof(dst_dma))) {
+			goto fail;
+		}
+		if (!dst_dma.used_len)
+			break;
+	}
+	if (i !=3D dst->num_dmas) {
+		unsigned long used_lenp;
+		unsigned int ret;
+
+		ret =3D do_dma(srclg, &src_dma, dstlg, &dst_dma);
+		/* Put used length in src. */
+		lhwrite_u32(srclg,
+			    udma+offsetof(struct lguest_dma, used_len), ret);
+		if (ret =3D=3D 0 && src_dma.len[0] !=3D 0)
+			goto fail;
+
+		/* Make sure destination sees contents before length. */
+		mb();
+		used_lenp =3D dst->dmas
+			+ dma * sizeof(struct lguest_dma)
+			+ offsetof(struct lguest_dma, used_len);
+		lhwrite_other(dstlg, used_lenp, &ret, sizeof(ret));
+		dst->next_dma++;
+	}
+ 	up_read(&dstlg->mm->mmap_sem);
+
+	/* Do this last so dst doesn't simply sleep on lock. */
+	set_bit(dst->interrupt, dstlg->irqs_pending);
+	set_wakeup_process(srclg, dstlg->tsk);
+	return i =3D=3D dst->num_dmas;
+
+fail:
+	up_read(&dstlg->mm->mmap_sem);
+#endif
+	return 0;
+}
+
+int send_dma(struct lguest_guest_info *linfo, unsigned long addr,
+							unsigned long udma)
+{
+	union futex_key key;
+	int pending =3D 0, empty =3D 0;
+
+	printk("inside send_dma, with args: %lx, %lx\n",addr,udma);
+again:
+	mutex_lock(&lguest_lock);
+	down_read(&current->mm->mmap_sem);
+	if (get_futex_key((u32 __user *)addr, &key) !=3D 0) {
+		kill_guest(linfo, "bad sending DMA address");
+		goto unlock;
+	}
+	/* Shared mapping?  Look for other guests... */
+	if (key.shared.offset & 1) {
+		struct lguest_dma_info *i, *n;
+		list_for_each_entry_safe(i, n, &dma_hash[hash(&key)], list) {
+			if (i->guest_id =3D=3D linfo->guest_id)
+				continue;
+			if (!key_eq(&key, &i->key))
+				continue;
+
+			empty +=3D dma_transfer(linfo, udma, i);
+			break;
+		}
+		if (empty =3D=3D 1) {
+			/* Give any recipients one chance to restock. */
+			up_read(&current->mm->mmap_sem);
+			mutex_unlock(&lguest_lock);
+			yield();
+			empty++;
+			goto again;
+		}
+		pending =3D 0;
+	} else {
+		/* Private mapping: tell our userspace. */
+		linfo->dma_is_pending =3D 1;
+		linfo->pending_dma =3D udma;
+		linfo->pending_addr =3D addr;
+		pending =3D 1;
+	}
+unlock:
+	up_read(&current->mm->mmap_sem);
+	mutex_unlock(&lguest_lock);
+	printk("Returning send_dma with pending: %x\n",pending);
+	return pending;
+}
+void release_all_dma(struct lguest_guest_info *linfo)
+{
+	unsigned int i;
+
+	BUG_ON(!mutex_is_locked(&lguest_lock));
+
+	down_read(&linfo->mm->mmap_sem);
+	for (i =3D 0; i < LGUEST_MAX_DMA; i++) {
+		if (linfo->dma[i].interrupt)
+			unlink_dma(&linfo->dma[i]);
+	}
+	up_read(&linfo->mm->mmap_sem);
+}
+
+/* Userspace wants a dma buffer from this guest. */
+unsigned long get_dma_buffer(struct lguest_guest_info *linfo,
+			     unsigned long addr, unsigned long *interrupt)
+{
+	unsigned long ret =3D 0;
+	union futex_key key;
+	struct lguest_dma_info *i;
+
+	mutex_lock(&lguest_lock);
+	down_read(&current->mm->mmap_sem);
+	if (get_futex_key((u32 __user *)addr, &key) !=3D 0) {
+		kill_guest(linfo, "bad registered DMA buffer");
+		goto unlock;
+	}
+	list_for_each_entry(i, &dma_hash[hash(&key)], list) {
+		if (key_eq(&key, &i->key) && i->guest_id =3D=3D linfo->guest_id) {
+			unsigned int j;
+			for (j =3D 0; j < i->num_dmas; j++) {
+				struct lguest_dma dma;
+
+				ret =3D i->dmas + j * sizeof(struct lguest_dma);
+				lhread(linfo, &dma, ret, sizeof(dma));
+				if (dma.used_len =3D=3D 0)
+					break;
+			}
+			*interrupt =3D i->interrupt;
+			break;
+		}
+	}
+unlock:
+	up_read(&current->mm->mmap_sem);
+	mutex_unlock(&lguest_lock);
+	return ret;
+}
+
+void lguest_io_init(void)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(dma_hash); i++)
+		INIT_LIST_HEAD(&dma_hash[i]);
+}

--
