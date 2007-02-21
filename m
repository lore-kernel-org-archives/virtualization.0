From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 23/24] Xen-paravirt_ops: Add Xen virtual block device driver.
Date: Wed, 21 Feb 2007 12:53:17 -0800
Message-ID: <20070221205324.219891003@goop.org>
References: <20070221205254.169835700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=xen-blockfront.patch
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
Cc: Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

The block device frontend driver allows the kernel to access block
devices exported exported by a virtual machine containing a physical
block device driver.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/Kconfig        |    1 =

 drivers/block/Makefile       |    1 =

 drivers/block/xen/Kconfig    |   14 =

 drivers/block/xen/Makefile   |    5 =

 drivers/block/xen/blkfront.c |  844 ++++++++++++++++++++++++++++++++++++++=
+++
 drivers/block/xen/block.h    |  135 ++++++
 drivers/block/xen/vbd.c      |  230 +++++++++++
 include/linux/major.h        |    2 =

 8 files changed, 1232 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -461,6 +461,7 @@ config CDROM_PKTCDVD_WCACHE
 	  don't do deferred write error handling yet.
 =

 source "drivers/s390/block/Kconfig"
+source "drivers/block/xen/Kconfig"
 =

 config ATA_OVER_ETH
 	tristate "ATA over Ethernet support"
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_BLK_DEV_SX8)	+=3D sx8.o
 obj-$(CONFIG_BLK_DEV_SX8)	+=3D sx8.o
 obj-$(CONFIG_BLK_DEV_UB)	+=3D ub.o
 =

