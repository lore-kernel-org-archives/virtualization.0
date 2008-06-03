From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [RFC 2/3] virtio_console: use virtqueue notification for hvc_console
Date: Tue, 3 Jun 2008 14:46:15 +0200
Message-ID: <200806031446.15330.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756747AbYFCMqz@vger.kernel.org>
In-Reply-To: <200806031444.21945.borntraeger@de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PPC devel <linuxppc-dev@ozlabs.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This patch exploits the new notifier callbacks of the hvc_console. We can
use the virtio callbacks instead of the polling code. 

I also added a small Kconfig change that allows the user to specify the 
virtio console in menuconfig. 


Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/char/Kconfig          |    6 +++++-
 drivers/char/virtio_console.c |   27 +++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

Index: kvm/drivers/char/Kconfig
===================================================================
--- kvm.orig/drivers/char/Kconfig
+++ kvm/drivers/char/Kconfig
@@ -637,8 +637,12 @@ config HVC_XEN
 	  Xen virtual console device driver
 
 config VIRTIO_CONSOLE
-	bool
+	bool "Virtio console"
+	depends on VIRTIO
 	select HVC_DRIVER
+	help
+	  Virtio console for use with lguest and other hypervisors.
+
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
Index: kvm/drivers/char/virtio_console.c
===================================================================
--- kvm.orig/drivers/char/virtio_console.c
+++ kvm/drivers/char/virtio_console.c
@@ -46,6 +46,9 @@ static char *in, *inbuf;
 /* The operations for our console. */
 static struct hv_ops virtio_cons;
 
+/* The hvc device */
+struct hvc_struct *hvc;
+
 /*D:310 The put_chars() callback is pretty straightforward.
  *
  * We turn the characters into a scatter-gather list, add it to the output
@@ -134,6 +137,25 @@ int __init virtio_cons_early_init(int (*
 	return hvc_instantiate(0, 0, &virtio_cons);
 }
 
+/*
+ * we support only one console, the hvc struct is a global var
+ * There is no need to do anything
+ */
+static int notifier_add_vio(struct hvc_struct *hp, int data)
+{
+	return 0;
+}
+
+static void notifier_del_vio(struct hvc_struct *hp, int data)
+{
+}
+
+static void hvc_handle_input(struct virtqueue *vq)
+{
+	if (hvc_poll(hvc))
+		hvc_kick();
+}
+
 /*D:370 Once we're further in boot, we get probed like any other virtio 
device.
  * At this stage we set up the output virtqueue.
  *
@@ -144,7 +166,6 @@ int __init virtio_cons_early_init(int (*
 static int __devinit virtcons_probe(struct virtio_device *dev)
 {
 	int err;
-	struct hvc_struct *hvc;
 
 	vdev = dev;
 
@@ -158,7 +179,7 @@ static int __devinit virtcons_probe(stru
 	/* Find the input queue. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
-	in_vq = vdev->config->find_vq(vdev, 0, NULL);
+	in_vq = vdev->config->find_vq(vdev, 0, hvc_handle_input);
 	if (IS_ERR(in_vq)) {
 		err = PTR_ERR(in_vq);
 		goto free;
@@ -173,6 +194,8 @@ static int __devinit virtcons_probe(stru
 	/* Start using the new console output. */
 	virtio_cons.get_chars = get_chars;
 	virtio_cons.put_chars = put_chars;
+	virtio_cons.notifier_add = notifier_add_vio;
+	virtio_cons.notifier_del = notifier_del_vio;
 
 	/* The first argument of hvc_alloc() is the virtual console number, so
 	 * we use zero.  The second argument is the interrupt number; we
