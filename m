From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 08/11] virtio: console: Use a control message to add ports
Date: Thu,  8 Apr 2010 20:19:37 +0530
Message-ID: <1270738180-21170-9-git-send-email-amit.shah@redhat.com>
References: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-2-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-3-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-4-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-5-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-6-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-7-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270738180-21170-8-git-send-email-amit.shah@redhat.com>
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

Instead of the host and guest independently enumerating ports, switch to
a control message to add ports where the host supplies the port number
so there's no ambiguity or a possibility of a race between the host and
the guest port numbers.

We now no longer need the 'nr_ports' config value. Since no kernel has
been released with the MULTIPORT changes yet, we have a chance to fiddle
with the config space without adding compatibility features.

This is beneficial for management software, which would now be able to
instantiate ports at known locations and avoid problems that arise with
implicit numbering in the host and the guest. This removes the 'guessing
game' part of it, and management software can now actually indicate
which id to spawn a particular port on.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   77 +++++++++++++++++-----------------------
 include/linux/virtio_console.h |   17 ++++-----
 2 files changed, 41 insertions(+), 53 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index f155de9..4087248 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1046,7 +1046,7 @@ static void handle_control_message(struct ports_device *portdev,
 	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
 
 	port = find_port_by_id(portdev, cpkt->id);
-	if (!port) {
+	if (!port && cpkt->event != VIRTIO_CONSOLE_PORT_ADD) {
 		/* No valid header at start of buffer.  Drop it. */
 		dev_dbg(&portdev->vdev->dev,
 			"Invalid index %u in control packet\n", cpkt->id);
@@ -1054,6 +1054,30 @@ static void handle_control_message(struct ports_device *portdev,
 	}
 
 	switch (cpkt->event) {
+	case VIRTIO_CONSOLE_PORT_ADD:
+		if (port) {
+			/*
+			 * This can happen for port 0: we have to
+			 * create a console port during probe() as was
+			 * the behaviour before the MULTIPORT feature.
+			 * On a newer host, when the host tells us
+			 * that a port 0 is available, we should just
+			 * say we have the port all set up.
+			 */
+			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
+			break;
+		}
+		if (cpkt->id >= portdev->config.max_nr_ports) {
+			dev_warn(&portdev->vdev->dev,
+				"Request for adding port with out-of-bound id %u, max. supported id: %u\n",
+				cpkt->id, portdev->config.max_nr_ports - 1);
+			break;
+		}
+		add_port(portdev, cpkt->id);
+		break;
+	case VIRTIO_CONSOLE_PORT_REMOVE:
+		remove_port(port);
+		break;
 	case VIRTIO_CONSOLE_CONSOLE_PORT:
 		if (!cpkt->value)
 			break;
@@ -1112,32 +1136,6 @@ static void handle_control_message(struct ports_device *portdev,
 			kobject_uevent(&port->dev->kobj, KOBJ_CHANGE);
 		}
 		break;
-	case VIRTIO_CONSOLE_PORT_REMOVE:
-		/*
-		 * Hot unplug the port.  We don't decrement nr_ports
-		 * since we don't want to deal with extra complexities
-		 * of using the lowest-available port id: We can just
-		 * pick up the nr_ports number as the id and not have
-		 * userspace send it to us.  This helps us in two
-		 * ways:
-		 *
-		 * - We don't need to have a 'port_id' field in the
-		 *   config space when a port is hot-added.  This is a
-		 *   good thing as we might queue up multiple hotplug
-		 *   requests issued in our workqueue.
-		 *
-		 * - Another way to deal with this would have been to
-		 *   use a bitmap of the active ports and select the
-		 *   lowest non-active port from that map.  That
-		 *   bloats the already tight config space and we
-		 *   would end up artificially limiting the
-		 *   max. number of ports to sizeof(bitmap).  Right
-		 *   now we can support 2^32 ports (as the port id is
-		 *   stored in a u32 type).
-		 *
-		 */
-		remove_port(port);
-		break;
 	}
 }
 
@@ -1345,7 +1343,6 @@ static const struct file_operations portdev_fops = {
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
 	struct ports_device *portdev;
-	u32 i;
 	int err;
 	bool multiport;
 
@@ -1374,29 +1371,15 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	}
 
 	multiport = false;
-	portdev->config.nr_ports = 1;
 	portdev->config.max_nr_ports = 1;
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
 		multiport = true;
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
 
 		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 nr_ports),
-				  &portdev->config.nr_ports,
-				  sizeof(portdev->config.nr_ports));
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
 						 max_nr_ports),
 				  &portdev->config.max_nr_ports,
 				  sizeof(portdev->config.max_nr_ports));
-		if (portdev->config.nr_ports > portdev->config.max_nr_ports) {
-			dev_warn(&vdev->dev,
-				 "More ports (%u) specified than allowed (%u). Will init %u ports.",
-				 portdev->config.nr_ports,
-				 portdev->config.max_nr_ports,
-				 portdev->config.max_nr_ports);
-
-			portdev->config.nr_ports = portdev->config.max_nr_ports;
-		}
 	}
 
 	/* Let the Host know we support multiple ports.*/
@@ -1426,11 +1409,17 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		}
 	}
 
-	for (i = 0; i < portdev->config.nr_ports; i++)
-		add_port(portdev, i);
+	/*
+	 * For backward compatibility: if we're running on an older
+	 * host, we always want to create a console port.
+	 */
+	add_port(portdev, 0);
 
 	/* Start using the new console output. */
 	early_put_chars = NULL;
+
+	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+			   VIRTIO_CONSOLE_DEVICE_READY, 1);
 	return 0;
 
 free_vqs:
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 0157361..a85064d 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -23,8 +23,6 @@ struct virtio_console_config {
 	__u16 rows;
 	/* max. number of ports this device can hold */
 	__u32 max_nr_ports;
-	/* number of ports added so far */
-	__u32 nr_ports;
 } __attribute__((packed));
 
 /*
@@ -38,13 +36,14 @@ struct virtio_console_control {
 };
 
 /* Some events for control messages */
-#define VIRTIO_CONSOLE_PORT_READY	0
-#define VIRTIO_CONSOLE_CONSOLE_PORT	1
-#define VIRTIO_CONSOLE_RESIZE		2
-#define VIRTIO_CONSOLE_PORT_OPEN	3
-#define VIRTIO_CONSOLE_PORT_NAME	4
-#define VIRTIO_CONSOLE_PORT_REMOVE	5
-#define VIRTIO_CONSOLE_DEVICE_READY	6
+#define VIRTIO_CONSOLE_DEVICE_READY	0
+#define VIRTIO_CONSOLE_PORT_ADD		1
+#define VIRTIO_CONSOLE_PORT_REMOVE	2
+#define VIRTIO_CONSOLE_PORT_READY	3
+#define VIRTIO_CONSOLE_CONSOLE_PORT	4
+#define VIRTIO_CONSOLE_RESIZE		5
+#define VIRTIO_CONSOLE_PORT_OPEN	6
+#define VIRTIO_CONSOLE_PORT_NAME	7
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
