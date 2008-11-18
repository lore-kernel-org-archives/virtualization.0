From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] virtio_console: support console resizing
Date: Tue, 18 Nov 2008 12:47:04 +0100
Message-ID: <200811181247.04906.borntraeger__20696.3999932215$1227008974$gmane$org@de.ibm.com>
References: <200811181245.03931.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200811181245.03931.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest@ozlabs.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



From: Christian Borntraeger <borntraeger@de.ibm.com>

this patch uses the new hvc callback hvc_resize to set the window site 
which allows to change the tty size of hvc_console via a hvc_resize 
function.

I have added a new feature bit VIRTIO_CONSOLE_F_SIZE. The driver will 
change the window size on tty open and via the config_changed callback
of the transport. Currently lguest and kvm_s390 have not implemented this
callback, but the callback can be implemented at a later point in time.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/char/virtio_console.c  |   30 +++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |   11 +++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

Index: kvm/drivers/char/virtio_console.c
===================================================================
--- kvm.orig/drivers/char/virtio_console.c
+++ kvm/drivers/char/virtio_console.c
@@ -138,12 +138,33 @@ int __init virtio_cons_early_init(int (*
 }
 
 /*
+ * virtio console configuration. This supports:
+ * - console resize
+ */
+static void virtcons_apply_config(struct virtio_device *dev)
+{
+	struct winsize ws;
+
+	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
+		dev->config->get(dev,
+				 offsetof(struct virtio_console_config, cols),
+				 &ws.ws_col, sizeof(u16));
+		dev->config->get(dev,
+				 offsetof(struct virtio_console_config, rows),
+				 &ws.ws_row, sizeof(u16));
+		hvc_resize(hvc, ws);
+	}
+}
+
+/*
  * we support only one console, the hvc struct is a global var
- * There is no need to do anything
+ * We set the configuration at this point, since we now have a tty
  */
 static int notifier_add_vio(struct hvc_struct *hp, int data)
 {
 	hp->irq_requested = 1;
+	virtcons_apply_config(vdev);
+
 	return 0;
 }
 
@@ -234,11 +255,18 @@ static struct virtio_device_id id_table[
 	{ 0 },
 };
 
+static unsigned int features[] = {
+	VIRTIO_CONSOLE_F_SIZE,
+};
+
 static struct virtio_driver virtio_console = {
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
+	.config_changed = virtcons_apply_config,
 };
 
 static int __init init(void)
Index: kvm/include/linux/virtio_console.h
===================================================================
--- kvm.orig/include/linux/virtio_console.h
+++ kvm/include/linux/virtio_console.h
@@ -7,6 +7,17 @@
 /* The ID for virtio console */
 #define VIRTIO_ID_CONSOLE	3
 
+/* Feature bits */
+#define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
+
+struct virtio_console_config {
+	/* colums of the screens */
+	__u16 cols;
+	/* rows of the screens */
+	__u16 rows;
+} __attribute__((packed));
+
+
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
 #endif /* __KERNEL__ */
