From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/4] virtio: disable multiport console support.
Date: Wed, 31 Mar 2010 21:56:42 +0300
Message-ID: <20100331185642.GB5241@redhat.com>
References: <201003301549.43186.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003301549.43186.rusty@rustcorp.com.au>
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
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Here's a much smaller patch that also removes multiport
from user visible headers completely.
What do you think? Compile-tested only.

->8

Move MULTIPORT feature and related config changes
out of exported headers, and disable the feature
at runtime.

At this point, it seems less risky to keep code around
until we can enable it than rip it out completely.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

 drivers/char/virtio_console.c  |   47 ++++++++++++++++++++++++++++++++++-------
 include/linux/virtio_console.h |   23 --------------------
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 44288ce..2a360de 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -32,6 +32,35 @@
 #include <linux/workqueue.h>
 #include "hvc_console.h"
 
+/* Moved here from .h file in order to disable MULTIPORT. */
+#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
+ 
+struct virtio_console_multiport_conf {
+	struct virtio_console_config config;
+	/* max. number of ports this device can hold */
+	__u32 max_nr_ports;
+	/* number of ports added so far */
+	__u32 nr_ports;
+} __attribute__((packed));
+ 
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
 /*
  * This is a global struct for storing common data for all the devices
  * this driver handles.
@@ -120,7 +149,7 @@ struct ports_device {
 	spinlock_t cvq_lock;
 
 	/* The current config space is stored here */
-	struct virtio_console_config config;
+	struct virtio_console_multiport_conf config;
 
 	/* The virtio device we're associated with */
 	struct virtio_device *vdev;
@@ -1217,7 +1246,7 @@ fail:
  */
 static void config_work_handler(struct work_struct *work)
 {
-	struct virtio_console_config virtconconf;
+	struct virtio_console_multiport_conf virtconconf;
 	struct ports_device *portdev;
 	struct virtio_device *vdev;
 	int err;
@@ -1226,7 +1255,8 @@ static void config_work_handler(struct work_struct *work)
 
 	vdev = portdev->vdev;
 	vdev->config->get(vdev,
-			  offsetof(struct virtio_console_config, nr_ports),
+			  offsetof(struct virtio_console_multiport_conf,
+				   nr_ports),
 			  &virtconconf.nr_ports,
 			  sizeof(virtconconf.nr_ports));
 
@@ -1422,12 +1452,14 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		multiport = true;
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
 
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 nr_ports),
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_multiport_conf,
+					   nr_ports),
 				  &portdev->config.nr_ports,
 				  sizeof(portdev->config.nr_ports));
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 max_nr_ports),
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_multiport_conf,
+					   max_nr_ports),
 				  &portdev->config.max_nr_ports,
 				  sizeof(portdev->config.max_nr_ports));
 		if (portdev->config.nr_ports > portdev->config.max_nr_ports) {
@@ -1525,7 +1557,6 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
-	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
 static struct virtio_driver virtio_console = {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index ae4f039..92228a8 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -12,37 +12,14 @@
 
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
-#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 
 struct virtio_console_config {
 	/* colums of the screens */
 	__u16 cols;
 	/* rows of the screens */
 	__u16 rows;
-	/* max. number of ports this device can hold */
-	__u32 max_nr_ports;
-	/* number of ports added so far */
-	__u32 nr_ports;
 } __attribute__((packed));
 
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
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
 #endif /* __KERNEL__ */
