From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 05/10] virtio: console: Remove config work handler
Date: Mon,  5 Apr 2010 19:24:09 +0530
Message-ID: <1270475654-399-6-git-send-email-amit.shah@redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-2-git-send-email-amit.shah@redhat.com>
	<1270475654-399-3-git-send-email-amit.shah@redhat.com>
	<1270475654-399-4-git-send-email-amit.shah@redhat.com>
	<1270475654-399-5-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-5-git-send-email-amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We're going to switch to using control messages for port hot-plug and
initial port discovery. Remove the config work handler which handled
port hot-plug so far.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   64 +----------------------------------------
 1 files changed, 1 insertions(+), 63 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b40b112..0473221 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -109,7 +109,6 @@ struct ports_device {
 	 * notification
 	 */
 	struct work_struct control_work;
-	struct work_struct config_work;
 
 	struct list_head ports;
 
@@ -1091,10 +1090,7 @@ static void config_intr(struct virtio_device *vdev)
 	struct ports_device *portdev;
 
 	portdev = vdev->priv;
-	if (use_multiport(portdev)) {
-		/* Handle port hot-add */
-		schedule_work(&portdev->config_work);
-	}
+
 	/*
 	 * We'll use this way of resizing only for legacy support.
 	 * For newer userspace (VIRTIO_CONSOLE_F_MULTPORT+), use
@@ -1237,62 +1233,6 @@ fail:
 	return err;
 }
 
-/*
- * The workhandler for config-space updates.
- *
- * This is called when ports are hot-added.
- */
-static void config_work_handler(struct work_struct *work)
-{
-	struct virtio_console_config virtconconf;
-	struct ports_device *portdev;
-	struct virtio_device *vdev;
-	int err;
-
-	portdev = container_of(work, struct ports_device, config_work);
-
-	vdev = portdev->vdev;
-	vdev->config->get(vdev,
-			  offsetof(struct virtio_console_config, nr_ports),
-			  &virtconconf.nr_ports,
-			  sizeof(virtconconf.nr_ports));
-
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
-}
-
 static int init_vqs(struct ports_device *portdev)
 {
 	vq_callback_t **io_callbacks;
@@ -1485,7 +1425,6 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 		spin_lock_init(&portdev->cvq_lock);
 		INIT_WORK(&portdev->control_work, &control_work_handler);
-		INIT_WORK(&portdev->config_work, &config_work_handler);
 
 		nr_added_bufs = fill_queue(portdev->c_ivq, &portdev->cvq_lock);
 		if (!nr_added_bufs) {
@@ -1528,7 +1467,6 @@ static void virtcons_remove(struct virtio_device *vdev)
 	portdev = vdev->priv;
 
 	cancel_work_sync(&portdev->control_work);
-	cancel_work_sync(&portdev->config_work);
 
 	list_for_each_entry_safe(port, port2, &portdev->ports, list)
 		remove_port(port);
-- 
1.6.2.5
