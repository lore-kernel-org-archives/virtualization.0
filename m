From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 28/32] virtio: console: Handle port hot-plug
Date: Mon, 18 Jan 2010 19:15:22 +0530
Message-ID: <1263822326-24208-29-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-10-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-11-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-12-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-13-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-14-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-15-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-16-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-17-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-18-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-19-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-20-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-21-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-22-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-23-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-24-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-25-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-26-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-27-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-28-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-28-git-send-email-amit.shah@redhat.com>
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

If the 'nr_ports' variable in the config space is updated to a higher
value, that means new ports have been hotplugged.

Introduce a new workqueue to handle such updates and create new ports.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   78 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0be5562..36cd7d4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -105,6 +105,7 @@ struct ports_device {
 	 * notification
 	 */
 	struct work_struct control_work;
+	struct work_struct config_work;
 
 	struct list_head ports;
 
@@ -695,11 +696,6 @@ static void resize_console(struct port *port)
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
@@ -960,6 +956,24 @@ static void control_intr(struct virtqueue *vq)
 	schedule_work(&portdev->control_work);
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
+	 * We'll use this way of resizing only for legacy support.
+	 * For newer userspace (VIRTIO_CONSOLE_F_MULTPORT+), use
+	 * control messages to indicate console size changes so that
+	 * it can be done per-port
+	 */
+	resize_console(find_port_by_id(portdev, 0));
+}
+
 static void fill_queue(struct virtqueue *vq, spinlock_t *lock)
 {
 	struct port_buffer *buf;
@@ -1080,6 +1094,57 @@ fail:
 	return err;
 }
 
+/*
+ * The workhandler for config-space updates.
+ *
+ * This is called when ports are hot-added.
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
+		 * Port 0 got hot-added.  Since we already did all the
+		 * other initialisation for it, just tell the Host
+		 * that the port is ready.
+		 */
+		struct port *port;
+
+		port = find_port_by_id(portdev, 0);
+		send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
+		return;
+	}
+	if (virtconconf.nr_ports > portdev->config.max_nr_ports) {
+		dev_warn(&vdev->dev,
+			 "More ports specified (%u) than allowed (%u)",
+			 portdev->config.nr_ports + 1,
+			 portdev->config.max_nr_ports);
+		return;
+	}
+	if (virtconconf.nr_ports < portdev->config.nr_ports)
+		return;
+
+	/* Hot-add ports */
+	while (virtconconf.nr_ports - portdev->config.nr_ports) {
+		err = add_port(portdev, portdev->config.nr_ports);
+		if (err)
+			break;
+		portdev->config.nr_ports++;
+	}
+}
+
 static int init_vqs(struct ports_device *portdev)
 {
 	vq_callback_t **io_callbacks;
@@ -1270,6 +1335,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	if (multiport) {
 		spin_lock_init(&portdev->cvq_lock);
 		INIT_WORK(&portdev->control_work, &control_work_handler);
+		INIT_WORK(&portdev->config_work, &config_work_handler);
 
 		portdev->outbuf = alloc_buf(PAGE_SIZE);
 		if (!portdev->outbuf) {
@@ -1316,7 +1382,7 @@ static struct virtio_driver virtio_console = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
-	.config_changed = virtcons_apply_config,
+	.config_changed = config_intr,
 };
 
 static int __init init(void)
-- 
1.6.2.5
