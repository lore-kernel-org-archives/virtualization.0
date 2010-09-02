From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 10/14] virtio: console: Add a list of portdevs that are active
Date: Thu,  2 Sep 2010 18:11:49 +0530
Message-ID: <178ca01934094d370d542bed75844e1700d77b2c.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The virtio_console.c driver is capable of handling multiple devices at a
time. Maintain a list of devices for future traversal.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d689c76..a37a868 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -48,6 +48,9 @@ struct ports_driver_data {
 	/* Used for exporting per-port information to debugfs */
 	struct dentry *debugfs_dir;
 
+	/* List of all the devices we're handling */
+	struct list_head portdevs;
+
 	/* Number of devices this driver is handling */
 	unsigned int index;
 
@@ -108,6 +111,9 @@ struct port_buffer {
  * ports for that device (vdev->priv).
  */
 struct ports_device {
+	/* Next portdev in the list, head is in the pdrvdata struct */
+	struct list_head list;
+
 	/*
 	 * Workqueue handlers where we process deferred work after
 	 * notification
@@ -1584,6 +1590,10 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		add_port(portdev, 0);
 	}
 
+	spin_lock_irq(&pdrvdata_lock);
+	list_add_tail(&portdev->list, &pdrvdata.portdevs);
+	spin_unlock_irq(&pdrvdata_lock);
+
 	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
 			   VIRTIO_CONSOLE_DEVICE_READY, 1);
 	return 0;
@@ -1610,6 +1620,10 @@ static void virtcons_remove(struct virtio_device *vdev)
 
 	portdev = vdev->priv;
 
+	spin_lock_irq(&pdrvdata_lock);
+	list_del(&portdev->list);
+	spin_unlock_irq(&pdrvdata_lock);
+
 	/* Disable interrupts for vqs */
 	vdev->config->reset(vdev);
 	/* Finish up work that's lined up */
@@ -1676,6 +1690,7 @@ static int __init init(void)
 			   PTR_ERR(pdrvdata.debugfs_dir));
 	}
 	INIT_LIST_HEAD(&pdrvdata.consoles);
+	INIT_LIST_HEAD(&pdrvdata.portdevs);
 
 	return register_virtio_driver(&virtio_console);
 }
-- 
1.7.2.2
