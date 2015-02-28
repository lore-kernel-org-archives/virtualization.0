From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_console: avoid config access from irq
Date: Sat, 28 Feb 2015 18:42:25 +0100
Message-ID: <1425145305-27917-1-git-send-email-mst__41718.3936726817$1425145370$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

when multiport is off, virtio console invokes config access from irq
context, config access is blocking on s390.
Fix this up by scheduling work from config irq - similar to what we do
for multiport configs.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Applies on top of "virtio_console: init work unconditionally"
that I sent previously.

 drivers/char/virtio_console.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index def736d..72d7028 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -142,6 +142,7 @@ struct ports_device {
 	 * notification
 	 */
 	struct work_struct control_work;
+	struct work_struct config_work;
 
 	struct list_head ports;
 
@@ -1837,10 +1838,21 @@ static void config_intr(struct virtio_device *vdev)
 
 	portdev = vdev->priv;
 
+	if (!use_multiport(portdev))
+		schedule_work(&portdev->config_work);
+}
+
+static void config_work_handler(struct work_struct *work)
+{
+	struct ports_device *portdev;
+
+	portdev = container_of(work, struct ports_device, control_work);
 	if (!use_multiport(portdev)) {
+		struct virtio_device *vdev;
 		struct port *port;
 		u16 rows, cols;
 
+		vdev = portdev->vdev;
 		virtio_cread(vdev, struct virtio_console_config, cols, &cols);
 		virtio_cread(vdev, struct virtio_console_config, rows, &rows);
 
@@ -2040,6 +2052,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(portdev->vdev);
 
+	INIT_WORK(&portdev->config_work, &config_work_handler);
 	INIT_WORK(&portdev->control_work, &control_work_handler);
 
 	if (multiport) {
@@ -2114,6 +2127,8 @@ static void virtcons_remove(struct virtio_device *vdev)
 	/* Finish up work that's lined up */
 	if (use_multiport(portdev))
 		cancel_work_sync(&portdev->control_work);
+	else
+		cancel_work_sync(&portdev->config_work);
 
 	list_for_each_entry_safe(port, port2, &portdev->ports, list)
 		unplug_port(port);
@@ -2165,6 +2180,7 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
 	virtqueue_disable_cb(portdev->c_ivq);
 	cancel_work_sync(&portdev->control_work);
+	cancel_work_sync(&portdev->config_work);
 	/*
 	 * Once more: if control_work_handler() was running, it would
 	 * enable the cb as the last step.
-- 
MST
