From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 01/11] Revert "virtio: disable multiport console support."
Date: Thu,  8 Apr 2010 20:19:30 +0530
Message-ID: <1270738180-21170-2-git-send-email-amit.shah@redhat.com>
References: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit b7a413015d2986edf020fba765c906cc9cbcbfc9.

Multiport support was disabled for 2.6.34 because we wanted to introduce
a new ABI and since we didn't have any released kernel with the older
ABI and were out of the merge window, it didn't make sense keeping the
older ABI around.

Now we revert the patch disabling multiport and rework the ABI in the
following patches.
---
 drivers/char/virtio_console.c  |   49 ++++++---------------------------------
 include/linux/virtio_console.h |   23 ++++++++++++++++++
 2 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 196428c..86e9011 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -33,35 +33,6 @@
 #include <linux/workqueue.h>
 #include "hvc_console.h"
 
-/* Moved here from .h file in order to disable MULTIPORT. */
-#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
-
-struct virtio_console_multiport_conf {
-	struct virtio_console_config config;
-	/* max. number of ports this device can hold */
-	__u32 max_nr_ports;
-	/* number of ports added so far */
-	__u32 nr_ports;
-} __attribute__((packed));
-
-/*
- * A message that's passed between the Host and the Guest for a
- * particular port.
- */
-struct virtio_console_control {
-	__u32 id;		/* Port number */
-	__u16 event;		/* The kind of control event (see below) */
-	__u16 value;		/* Extra information for the key */
-};
-
-/* Some events for control messages */
-#define VIRTIO_CONSOLE_PORT_READY	0
-#define VIRTIO_CONSOLE_CONSOLE_PORT	1
-#define VIRTIO_CONSOLE_RESIZE		2
-#define VIRTIO_CONSOLE_PORT_OPEN	3
-#define VIRTIO_CONSOLE_PORT_NAME	4
-#define VIRTIO_CONSOLE_PORT_REMOVE	5
-
 /*
  * This is a global struct for storing common data for all the devices
  * this driver handles.
@@ -150,7 +121,7 @@ struct ports_device {
 	spinlock_t cvq_lock;
 
 	/* The current config space is stored here */
-	struct virtio_console_multiport_conf config;
+	struct virtio_console_config config;
 
 	/* The virtio device we're associated with */
 	struct virtio_device *vdev;
@@ -1243,7 +1214,7 @@ fail:
  */
 static void config_work_handler(struct work_struct *work)
 {
-	struct virtio_console_multiport_conf virtconconf;
+	struct virtio_console_config virtconconf;
 	struct ports_device *portdev;
 	struct virtio_device *vdev;
 	int err;
@@ -1252,8 +1223,7 @@ static void config_work_handler(struct work_struct *work)
 
 	vdev = portdev->vdev;
 	vdev->config->get(vdev,
-			  offsetof(struct virtio_console_multiport_conf,
-				   nr_ports),
+			  offsetof(struct virtio_console_config, nr_ports),
 			  &virtconconf.nr_ports,
 			  sizeof(virtconconf.nr_ports));
 
@@ -1445,19 +1415,16 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	multiport = false;
 	portdev->config.nr_ports = 1;
 	portdev->config.max_nr_ports = 1;
-#if 0 /* Multiport is not quite ready yet --RR */
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
 		multiport = true;
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
 
-		vdev->config->get(vdev,
-				  offsetof(struct virtio_console_multiport_conf,
-					   nr_ports),
+		vdev->config->get(vdev, offsetof(struct virtio_console_config,
+						 nr_ports),
 				  &portdev->config.nr_ports,
 				  sizeof(portdev->config.nr_ports));
-		vdev->config->get(vdev,
-				  offsetof(struct virtio_console_multiport_conf,
-					   max_nr_ports),
+		vdev->config->get(vdev, offsetof(struct virtio_console_config,
+						 max_nr_ports),
 				  &portdev->config.max_nr_ports,
 				  sizeof(portdev->config.max_nr_ports));
 		if (portdev->config.nr_ports > portdev->config.max_nr_ports) {
@@ -1473,7 +1440,6 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 	/* Let the Host know we support multiple ports.*/
 	vdev->config->finalize_features(vdev);
-#endif
 
 	err = init_vqs(portdev);
 	if (err < 0) {
@@ -1556,6 +1522,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
+	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
 static struct virtio_driver virtio_console = {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 92228a8..ae4f039 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -12,14 +12,37 @@
 
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
+#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 
 struct virtio_console_config {
 	/* colums of the screens */
 	__u16 cols;
 	/* rows of the screens */
 	__u16 rows;
+	/* max. number of ports this device can hold */
+	__u32 max_nr_ports;
+	/* number of ports added so far */
+	__u32 nr_ports;
 } __attribute__((packed));
 
+/*
+ * A message that's passed between the Host and the Guest for a
+ * particular port.
+ */
+struct virtio_console_control {
+	__u32 id;		/* Port number */
+	__u16 event;		/* The kind of control event (see below) */
+	__u16 value;		/* Extra information for the key */
+};
+
+/* Some events for control messages */
+#define VIRTIO_CONSOLE_PORT_READY	0
+#define VIRTIO_CONSOLE_CONSOLE_PORT	1
+#define VIRTIO_CONSOLE_RESIZE		2
+#define VIRTIO_CONSOLE_PORT_OPEN	3
+#define VIRTIO_CONSOLE_PORT_NAME	4
+#define VIRTIO_CONSOLE_PORT_REMOVE	5
+
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
 #endif /* __KERNEL__ */
-- 
1.6.2.5
