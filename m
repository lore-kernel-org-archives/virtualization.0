From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5/6] virtio_console: move removal code
Date: Fri, 20 Apr 2018 21:18:05 +0300
Message-ID: <1524248223-393618-6-git-send-email-mst__42952.7352018797$1524248197$gmane$org@redhat.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Will make it reusable for error handling.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 72 +++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2d87ce5..e8480fe 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1988,6 +1988,42 @@ static void remove_vqs(struct ports_device *portdev)
 	kfree(portdev->out_vqs);
 }
 
+static void virtcons_remove(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+	struct port *port, *port2;
+
+	portdev = vdev->priv;
+
+	spin_lock_irq(&pdrvdata_lock);
+	list_del(&portdev->list);
+	spin_unlock_irq(&pdrvdata_lock);
+
+	/* Disable interrupts for vqs */
+	vdev->config->reset(vdev);
+	/* Finish up work that's lined up */
+	if (use_multiport(portdev))
+		cancel_work_sync(&portdev->control_work);
+	else
+		cancel_work_sync(&portdev->config_work);
+
+	list_for_each_entry_safe(port, port2, &portdev->ports, list)
+		unplug_port(port);
+
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
+
+	/*
+	 * When yanking out a device, we immediately lose the
+	 * (device-side) queues.  So there's no point in keeping the
+	 * guest side around till we drop our final reference.  This
+	 * also means that any ports which are in an open state will
+	 * have to just stop using the port, as the vqs are going
+	 * away.
+	 */
+	remove_vqs(portdev);
+	kfree(portdev);
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2116,42 +2152,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 	return err;
 }
 
-static void virtcons_remove(struct virtio_device *vdev)
-{
-	struct ports_device *portdev;
-	struct port *port, *port2;
-
-	portdev = vdev->priv;
-
-	spin_lock_irq(&pdrvdata_lock);
-	list_del(&portdev->list);
-	spin_unlock_irq(&pdrvdata_lock);
-
-	/* Disable interrupts for vqs */
-	vdev->config->reset(vdev);
-	/* Finish up work that's lined up */
-	if (use_multiport(portdev))
-		cancel_work_sync(&portdev->control_work);
-	else
-		cancel_work_sync(&portdev->config_work);
-
-	list_for_each_entry_safe(port, port2, &portdev->ports, list)
-		unplug_port(port);
-
-	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
-
-	/*
-	 * When yanking out a device, we immediately lose the
-	 * (device-side) queues.  So there's no point in keeping the
-	 * guest side around till we drop our final reference.  This
-	 * also means that any ports which are in an open state will
-	 * have to just stop using the port, as the vqs are going
-	 * away.
-	 */
-	remove_vqs(portdev);
-	kfree(portdev);
-}
-
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
-- 
MST
