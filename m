From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/6] virtio: console: Switch to using a port bitmap for port
	discovery
Date: Fri, 19 Mar 2010 17:36:45 +0530
Message-ID: <1269000408-29962-4-git-send-email-amit.shah@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269000408-29962-3-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, quintela@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ports are now discovered by their location as given by host instead of
just incrementing a number and expecting the host and guest numbers stay
in sync. They are needed to be the same because the control messages
identify ports using the port id.

This is most beneficial to management software to properly place ports
at known ids so that the ids after hot-plug/unplug operations can be
controlled. This helps migration of guests after such hot-plug/unplug
operations.

The support for port hot-plug is removed in this commit, will be added
in the following commits.

The config space is now a variable-sized array.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |  139 ++++++++++++++++++++++------------------
 include/linux/virtio_console.h |   14 +++-
 2 files changed, 87 insertions(+), 66 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 44288ce..dc15c92 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -120,7 +120,7 @@ struct ports_device {
 	spinlock_t cvq_lock;
 
 	/* The current config space is stored here */
-	struct virtio_console_config config;
+	struct virtio_console_config *config;
 
 	/* The virtio device we're associated with */
 	struct virtio_device *vdev;
@@ -1210,6 +1210,23 @@ fail:
 	return err;
 }
 
+static u32 find_next_bit_in_map(u32 *map)
+{
+	u32 port_bit;
+
+	port_bit = ffs(*map);
+	port_bit--; /* ffs returns bit location */
+
+	*map &= ~(1U << port_bit);
+
+	return port_bit;
+}
+
+static u32 get_ports_map_size(u32 max_nr_ports)
+{
+	return sizeof(u32) * ((max_nr_ports + 31)/ 32);
+}
+
 /*
  * The workhandler for config-space updates.
  *
@@ -1225,45 +1242,8 @@ static void config_work_handler(struct work_struct *work)
 	portdev = container_of(work, struct ports_device, config_work);
 
 	vdev = portdev->vdev;
-	vdev->config->get(vdev,
-			  offsetof(struct virtio_console_config, nr_ports),
-			  &virtconconf.nr_ports,
-			  sizeof(virtconconf.nr_ports));
 
-	if (portdev->config.nr_ports == virtconconf.nr_ports) {
-		/*
-		 * Port 0 got hot-added.  Since we already did all the
-		 * other initialisation for it, just tell the Host
-		 * that the port is ready if we find the port.  In
-		 * case the port was hot-removed earlier, we call
-		 * add_port to add the port.
-		 */
-		struct port *port;
-
-		port = find_port_by_id(portdev, 0);
-		if (!port)
-			add_port(portdev, 0);
-		else
-			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
-		return;
-	}
-	if (virtconconf.nr_ports > portdev->config.max_nr_ports) {
-		dev_warn(&vdev->dev,
-			 "More ports specified (%u) than allowed (%u)",
-			 portdev->config.nr_ports + 1,
-			 portdev->config.max_nr_ports);
-		return;
-	}
-	if (virtconconf.nr_ports < portdev->config.nr_ports)
-		return;
-
-	/* Hot-add ports */
-	while (virtconconf.nr_ports - portdev->config.nr_ports) {
-		err = add_port(portdev, portdev->config.nr_ports);
-		if (err)
-			break;
-		portdev->config.nr_ports++;
-	}
+	/* FIXME: Handle port hotplug/unplug */
 }
 
 static int init_vqs(struct ports_device *portdev)
@@ -1274,7 +1254,7 @@ static int init_vqs(struct ports_device *portdev)
 	u32 i, j, nr_ports, nr_queues;
 	int err;
 
-	nr_ports = portdev->config.max_nr_ports;
+	nr_ports = portdev->config->max_nr_ports;
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
 	vqs = kmalloc(nr_queues * sizeof(struct virtqueue *), GFP_KERNEL);
@@ -1387,7 +1367,6 @@ static const struct file_operations portdev_fops = {
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
 	struct ports_device *portdev;
-	u32 i;
 	int err;
 	bool multiport;
 
@@ -1415,30 +1394,45 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		goto free;
 	}
 
