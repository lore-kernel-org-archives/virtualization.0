From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 5/6] virtio: console: Handle hot-plug/unplug config actions
Date: Fri, 19 Mar 2010 17:36:47 +0530
Message-ID: <1269000408-29962-6-git-send-email-amit.shah@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-3-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-4-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-5-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269000408-29962-5-git-send-email-amit.shah@redhat.com>
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

The new way of handling hot-plug as well as unplug is via a
config interrupt.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   53 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9f2cbf0..06ca95c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1268,22 +1268,65 @@ static struct virtio_console_config *get_config(struct virtio_device *vdev,
 }
 
 /*
- * The workhandler for config-space updates.
+ * The workhandler for config-space updates.  Only called when
+ * multiport is supported.
  *
- * This is called when ports are hot-added.
+ * This is called when ports are hot-added and hot-removed.
  */
 static void config_work_handler(struct work_struct *work)
 {
-	struct virtio_console_config virtconconf;
+	struct virtio_console_config *config;
 	struct ports_device *portdev;
 	struct virtio_device *vdev;
-	int err;
+	unsigned int i, changed;
 
 	portdev = container_of(work, struct ports_device, config_work);
 
 	vdev = portdev->vdev;
 
-	/* FIXME: Handle port hotplug/unplug */
+	config = get_config(vdev, true);
+	if (!config) {
+		dev_warn(&vdev->dev,
+			 "Running out of memory on config change events\n");
+		return;
+	}
+
+	if (config->max_nr_ports != portdev->config->max_nr_ports) {
+		dev_warn(&vdev->dev,
+			 "Host updated max_nr_ports, can't handle that now.\n");
+		goto free;
+	}
+
+	changed = 0;
+	for (i = 0; i < (config->max_nr_ports + 31) / 32; i++) {
+		u32 map;
+
+		map = config->ports_map[i] ^ portdev->config->ports_map[i];
+		while (map) {
+			struct port *port;
+			u32 port_nr;
+
+			changed++;
+			port_nr = find_next_bit_in_map(&map) + i * 32;
+			port = find_port_by_id(portdev, port_nr);
+			if (port)
+				remove_port(port);
+			else
+				add_port(portdev, port_nr);
+		}
+		portdev->config->ports_map[i] = config->ports_map[i];
+	}
+	if (!changed && find_port_by_id(portdev, 0)) {
+		/*
+		 * No hot-plug / unplug activity. Port 0 might have
+		 * been hot-added.  Just send a 'ready' message in
+		 * that case, since we already have it added.
+		 */
+		send_control_msg(find_port_by_id(portdev, 0),
+				 VIRTIO_CONSOLE_PORT_READY, 1);
+	}
+free:
+	kfree(config);
 }
 
 static int init_vqs(struct ports_device *portdev)
-- 
1.6.2.5
