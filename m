From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/6] virtio: console: Add ability to remove module
Date: Fri, 12 Feb 2010 10:32:16 +0530
Message-ID: <1265950939-12359-4-git-send-email-amit.shah@redhat.com>
References: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-2-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1265950939-12359-3-git-send-email-amit.shah@redhat.com>
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

Add the ability to remove the virtio_console module.

This aids debugging.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 69d2e61..0057bae 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1448,6 +1448,36 @@ fail:
 	return err;
 }
 
+static void virtcons_remove(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+	struct port *port, *port2;
+	struct port_buffer *buf;
+	unsigned int len;
+
+	portdev = vdev->priv;
+
+	cancel_work_sync(&portdev->control_work);
+	cancel_work_sync(&portdev->config_work);
+
+	list_for_each_entry_safe(port, port2, &portdev->ports, list)
+		remove_port(port);
+
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
+
+	while ((buf = portdev->c_ivq->vq_ops->get_buf(portdev->c_ivq, &len)))
+		free_buf(buf);
+
+	while ((buf = portdev->c_ivq->vq_ops->detach_unused_buf(portdev->c_ivq)))
+		free_buf(buf);
+
+	vdev->config->del_vqs(vdev);
+	kfree(portdev->in_vqs);
+	kfree(portdev->out_vqs);
+
+	kfree(portdev);
+}
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -1465,6 +1495,7 @@ static struct virtio_driver virtio_console = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
+	.remove =	virtcons_remove,
 	.config_changed = config_intr,
 };
 
@@ -1488,7 +1519,17 @@ static int __init init(void)
 
 	return register_virtio_driver(&virtio_console);
 }
+
+static void __exit fini(void)
+{
+	unregister_virtio_driver(&virtio_console);
+
+	class_destroy(pdrvdata.class);
+	if (pdrvdata.debugfs_dir)
+		debugfs_remove_recursive(pdrvdata.debugfs_dir);
+}
 module_init(init);
+module_exit(fini);
 
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio console driver");
-- 
1.6.2.5