-	multiport = false;
-	portdev->config.nr_ports = 1;
-	portdev->config.max_nr_ports = 1;
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
+		u32 max_nr_ports;
+
 		multiport = true;
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
 
 		vdev->config->get(vdev, offsetof(struct virtio_console_config,
-						 nr_ports),
-				  &portdev->config.nr_ports,
-				  sizeof(portdev->config.nr_ports));
-		vdev->config->get(vdev, offsetof(struct virtio_console_config,
 						 max_nr_ports),
-				  &portdev->config.max_nr_ports,
-				  sizeof(portdev->config.max_nr_ports));
-		if (portdev->config.nr_ports > portdev->config.max_nr_ports) {
-			dev_warn(&vdev->dev,
-				 "More ports (%u) specified than allowed (%u). Will init %u ports.",
-				 portdev->config.nr_ports,
-				 portdev->config.max_nr_ports,
-				 portdev->config.max_nr_ports);
-
-			portdev->config.nr_ports = portdev->config.max_nr_ports;
+				  &max_nr_ports, sizeof(max_nr_ports));
+		/*
+		 * We have a variable-sized config space that's
+		 * dependent on the maximum number of ports a guest
+		 * can have.  So we first get the max number of ports
+		 * we can have and then allocate the config space
+		 */
+		portdev->config = kmalloc(sizeof(struct virtio_console_config)
+					  + get_ports_map_size(max_nr_ports),
+					  GFP_KERNEL);
+		if (!portdev->config) {
+			err = -ENOMEM;
+			goto free_chrdev;
+		}
+
+		portdev->config->max_nr_ports = max_nr_ports;
+		vdev->config->get(vdev, offsetof(struct virtio_console_config,
+						 ports_map),
+				  portdev->config->ports_map,
+				  get_ports_map_size(max_nr_ports));
+	} else {
+		multiport = false;
+
+		portdev->config = kmalloc(sizeof(struct virtio_console_config),
+					  GFP_KERNEL);
+		if (!portdev->config) {
+			err = -ENOMEM;
+			goto free_chrdev;
 		}
+
+		portdev->config->max_nr_ports = 1;
 	}
 
 	/* Let the Host know we support multiple ports.*/
@@ -1447,14 +1441,14 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	err = init_vqs(portdev);
 	if (err < 0) {
 		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-		goto free_chrdev;
+		goto free_config;
 	}
 
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
 
 	if (multiport) {
-		unsigned int nr_added_bufs;
+		unsigned int nr_added_bufs, i;
 
 		spin_lock_init(&portdev->cvq_lock);
 		INIT_WORK(&portdev->control_work, &control_work_handler);
@@ -1467,10 +1461,26 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 			err = -ENOMEM;
 			goto free_vqs;
 		}
-	}
 
-	for (i = 0; i < portdev->config.nr_ports; i++)
-		add_port(portdev, i);
+		for (i = 0; i < (portdev->config->max_nr_ports + 31) / 32; i++) {
+			u32 map, port_nr;
+
+			map = portdev->config->ports_map[i];
+			while (map) {
+				port_nr = find_next_bit_in_map(&map) + i * 32;
+
+				add_port(portdev, port_nr);
+				/*
+				 * FIXME: Send a notification to the
+				 * host about failed port add
+				 */
+			}
+		}
+	} else {
+		err = add_port(portdev, 0);
+		if (err)
+			goto free_vqs;
+	}
 
 	/* Start using the new console output. */
 	early_put_chars = NULL;
@@ -1480,6 +1490,8 @@ free_vqs:
 	vdev->config->del_vqs(vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
+free_config:
+	kfree(portdev->config);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
@@ -1514,6 +1526,7 @@ static void virtcons_remove(struct virtio_device *vdev)
 	vdev->config->del_vqs(vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
+	kfree(portdev->config);
 
 	kfree(portdev);
 }
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index ae4f039..287ee44 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -14,15 +14,23 @@
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
 #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 
+/*
+ * This is the config space shared between the Host and the Guest.
+ * The Host indicates to us the maximum number of ports this device
+ * can hold and a port map indicating which ports are active.
+ *
+ * The maximum number of ports is not a round number to prevent
+ * wastage of MSI vectors in case MSI is enabled for this device.
+ */
 struct virtio_console_config {
 	/* colums of the screens */
 	__u16 cols;
 	/* rows of the screens */
 	__u16 rows;
-	/* max. number of ports this device can hold */
+	/* max. number of ports this device can hold. */
 	__u32 max_nr_ports;
-	/* number of ports added so far */
-	__u32 nr_ports;
+	/* locations of ports in use; variable-sized array */
+	__u32 ports_map[0 /* (max_nr_ports + 31) / 2 */];
 } __attribute__((packed));
 
 /*
-- 
1.6.2.5
