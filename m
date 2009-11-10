From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 09/15] virtio_console: Handle port hot-plug
Date: Tue, 10 Nov 2009 15:11:35 +0530
Message-ID: <1257846101-23258-10-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-6-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-7-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-8-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-9-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-9-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   53 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 4119c37..3458340 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -49,6 +49,7 @@ struct virtio_console_struct {
 	 */
 	struct work_struct rx_work;
 	struct work_struct tx_work;
+	struct work_struct config_work;
 
 	struct list_head port_head;
 	struct list_head unused_read_head;
@@ -869,6 +870,10 @@ static void tx_intr(struct virtqueue *vq)
 
 static void config_intr(struct virtio_device *vdev)
 {
+	if (use_multiport(&virtconsole)) {
+		/* Handle port hot-add */
+		schedule_work(&virtconsole.config_work);
+	}
 	/*
 	 * We'll use this way of resizing only for legacy support. For
 	 * newer userspace (VIRTIO_CONSOLE_F_MULTPORT+), use control
@@ -942,6 +947,53 @@ free_port:
 	return ret;
 }
 
+/*
+ * The workhandler for config-space updates
+ *
+ * This is used when new ports are added
+ */
+static void virtio_console_config_work_handler(struct work_struct *work)
+{
+	struct virtio_console_struct *vcon;
+	struct virtio_console_config virtconconf;
+	struct virtio_device *vdev;
+	int err;
+
+	vcon = container_of(work, struct virtio_console_struct, config_work);
+
+	vdev = vcon->vdev;
+	vdev->config->get(vdev,
+			  offsetof(struct virtio_console_config, nr_ports),
+			  &virtconconf.nr_ports,
+			  sizeof(virtconconf.nr_ports));
+
+	if (vcon->config.nr_ports == virtconconf.nr_ports) {
+		/*
+		 * Port 0 got hot-added. Since we already did all the other
+		 * initialisation for it, just ask the Host for the name
+		 * if set
+		 */
+		struct virtio_console_control cpkt;
+		struct virtio_console_port *port;
+
+		port = get_port_from_id(0);
+		cpkt.event = VIRTIO_CONSOLE_PORT_NAME;
+		send_buf(port, (char *)&cpkt, sizeof(cpkt),
+			 VIRTIO_CONSOLE_ID_CONTROL, false);
+		return;
+	}
+	if (virtconconf.nr_ports < vcon->config.nr_ports)
+		return;
+
+	/* Hot-add ports */
+	while(virtconconf.nr_ports - vcon->config.nr_ports) {
+		err = virtconsole_add_port(vcon->config.nr_ports);
+		if (err)
+			break;
+		vcon->config.nr_ports++;
+	}
+}
+
 /*D:370
  * Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
@@ -1002,6 +1054,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&virtconsole.rx_work, &virtio_console_rx_work_handler);
 	INIT_WORK(&virtconsole.tx_work, &virtio_console_tx_work_handler);
+	INIT_WORK(&virtconsole.config_work, &virtio_console_config_work_handler);
 
 	fill_receive_queue(&virtconsole);
 	alloc_write_bufs(&virtconsole);
-- 
1.6.2.5
