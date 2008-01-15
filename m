From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [PATCH] KVM virtio balloon driver
Date: Tue, 15 Jan 2008 12:22:01 -0200
Message-ID: <20080115142201.GA26055@dmt>
References: <20080114200357.GA18354@dmt> <478BD449.4060407@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <478BD449.4060407@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 14, 2008 at 03:29:45PM -0600, Anthony Liguori wrote:
> Marcelo Tosatti wrote:
> >Hi Rusty,
> >
> >It was agreed that the balloon driver should be merged through the
> >virtio tree, so here it goes. It depends on the config_changed patch
> >posted earlier.
> >
> >
> >-----
> >
> >Following patch adds the KVM balloon driver.
> >
> >Changes from last version:
> >- Get rid of global variables/structure
> >- Use page->lru to link ballooned pages
> >- Use dev_dbg/dev_printk
> >- Proper kthread_should_stop handling
> >- Move shared definitions to separate header
> >- Use ->config_changed method for notification
> >
> >This depends on Rusty's config_changed patch.
> >
> >Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> >
> >
> >Index: linux-2.6-nv/drivers/virtio/Kconfig
> >===================================================================
> >--- linux-2.6-nv.orig/drivers/virtio/Kconfig
> >+++ linux-2.6-nv/drivers/virtio/Kconfig
> >@@ -23,3 +23,12 @@ config VIRTIO_PCI
> > 
> > 	  If unsure, say M.
> > 
> >+config KVM_BALLOON
> >+	tristate "KVM balloon driver (EXPERIMENTAL)"
> >+	depends on VIRTIO_PCI
> >+	---help---
> >+	 This driver provides support for ballooning memory in/out of a
> >+	 KVM paravirt guest.	
> >+
> >+	 If unsure, say M.
> >+
> 
> 
> Please rename from KVM_BALLOON to VIRTIO_BALLOON.  Also, it doesn't 
> depend on VIRTIO_PCI.  It should select VIRTIO and VIRTIO_RING.
> 
> 
> 
> >Index: linux-2.6-nv/drivers/virtio/Makefile
> >===================================================================
> >--- linux-2.6-nv.orig/drivers/virtio/Makefile
> >+++ linux-2.6-nv/drivers/virtio/Makefile
> >@@ -1,3 +1,4 @@
> > obj-$(CONFIG_VIRTIO) += virtio.o
> > obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
> > obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> >+obj-$(CONFIG_KVM_BALLOON) += kvm_balloon.o
> >Index: linux-2.6-nv/drivers/virtio/kvm_balloon.c
> >===================================================================
> >--- /dev/null
> >+++ linux-2.6-nv/drivers/virtio/kvm_balloon.c
> >@@ -0,0 +1,537 @@
> >+/*
> >+ * KVM guest balloon driver
> >+ *
> >+ * Copyright (C) 2007, Qumranet, Inc., Dor Laor <dor.laor@qumranet.com>
> >+ * Copyright (C) 2007, Red Hat, Inc., Marcelo Tosatti 
> ><mtosatti@redhat.com>
> >+ * 
> >+ * This work is licensed under the terms of the GNU GPL, version 2.  See
> >+ * the COPYING file in the top-level directory.
> >+ */
> >+
> >+#define DEBUG
> >+#include <asm/uaccess.h>
> >+#include <linux/kernel.h>
> >+#include <linux/module.h>
> >+#include <linux/percpu.h>
> >+#include <linux/init.h>
> >+#include <linux/interrupt.h>
> >+#include <linux/mm.h>
> >+#include <linux/swap.h>
> >+#include <linux/wait.h>
> >+#include <linux/kthread.h>
> >+#include <linux/freezer.h>
> >+#include <linux/version.h>
> >+#include <linux/virtio.h>
> >+#include <linux/virtio_config.h>
> >+#include <linux/virtio_balloon.h>
> >+#include <linux/preempt.h>
> >+#include <linux/kvm_types.h>
> >+#include <linux/kvm_host.h>
> 
> Please don't include kvm_types or kvm_host.
> 
> >+
> >+MODULE_AUTHOR ("Dor Laor");
> >+MODULE_DESCRIPTION ("Implements guest ballooning support");
> >+MODULE_LICENSE("GPL");
> >+MODULE_VERSION("1");
> >+
> >+static int kvm_balloon_debug;
> >+
> >+#define dprintk(dev, str...) if (kvm_balloon_debug) dev_dbg(dev, str)
> 
> This can go away.

I think this is useful for debugging problems on field.

Fixed the previous comments, thanks.
