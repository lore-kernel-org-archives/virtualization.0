From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 25/28] virtio: console: Handle port hot-plug
Date: Sat, 28 Nov 2009 12:20:48 +0530
Message-ID: <1259391051-7752-26-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-11-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-15-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-16-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-17-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-18-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-19-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-20-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-21-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-22-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-23-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-24-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-25-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-25-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If the 'nr_ports' variable in the config space is updated to
a higher value, that means new ports have been hotplugged.

Introduce a new workqueue to handle such updates and create
new ports.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   73 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8fac9eb..47d84d7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -96,6 +96,7 @@ struct ports_device {
 	 * interrupt
 	 */
 	struct work_struct rx_work;
+	struct work_struct config_work;
 
 	struct list_head ports_head;
 	struct list_head unused_read_head;
@@ -640,11 +641,6 @@ static void resize_console(struct port *port)
 	}
 }
 
-static void virtcons_apply_config(struct virtio_device *vdev)
-{
-	resize_console(find_port_by_vtermno(0));
-}
-
 /* We set the configuration at this point, since we now have a tty */
 static int notifier_add_vio(struct hvc_struct *hp, int data)
 {
@@ -1045,6 +1041,24 @@ static void tx_intr(struct virtqueue *vq)
 	spin_unlock_irqrestore(&portdev->write_list_lock, flags);
 }
 
+static void config_intr(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+
+	portdev = vdev->priv;
+	if (use_multiport(portdev)) {
+		/* Handle port hot-add */
+		schedule_work(&portdev->config_work);
+	}
+	/*
+	 * We'll use this way of resizing only for legacy support. For
+	 * newer userspace (VIRTIO_CONSOLE_F_MULTPORT+), use control
+	 * messages to indicate console size changes so that it can be
+	 * done per-port
+	 */
+	resize_console(find_port_by_id(portdev, 0));
+}
+
 static ssize_t show_port_name(struct device *dev,
 			      struct device_attribute *attr, char *buffer)
 {
@@ -1067,7 +1081,7 @@ static struct attribute_group port_attribute_group = {
 	.attrs = port_sysfs_entries,
 };
 
-static int __devinit add_port(struct ports_device *portdev, u32 id)
+static int add_port(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
 	dev_t devt;
@@ -1143,6 +1157,50 @@ static struct file_operations portdev_fops = {
 };
 
 /*
+ * The workhandler for config-space updates
+ *
+ * This is used when new ports are added
+ */
+static void config_work_handler(struct work_struct *work)
+{
+	struct virtio_console_config virtconconf;
+	struct ports_device *portdev;
+	struct virtio_device *vdev;
+	int err;
+
+	portdev = container_of(work, struct ports_device, config_work);
+
+	vdev = portdev->vdev;
+	vdev->config->get(vdev,
+			  offsetof(struct virtio_console_config, nr_ports),
+			  &virtconconf.nr_ports,
+			  sizeof(virtconconf.nr_ports));
+
+	if (portdev->config.nr_ports == virtconconf.nr_ports) {
+		/*
+		 * Port 0 got hot-added. Since we already did all the other
+		 * initialisation for it, just ask the Host for the name
+		 * if set
+		 */
+		struct port *port;
+
+		port = find_port_by_id(portdev, 0);
+		send_control_msg(port, VIRTIO_CONSOLE_PORT_NAME, 1);
+		return;
+	}
+	if (virtconconf.nr_ports < portdev->config.nr_ports)
+		return;
+
+	/* Hot-add ports */
+	while(virtconconf.nr_ports - portdev->config.nr_ports) {
+		err = add_port(portdev, portdev->config.nr_ports);
+		if (err)
+			break;
+		portdev->config.nr_ports++;
+	}
+}
+
+/*
  * Once we're further in boot, we get probed like any other virtio
  * device.
  *
@@ -1210,6 +1268,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	INIT_LIST_HEAD(&portdev->unused_write_head);
 
 	INIT_WORK(&portdev->rx_work, &rx_work_handler);
+	INIT_WORK(&portdev->config_work, &config_work_handler);
 
 	fill_receive_queue(portdev);
 	alloc_write_bufs(portdev);
@@ -1248,7 +1307,7 @@ static struct virtio_driver virtio_console = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
-	.config_changed = virtcons_apply_config,
+	.config_changed = config_intr,
 };
 
 static int __init init(void)
-- 
1.6.2.5