+obj-$(CONFIG_XEN)		+=3D xen/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/block/xen/Kconfig
@@ -0,0 +1,14 @@
+menu "Xen block device drivers"
+        depends on XEN
+
+config XEN_BLKDEV_FRONTEND
+	tristate "Block device frontend driver"
+	depends on XEN
+	default y
+	help
+	  The block device frontend driver allows the kernel to access block
+	  devices exported from a device driver virtual machine. Unless you
+	  are building a dedicated device driver virtual machine, then you
+	  almost certainly want to say Y here.
+
+endmenu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/block/xen/Makefile
@@ -0,0 +1,5 @@
+
+obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	:=3D xenblk.o
+
+xenblk-objs :=3D blkfront.o vbd.o
+
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/block/xen/blkfront.c
@@ -0,0 +1,844 @@
+/*************************************************************************=
*****
+ * blkfront.c
+ * =

+ * XenLinux virtual block device driver.
+ * =

+ * Copyright (c) 2003-2004, Keir Fraser & Steve Hand
+ * Modifications by Mark A. Williamson are (c) Intel Research Cambridge
+ * Copyright (c) 2004, Christian Limpach
+ * Copyright (c) 2004, Andrew Warfield
+ * Copyright (c) 2005, Christopher Clark
+ * Copyright (c) 2005, XenSource Ltd
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
+#include <linux/version.h>
+#include "block.h"
+#include <linux/cdrom.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <scsi/scsi.h>
+#include <xen/xenbus.h>
+#include <xen/interface/grant_table.h>
+#include <xen/grant_table.h>
+#include <xen/events.h>
+#include <xen/page.h>
+#include <asm/xen/hypervisor.h>
+
+#define BLKIF_STATE_DISCONNECTED 0
+#define BLKIF_STATE_CONNECTED    1
+#define BLKIF_STATE_SUSPENDED    2
+
+#define MAXIMUM_OUTSTANDING_BLOCK_REQS \
+    (BLKIF_MAX_SEGMENTS_PER_REQUEST * BLK_RING_SIZE)
+#define GRANT_INVALID_REF	0
+
+static void connect(struct blkfront_info *);
+static void blkfront_closing(struct xenbus_device *);
+static int blkfront_remove(struct xenbus_device *);
+static int talk_to_backend(struct xenbus_device *, struct blkfront_info *);
+static int setup_blkring(struct xenbus_device *, struct blkfront_info *);
+
+static void kick_pending_request_queues(struct blkfront_info *);
+
+static irqreturn_t blkif_int(int irq, void *dev_id);
+static void blkif_restart_queue(struct work_struct *work);
+static void blkif_recover(struct blkfront_info *);
+static void blkif_completion(struct blk_shadow *);
+static void blkif_free(struct blkfront_info *, int);
+
+
+/**
+ * Entry point to this code when a new device is created.  Allocate the ba=
sic
+ * structures and the ring buffer for communication with the backend, and
+ * inform the backend of the appropriate details for those.  Switch to
+ * Initialised state.
+ */
+static int blkfront_probe(struct xenbus_device *dev,
+			  const struct xenbus_device_id *id)
+{
+	int err, vdevice, i;
+	struct blkfront_info *info;
+
+	/* FIXME: Use dynamic device id if this is not set. */
+	err =3D xenbus_scanf(XBT_NIL, dev->nodename,
+			   "virtual-device", "%i", &vdevice);
+	if (err !=3D 1) {
+		xenbus_dev_fatal(dev, err, "reading virtual-device");
+		return err;
+	}
+
+	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		xenbus_dev_fatal(dev, -ENOMEM, "allocating info structure");
+		return -ENOMEM;
+	}
+
+	info->xbdev =3D dev;
+	info->vdevice =3D vdevice;
+	info->connected =3D BLKIF_STATE_DISCONNECTED;
+	INIT_WORK(&info->work, blkif_restart_queue);
+
+	for (i =3D 0; i < BLK_RING_SIZE; i++)
+		info->shadow[i].req.id =3D i+1;
+	info->shadow[BLK_RING_SIZE-1].req.id =3D 0x0fffffff;
+
+	/* Front end dir is a number, which is used as the id. */
+	info->handle =3D simple_strtoul(strrchr(dev->nodename,'/')+1, NULL, 0);
+	dev->dev.driver_data =3D info;
+
+	err =3D talk_to_backend(dev, info);
+	if (err) {
+		kfree(info);
+		dev->dev.driver_data =3D NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+
+/**
+ * We are reconnecting to the backend, due to a suspend/resume, or a backe=
nd
+ * driver restart.  We tear down our blkif structure and recreate it, but
+ * leave the device-layer structures intact so that this is transparent to=
 the
+ * rest of the kernel.
+ */
+static int blkfront_resume(struct xenbus_device *dev)
+{
+	struct blkfront_info *info =3D dev->dev.driver_data;
+	int err;
+
+	dev_dbg(&dev->dev, "blkfront_resume: %s\n", dev->nodename);
+
+	blkif_free(info, info->connected =3D=3D BLKIF_STATE_CONNECTED);
+
+	err =3D talk_to_backend(dev, info);
+	if (info->connected =3D=3D BLKIF_STATE_SUSPENDED && !err)
+		blkif_recover(info);
+
+	return err;
+}
+
+
+/* Common code used when first setting up, and when resuming. */
+static int talk_to_backend(struct xenbus_device *dev,
+			   struct blkfront_info *info)
+{
+	const char *message =3D NULL;
+	struct xenbus_transaction xbt;
+	int err;
+
+	/* Create shared ring, alloc event channel. */
+	err =3D setup_blkring(dev, info);
+	if (err)
+		goto out;
+
+again:
+	err =3D xenbus_transaction_start(&xbt);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "starting transaction");
+		goto destroy_blkring;
+	}
+
+	err =3D xenbus_printf(xbt, dev->nodename,
+			    "ring-ref","%u", info->ring_ref);
+	if (err) {
+		message =3D "writing ring-ref";
+		goto abort_transaction;
+	}
+	err =3D xenbus_printf(xbt, dev->nodename,
+			    "event-channel", "%u", info->evtchn);
+	if (err) {
+		message =3D "writing event-channel";
+		goto abort_transaction;
+	}
+
+	err =3D xenbus_transaction_end(xbt, 0);
+	if (err) {
+		if (err =3D=3D -EAGAIN)
+			goto again;
+		xenbus_dev_fatal(dev, err, "completing transaction");
+		goto destroy_blkring;
+	}
+
+	xenbus_switch_state(dev, XenbusStateInitialised);
+
+	return 0;
+
+ abort_transaction:
+	xenbus_transaction_end(xbt, 1);
+	if (message)
+		xenbus_dev_fatal(dev, err, "%s", message);
+ destroy_blkring:
+	blkif_free(info, 0);
+ out:
+	return err;
+}
+
+
+static int setup_blkring(struct xenbus_device *dev,
+			 struct blkfront_info *info)
+{
+	struct blkif_sring *sring;
+	int err;
+
+	info->ring_ref =3D GRANT_INVALID_REF;
+
+	sring =3D (struct blkif_sring *)__get_free_page(GFP_KERNEL);
+	if (!sring) {
+		xenbus_dev_fatal(dev, -ENOMEM, "allocating shared ring");
+		return -ENOMEM;
+	}
+	SHARED_RING_INIT(sring);
+	FRONT_RING_INIT(&info->ring, sring, PAGE_SIZE);
+
+	err =3D xenbus_grant_ring(dev, virt_to_mfn(info->ring.sring));
+	if (err < 0) {
+		free_page((unsigned long)sring);
+		info->ring.sring =3D NULL;
+		goto fail;
+	}
+	info->ring_ref =3D err;
+
+	err =3D xenbus_alloc_evtchn(dev, &info->evtchn);
+	if (err)
+		goto fail;
+
+	err =3D bind_evtchn_to_irqhandler(
+		info->evtchn, blkif_int, SA_SAMPLE_RANDOM, "blkif", info);
+	if (err <=3D 0) {
+		xenbus_dev_fatal(dev, err,
+				 "bind_evtchn_to_irqhandler failed");
+		goto fail;
+	}
+	info->irq =3D err;
+
+	return 0;
+fail:
+	blkif_free(info, 0);
+	return err;
+}
+
+
+/**
+ * Callback received when the backend's state changes.
+ */
+static void backend_changed(struct xenbus_device *dev,
+			    enum xenbus_state backend_state)
+{
+	struct blkfront_info *info =3D dev->dev.driver_data;
+	struct block_device *bd;
+
+	dev_dbg(&dev->dev, "blkfront:backend_changed.\n");
+
+	switch (backend_state) {
+	case XenbusStateInitialising:
+	case XenbusStateInitWait:
+	case XenbusStateInitialised:
+	case XenbusStateUnknown:
+	case XenbusStateClosed:
+		break;
+
+	case XenbusStateConnected:
+		connect(info);
+		break;
+
+	case XenbusStateClosing:
+		bd =3D bdget(info->dev);
+		if (bd =3D=3D NULL)
+			xenbus_dev_fatal(dev, -ENODEV, "bdget failed");
+
+		mutex_lock(&bd->bd_mutex);
+		if (info->users > 0)
+			xenbus_dev_error(dev, -EBUSY,
+					 "Device in use; refusing to close");
+		else
+			blkfront_closing(dev);
+		mutex_unlock(&bd->bd_mutex);
+		bdput(bd);
+		break;
+	}
+}
+
+
+/* ** Connection ** */
+
+
+/*
+ * Invoked when the backend is finally 'ready' (and has told produced
+ * the details about the physical device - #sectors, size, etc).
+ */
+static void connect(struct blkfront_info *info)
+{
+	unsigned long long sectors;
+	unsigned long sector_size;
+	unsigned int binfo;
+	int err;
+
+	if ((info->connected =3D=3D BLKIF_STATE_CONNECTED) ||
+	    (info->connected =3D=3D BLKIF_STATE_SUSPENDED) )
+		return;
+
+	dev_dbg(&info->dev, "blkfront.c:connect:%s.\n", info->xbdev->otherend);
+
+	err =3D xenbus_gather(XBT_NIL, info->xbdev->otherend,
+			    "sectors", "%llu", &sectors,
+			    "info", "%u", &binfo,
+			    "sector-size", "%lu", &sector_size,
+			    NULL);
+	if (err) {
+		xenbus_dev_fatal(info->xbdev, err,
+				 "reading backend fields at %s",
+				 info->xbdev->otherend);
+		return;
+	}
+
+	err =3D xenbus_gather(XBT_NIL, info->xbdev->otherend,
+			    "feature-barrier", "%lu", &info->feature_barrier,
+			    NULL);
+	if (err)
+		info->feature_barrier =3D 0;
+
+	err =3D xlvbd_add(sectors, info->vdevice, binfo, sector_size, info);
+	if (err) {
+		xenbus_dev_fatal(info->xbdev, err, "xlvbd_add at %s",
+				 info->xbdev->otherend);
+		return;
+	}
+
+	xenbus_switch_state(info->xbdev, XenbusStateConnected);
+
+	/* Kick pending requests. */
+	spin_lock_irq(&blkif_io_lock);
+	info->connected =3D BLKIF_STATE_CONNECTED;
+	kick_pending_request_queues(info);
+	spin_unlock_irq(&blkif_io_lock);
+
+	add_disk(info->gd);
+}
+
+/**
+ * Handle the change of state of the backend to Closing.  We must delete o=
ur
+ * device-layer structures now, to ensure that writes are flushed through =
to
+ * the backend.  Once is this done, we can switch to Closed in
+ * acknowledgement.
+ */
+static void blkfront_closing(struct xenbus_device *dev)
+{
+	struct blkfront_info *info =3D dev->dev.driver_data;
+	unsigned long flags;
+
+	dev_dbg(&dev->dev, "blkfront_closing: %s removed\n", dev->nodename);
+
+	if (info->rq =3D=3D NULL)
+		goto out;
+
+	spin_lock_irqsave(&blkif_io_lock, flags);
+	/* No more blkif_request(). */
+	blk_stop_queue(info->rq);
+	/* No more gnttab callback work. */
+	gnttab_cancel_free_callback(&info->callback);
+	spin_unlock_irqrestore(&blkif_io_lock, flags);
+
+	/* Flush gnttab callback work. Must be done with no locks held. */
+	flush_scheduled_work();
+
+	xlvbd_del(info);
+
+ out:
+	xenbus_frontend_closed(dev);
+}
+
+
+static int blkfront_remove(struct xenbus_device *dev)
+{
+	struct blkfront_info *info =3D dev->dev.driver_data;
+
+	dev_dbg(&dev->dev, "blkfront_remove: %s removed\n", dev->nodename);
+
+	blkif_free(info, 0);
+
+	kfree(info);
+
+	return 0;
+}
+
+
+static inline int GET_ID_FROM_FREELIST(
+	struct blkfront_info *info)
+{
+	unsigned long free =3D info->shadow_free;
+	BUG_ON(free > BLK_RING_SIZE);
+	info->shadow_free =3D info->shadow[free].req.id;
+	info->shadow[free].req.id =3D 0x0fffffee; /* debug */
+	return free;
+}
+
+static inline void ADD_ID_TO_FREELIST(
+	struct blkfront_info *info, unsigned long id)
+{
+	info->shadow[id].req.id  =3D info->shadow_free;
+	info->shadow[id].request =3D 0;
+	info->shadow_free =3D id;
+}
+
+static inline void flush_requests(struct blkfront_info *info)
+{
+	int notify;
+
+	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(&info->ring, notify);
+
+	if (notify)
+		notify_remote_via_irq(info->irq);
+}
+
+static void kick_pending_request_queues(struct blkfront_info *info)
+{
+	if (!RING_FULL(&info->ring)) {
+		/* Re-enable calldowns. */
+		blk_start_queue(info->rq);
+		/* Kick things off immediately. */
+		do_blkif_request(info->rq);
+	}
+}
+
+static void blkif_restart_queue(struct work_struct *work)
+{
+	struct blkfront_info *info =3D container_of(work, struct blkfront_info, w=
ork);
+
+	spin_lock_irq(&blkif_io_lock);
+	if (info->connected =3D=3D BLKIF_STATE_CONNECTED)
+		kick_pending_request_queues(info);
+	spin_unlock_irq(&blkif_io_lock);
+}
+
+static void blkif_restart_queue_callback(void *arg)
+{
+	struct blkfront_info *info =3D (struct blkfront_info *)arg;
+	schedule_work(&info->work);
+}
+
+int blkif_open(struct inode *inode, struct file *filep)
+{
+	struct blkfront_info *info =3D inode->i_bdev->bd_disk->private_data;
+	info->users++;
+	return 0;
+}
+
+
+int blkif_release(struct inode *inode, struct file *filep)
+{
+	struct blkfront_info *info =3D inode->i_bdev->bd_disk->private_data;
+	info->users--;
+	if (info->users =3D=3D 0) {
+		/* Check whether we have been instructed to close.  We will
+		   have ignored this request initially, as the device was
+		   still mounted. */
+		struct xenbus_device * dev =3D info->xbdev;
+		enum xenbus_state state =3D xenbus_read_driver_state(dev->otherend);
+
+		if (state =3D=3D XenbusStateClosing)
+			blkfront_closing(dev);
+	}
+	return 0;
+}
+
+
+int blkif_getgeo(struct block_device *bd, struct hd_geometry *hg)
+{
+	/* We don't have real geometry info, but let's at least return
+	   values consistent with the size of the device */
+	sector_t nsect =3D get_capacity(bd->bd_disk);
+	sector_t cylinders =3D nsect;
+
+	hg->heads =3D 0xff;
+	hg->sectors =3D 0x3f;
+	sector_div(cylinders, hg->heads * hg->sectors);
+	hg->cylinders =3D cylinders;
+	if ((sector_t)(hg->cylinders + 1) * hg->heads * hg->sectors < nsect)
+		hg->cylinders =3D 0xffff;
+	return 0;
+}
+
+/*
+ * blkif_queue_request
+ *
+ * request block io
+ *
+ * id: for guest use only.
+ * operation: BLKIF_OP_{READ,WRITE,PROBE}
+ * buffer: buffer to read/write into. this should be a
+ *   virtual address in the guest os.
+ */
+static int blkif_queue_request(struct request *req)
+{
+	struct blkfront_info *info =3D req->rq_disk->private_data;
+	unsigned long buffer_mfn;
+	struct blkif_request *ring_req;
+	struct bio *bio;
+	struct bio_vec *bvec;
+	int idx;
+	unsigned long id;
+	unsigned int fsect, lsect;
+	int ref;
+	grant_ref_t gref_head;
+
+	if (unlikely(info->connected !=3D BLKIF_STATE_CONNECTED))
+		return 1;
+
+	if (gnttab_alloc_grant_references(
+		BLKIF_MAX_SEGMENTS_PER_REQUEST, &gref_head) < 0) {
+		gnttab_request_free_callback(
+			&info->callback,
+			blkif_restart_queue_callback,
+			info,
+			BLKIF_MAX_SEGMENTS_PER_REQUEST);
+		return 1;
+	}
+
+	/* Fill out a communications ring structure. */
+	ring_req =3D RING_GET_REQUEST(&info->ring, info->ring.req_prod_pvt);
+	id =3D GET_ID_FROM_FREELIST(info);
+	info->shadow[id].request =3D (unsigned long)req;
+
+	ring_req->id =3D id;
+	ring_req->sector_number =3D (blkif_sector_t)req->sector;
+	ring_req->handle =3D info->handle;
+
+	ring_req->operation =3D rq_data_dir(req) ?
+		BLKIF_OP_WRITE : BLKIF_OP_READ;
+	if (blk_barrier_rq(req))
+		ring_req->operation =3D BLKIF_OP_WRITE_BARRIER;
+
+	ring_req->nr_segments =3D 0;
+	rq_for_each_bio (bio, req) {
+		bio_for_each_segment (bvec, bio, idx) {
+			BUG_ON(ring_req->nr_segments
+			       =3D=3D BLKIF_MAX_SEGMENTS_PER_REQUEST);
+			buffer_mfn =3D pfn_to_mfn(page_to_pfn(bvec->bv_page));
+			fsect =3D bvec->bv_offset >> 9;
+			lsect =3D fsect + (bvec->bv_len >> 9) - 1;
+			/* install a grant reference. */
+			ref =3D gnttab_claim_grant_reference(&gref_head);
+			BUG_ON(ref =3D=3D -ENOSPC);
+
+			gnttab_grant_foreign_access_ref(
+				ref,
+				info->xbdev->otherend_id,
+				buffer_mfn,
+				rq_data_dir(req) );
+
+			info->shadow[id].frame[ring_req->nr_segments] =3D
+				mfn_to_pfn(buffer_mfn);
+
+			ring_req->seg[ring_req->nr_segments] =3D
+				(struct blkif_request_segment) {
+					.gref       =3D ref,
+					.first_sect =3D fsect,
+					.last_sect  =3D lsect };
+
+			ring_req->nr_segments++;
+		}
+	}
+
+	info->ring.req_prod_pvt++;
+
+	/* Keep a private copy so we can reissue requests when recovering. */
+	info->shadow[id].req =3D *ring_req;
+
+	gnttab_free_grant_references(gref_head);
+
+	return 0;
+}
+
+/*
+ * do_blkif_request
+ *  read a block; request is in a request queue
+ */
+void do_blkif_request(request_queue_t *rq)
+{
+	struct blkfront_info *info =3D NULL;
+	struct request *req;
+	int queued;
+
+	pr_debug("Entered do_blkif_request\n");
+
+	queued =3D 0;
+
+	while ((req =3D elv_next_request(rq)) !=3D NULL) {
+		info =3D req->rq_disk->private_data;
+		if (!blk_fs_request(req)) {
+			end_request(req, 0);
+			continue;
+		}
+
+		if (RING_FULL(&info->ring))
+			goto wait;
+
+		pr_debug("do_blk_req %p: cmd %p, sec %lx, "
+			 "(%u/%li) buffer:%p [%s]\n",
+			 req, req->cmd, (unsigned long)req->sector,
+			 req->current_nr_sectors,
+			 req->nr_sectors, req->buffer,
+			 rq_data_dir(req) ? "write" : "read");
+
+
+		blkdev_dequeue_request(req);
+		if (blkif_queue_request(req)) {
+			blk_requeue_request(rq, req);
+		wait:
+			/* Avoid pointless unplugs. */
+			blk_stop_queue(rq);
+			break;
+		}
+
+		queued++;
+	}
+
+	if (queued !=3D 0)
+		flush_requests(info);
+}
+
+
+static irqreturn_t blkif_int(int irq, void *dev_id)
+{
+	struct request *req;
+	struct blkif_response *bret;
+	RING_IDX i, rp;
+	unsigned long flags;
+	struct blkfront_info *info =3D (struct blkfront_info *)dev_id;
+	int uptodate;
+
+	spin_lock_irqsave(&blkif_io_lock, flags);
+
+	if (unlikely(info->connected !=3D BLKIF_STATE_CONNECTED)) {
+		spin_unlock_irqrestore(&blkif_io_lock, flags);
+		return IRQ_HANDLED;
+	}
+
+ again:
+	rp =3D info->ring.sring->rsp_prod;
+	rmb(); /* Ensure we see queued responses up to 'rp'. */
+
+	for (i =3D info->ring.rsp_cons; i !=3D rp; i++) {
+		unsigned long id;
+		int ret;
+
+		bret =3D RING_GET_RESPONSE(&info->ring, i);
+		id   =3D bret->id;
+		req  =3D (struct request *)info->shadow[id].request;
+
+		blkif_completion(&info->shadow[id]);
+
+		ADD_ID_TO_FREELIST(info, id);
+
+		uptodate =3D (bret->status =3D=3D BLKIF_RSP_OKAY);
+		switch (bret->operation) {
+		case BLKIF_OP_WRITE_BARRIER:
+			if (unlikely(bret->status =3D=3D BLKIF_RSP_EOPNOTSUPP)) {
+				printk("blkfront: %s: write barrier op failed\n",
+				       info->gd->disk_name);
+				uptodate =3D -EOPNOTSUPP;
+				info->feature_barrier =3D 0;
+			        xlvbd_barrier(info);
+			}
+			/* fall through */
+		case BLKIF_OP_READ:
+		case BLKIF_OP_WRITE:
+			if (unlikely(bret->status !=3D BLKIF_RSP_OKAY))
+				dev_dbg(&info->dev, "Bad return from blkdev data "
+					"request: %x\n", bret->status);
+
+			ret =3D end_that_request_first(req, uptodate,
+				req->hard_nr_sectors);
+			BUG_ON(ret);
+			end_that_request_last(req, uptodate);
+			break;
+		default:
+			BUG();
+		}
+	}
+
+	info->ring.rsp_cons =3D i;
+
+	if (i !=3D info->ring.req_prod_pvt) {
+		int more_to_do;
+		RING_FINAL_CHECK_FOR_RESPONSES(&info->ring, more_to_do);
+		if (more_to_do)
+			goto again;
+	} else
+		info->ring.sring->rsp_event =3D i + 1;
+
+	kick_pending_request_queues(info);
+
+	spin_unlock_irqrestore(&blkif_io_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void blkif_free(struct blkfront_info *info, int suspend)
+{
+	/* Prevent new requests being issued until we fix things up. */
+	spin_lock_irq(&blkif_io_lock);
+	info->connected =3D suspend ?
+		BLKIF_STATE_SUSPENDED : BLKIF_STATE_DISCONNECTED;
+	/* No more blkif_request(). */
+	if (info->rq)
+		blk_stop_queue(info->rq);
+	/* No more gnttab callback work. */
+	gnttab_cancel_free_callback(&info->callback);
+	spin_unlock_irq(&blkif_io_lock);
+
+	/* Flush gnttab callback work. Must be done with no locks held. */
+	flush_scheduled_work();
+
+	/* Free resources associated with old device channel. */
+	if (info->ring_ref !=3D GRANT_INVALID_REF) {
+		gnttab_end_foreign_access(info->ring_ref, 0,
+					  (unsigned long)info->ring.sring);
+		info->ring_ref =3D GRANT_INVALID_REF;
+		info->ring.sring =3D NULL;
+	}
+	if (info->irq)
+		unbind_from_irqhandler(info->irq, info);
+	info->evtchn =3D info->irq =3D 0;
+
+}
+
+static void blkif_completion(struct blk_shadow *s)
+{
+	int i;
+	for (i =3D 0; i < s->req.nr_segments; i++)
+		gnttab_end_foreign_access(s->req.seg[i].gref, 0, 0UL);
+}
+
+static void blkif_recover(struct blkfront_info *info)
+{
+	int i;
+	struct blkif_request *req;
+	struct blk_shadow *copy;
+	int j;
+
+	/* Stage 1: Make a safe copy of the shadow state. */
+	copy =3D kmalloc(sizeof(info->shadow), GFP_KERNEL | __GFP_NOFAIL);
+	memcpy(copy, info->shadow, sizeof(info->shadow));
+
+	/* Stage 2: Set up free list. */
+	memset(&info->shadow, 0, sizeof(info->shadow));
+	for (i =3D 0; i < BLK_RING_SIZE; i++)
+		info->shadow[i].req.id =3D i+1;
+	info->shadow_free =3D info->ring.req_prod_pvt;
+	info->shadow[BLK_RING_SIZE-1].req.id =3D 0x0fffffff;
+
+	/* Stage 3: Find pending requests and requeue them. */
+	for (i =3D 0; i < BLK_RING_SIZE; i++) {
+		/* Not in use? */
+		if (copy[i].request =3D=3D 0)
+			continue;
+
+		/* Grab a request slot and copy shadow state into it. */
+		req =3D RING_GET_REQUEST(
+			&info->ring, info->ring.req_prod_pvt);
+		*req =3D copy[i].req;
+
+		/* We get a new request id, and must reset the shadow state. */
+		req->id =3D GET_ID_FROM_FREELIST(info);
+		memcpy(&info->shadow[req->id], &copy[i], sizeof(copy[i]));
+
+		/* Rewrite any grant references invalidated by susp/resume. */
+		for (j =3D 0; j < req->nr_segments; j++)
+			gnttab_grant_foreign_access_ref(
+				req->seg[j].gref,
+				info->xbdev->otherend_id,
+				pfn_to_mfn(info->shadow[req->id].frame[j]),
+				rq_data_dir(
+					(struct request *)
+					info->shadow[req->id].request));
+		info->shadow[req->id].req =3D *req;
+
+		info->ring.req_prod_pvt++;
+	}
+
+	kfree(copy);
+
+	xenbus_switch_state(info->xbdev, XenbusStateConnected);
+
+	spin_lock_irq(&blkif_io_lock);
+
+	/* Now safe for us to use the shared ring */
+	info->connected =3D BLKIF_STATE_CONNECTED;
+
+	/* Send off requeued requests */
+	flush_requests(info);
+
+	/* Kick any other new requests queued since we resumed */
+	kick_pending_request_queues(info);
+
+	spin_unlock_irq(&blkif_io_lock);
+}
+
+
+/* ** Driver Registration ** */
+
+
+static struct xenbus_device_id blkfront_ids[] =3D {
+	{ "vbd" },
+	{ "" }
+};
+
+
+static struct xenbus_driver blkfront =3D {
+	.name =3D "vbd",
+	.owner =3D THIS_MODULE,
+	.ids =3D blkfront_ids,
+	.probe =3D blkfront_probe,
+	.remove =3D blkfront_remove,
+	.resume =3D blkfront_resume,
+	.otherend_changed =3D backend_changed,
+};
+
+
+static int __init xlblk_init(void)
+{
+	if (!is_running_on_xen())
+		return -ENODEV;
+
+	if (xlvbd_alloc_major() < 0)
+		return -ENODEV;
+
+	return xenbus_register_frontend(&blkfront);
+}
+module_init(xlblk_init);
+
+
+static void xlblk_exit(void)
+{
+	return xenbus_unregister_driver(&blkfront);
+}
+module_exit(xlblk_exit);
+
+MODULE_LICENSE("Dual BSD/GPL");
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/block/xen/block.h
@@ -0,0 +1,135 @@
+/*************************************************************************=
*****
+ * block.h
+ * =

+ * Shared definitions between all levels of XenLinux Virtual block devices.
+ * =

+ * Copyright (c) 2003-2004, Keir Fraser & Steve Hand
+ * Modifications by Mark A. Williamson are (c) Intel Research Cambridge
+ * Copyright (c) 2004-2005, Christian Limpach
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
+#ifndef __XEN_DRIVERS_BLOCK_H__
+#define __XEN_DRIVERS_BLOCK_H__
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/major.h>
+#include <asm/xen/hypervisor.h>
+#include <xen/xenbus.h>
+#include <xen/grant_table.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/io/blkif.h>
+#include <xen/interface/io/ring.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+struct xlbd_type_info
+{
+	int partn_shift;
+	int disks_per_major;
+	char *devname;
+	char *diskname;
+};
+
+struct xlbd_major_info
+{
+	int major;
+	int index;
+	int usage;
+	struct xlbd_type_info *type;
+};
+
+struct blk_shadow {
+	struct blkif_request req;
+	unsigned long request;
+	unsigned long frame[BLKIF_MAX_SEGMENTS_PER_REQUEST];
+};
+
+#define BLK_RING_SIZE __RING_SIZE((struct blkif_sring *)0, PAGE_SIZE)
+
+/*
+ * We have one of these per vbd, whether ide, scsi or 'other'.  They
+ * hang in private_data off the gendisk structure. We may end up
+ * putting all kinds of interesting stuff here :-)
+ */
+struct blkfront_info
+{
+	struct xenbus_device *xbdev;
+	dev_t dev;
+ 	struct gendisk *gd;
+	int vdevice;
+	blkif_vdev_t handle;
+	int connected;
+	int ring_ref;
+	struct blkif_front_ring ring;
+	unsigned int evtchn, irq;
+	struct xlbd_major_info *mi;
+	request_queue_t *rq;
+	struct work_struct work;
+	struct gnttab_free_callback callback;
+	struct blk_shadow shadow[BLK_RING_SIZE];
+	unsigned long shadow_free;
+	int feature_barrier;
+
+	/**
+	 * The number of people holding this device open.  We won't allow a
+	 * hot-unplug unless this is 0.
+	 */
+	int users;
+};
+
+extern spinlock_t blkif_io_lock;
+
+extern int blkif_open(struct inode *inode, struct file *filep);
+extern int blkif_release(struct inode *inode, struct file *filep);
+extern int blkif_ioctl(struct inode *inode, struct file *filep,
+		       unsigned command, unsigned long argument);
+extern int blkif_getgeo(struct block_device *, struct hd_geometry *);
+extern int blkif_check(dev_t dev);
+extern int blkif_revalidate(dev_t dev);
+extern void do_blkif_request (request_queue_t *rq);
+
+/* Virtual block device subsystem. */
+int xlvbd_alloc_major(void);
+/* Note that xlvbd_add doesn't call add_disk for you: you're expected
+   to call add_disk on info->gd once the disk is properly connected
+   up. */
+int xlvbd_add(blkif_sector_t capacity, int device,
+	      u16 vdisk_info, u16 sector_size, struct blkfront_info *info);
+void xlvbd_del(struct blkfront_info *info);
+int xlvbd_barrier(struct blkfront_info *info);
+
+#endif /* __XEN_DRIVERS_BLOCK_H__ */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/block/xen/vbd.c
@@ -0,0 +1,230 @@
+/*************************************************************************=
*****
+ * vbd.c
+ * =

+ * XenLinux virtual block device driver (xvd).
+ * =

+ * Copyright (c) 2003-2004, Keir Fraser & Steve Hand
+ * Modifications by Mark A. Williamson are (c) Intel Research Cambridge
+ * Copyright (c) 2004-2005, Christian Limpach
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
+#include "block.h"
+#include <linux/blkdev.h>
+#include <linux/list.h>
+
+#define BLKIF_MAJOR(dev) ((dev)>>8)
+#define BLKIF_MINOR(dev) ((dev) & 0xff)
+
+static struct xlbd_type_info xvd_type_info =3D {
+	.partn_shift =3D 4,
+	.disks_per_major =3D 16,
+	.devname =3D "xvd",
+	.diskname =3D "xvd"
+};
+
+static struct xlbd_major_info xvd_major_info =3D {
+	.major =3D XENVBD_MAJOR,
+	.type =3D &xvd_type_info
+};
+
+/* Information about our VBDs. */
+#define MAX_VBDS 64
+static LIST_HEAD(vbds_list);
+
+static struct block_device_operations xlvbd_block_fops =3D
+{
+	.owner =3D THIS_MODULE,
+	.open =3D blkif_open,
+	.release =3D blkif_release,
+	.getgeo =3D blkif_getgeo
+};
+
+DEFINE_SPINLOCK(blkif_io_lock);
+
+int
+xlvbd_alloc_major(void)
+{
+	printk("Registering block device major %i\n", xvd_major_info.major);
+	if (register_blkdev(xvd_major_info.major,
+			    xvd_major_info.type->devname)) {
+		printk(KERN_WARNING "xen_blk: can't get major %d with name %s\n",
+		       xvd_major_info.major, xvd_major_info.type->devname);
+		return -1;
+	}
+	return 0;
+}
+
+static int
+xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size)
+{
+	request_queue_t *rq;
+
+	rq =3D blk_init_queue(do_blkif_request, &blkif_io_lock);
+	if (rq =3D=3D NULL)
+		return -1;
+
+	elevator_init(rq, "noop");
+
+	/* Hard sector size and max sectors impersonate the equiv. hardware. */
+	blk_queue_hardsect_size(rq, sector_size);
+	blk_queue_max_sectors(rq, 512);
+
+	/* Each segment in a request is up to an aligned page in size. */
+	blk_queue_segment_boundary(rq, PAGE_SIZE - 1);
+	blk_queue_max_segment_size(rq, PAGE_SIZE);
+
+	/* Ensure a merged request will fit in a single I/O ring slot. */
+	blk_queue_max_phys_segments(rq, BLKIF_MAX_SEGMENTS_PER_REQUEST);
+	blk_queue_max_hw_segments(rq, BLKIF_MAX_SEGMENTS_PER_REQUEST);
+
+	/* Make sure buffer addresses are sector-aligned. */
+	blk_queue_dma_alignment(rq, 511);
+
+	gd->queue =3D rq;
+
+	return 0;
+}
+
+static int
+xlvbd_alloc_gendisk(int minor, blkif_sector_t capacity, int vdevice,
+		    u16 vdisk_info, u16 sector_size,
+		    struct blkfront_info *info)
+{
+	struct gendisk *gd;
+	struct xlbd_major_info *mi;
+	int nr_minors =3D 1;
+	int err =3D -ENODEV;
+
+	BUG_ON(info->gd !=3D NULL);
+	BUG_ON(info->mi !=3D NULL);
+	BUG_ON(info->rq !=3D NULL);
+
+	mi =3D &xvd_major_info;
+	info->mi =3D mi;
+
+	if ((minor & ((1 << mi->type->partn_shift) - 1)) =3D=3D 0)
+		nr_minors =3D 1 << mi->type->partn_shift;
+
+	gd =3D alloc_disk(nr_minors);
+	if (gd =3D=3D NULL)
+		goto out;
+
+	if (nr_minors > 1)
+		sprintf(gd->disk_name, "%s%c", mi->type->diskname,
+			'a' + mi->index * mi->type->disks_per_major +
+			(minor >> mi->type->partn_shift));
+	else
+		sprintf(gd->disk_name, "%s%c%d", mi->type->diskname,
+			'a' + mi->index * mi->type->disks_per_major +
+			(minor >> mi->type->partn_shift),
+			minor & ((1 << mi->type->partn_shift) - 1));
+
+	gd->major =3D mi->major;
+	gd->first_minor =3D minor;
+	gd->fops =3D &xlvbd_block_fops;
+	gd->private_data =3D info;
+	gd->driverfs_dev =3D &(info->xbdev->dev);
+	set_capacity(gd, capacity);
+
+	if (xlvbd_init_blk_queue(gd, sector_size)) {
+		del_gendisk(gd);
+		goto out;
+	}
+
+	info->rq =3D gd->queue;
+	info->gd =3D gd;
+
+	if (info->feature_barrier)
+		xlvbd_barrier(info);
+
+	if (vdisk_info & VDISK_READONLY)
+		set_disk_ro(gd, 1);
+
+	if (vdisk_info & VDISK_REMOVABLE)
+		gd->flags |=3D GENHD_FL_REMOVABLE;
+
+	if (vdisk_info & VDISK_CDROM)
+		gd->flags |=3D GENHD_FL_CD;
+
+	return 0;
+
+ out:
+	info->mi =3D NULL;
+	return err;
+}
+
+int
+xlvbd_add(blkif_sector_t capacity, int vdevice, u16 vdisk_info,
+	  u16 sector_size, struct blkfront_info *info)
+{
+	struct block_device *bd;
+	int err =3D 0;
+
+	info->dev =3D MKDEV(BLKIF_MAJOR(vdevice), BLKIF_MINOR(vdevice));
+
+	bd =3D bdget(info->dev);
+	if (bd =3D=3D NULL)
+		return -ENODEV;
+
+	err =3D xlvbd_alloc_gendisk(BLKIF_MINOR(vdevice), capacity, vdevice,
+				  vdisk_info, sector_size, info);
+
+	bdput(bd);
+	return err;
+}
+
+void
+xlvbd_del(struct blkfront_info *info)
+{
+	if (info->mi =3D=3D NULL)
+		return;
+
+	BUG_ON(info->gd =3D=3D NULL);
+	del_gendisk(info->gd);
+	put_disk(info->gd);
+	info->gd =3D NULL;
+
+	info->mi =3D NULL;
+
+	BUG_ON(info->rq =3D=3D NULL);
+	blk_cleanup_queue(info->rq);
+	info->rq =3D NULL;
+}
+
+int
+xlvbd_barrier(struct blkfront_info *info)
+{
+	int err;
+
+	err =3D blk_queue_ordered(info->rq,
+		info->feature_barrier ? QUEUE_ORDERED_DRAIN : QUEUE_ORDERED_NONE, NULL);
+	if (err)
+		return err;
+	printk("blkfront: %s: barriers %s\n",
+	       info->gd->disk_name, info->feature_barrier ? "enabled" : "disabled=
");
+	return 0;
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/major.h
+++ b/include/linux/major.h
@@ -156,6 +156,8 @@
 #define VXSPEC_MAJOR		200	/* VERITAS volume config driver */
 #define VXDMP_MAJOR		201	/* VERITAS volume multipath driver */
 =

+#define XENVBD_MAJOR		202	/* Xen virtual block device */
+
 #define MSR_MAJOR		202
 #define CPUID_MAJOR		203
 =


-- =
