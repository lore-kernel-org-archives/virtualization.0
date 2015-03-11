From: Fam Zheng <famz@redhat.com>
Subject: [PATCH] virtio: Remove virtio device during shutdown
Date: Wed, 11 Mar 2015 16:09:17 +0800
Message-ID: <1426061357-4440-1-git-send-email-famz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Currently shutdown is nop for virtio devices, but the core code could
remove things behind us such as MSI-X handler etc. For example in the
case of virtio-scsi-pci, the device may still try to send interupts,
which will be on IRQ lines seeing MSI-X disabled. Those interrupts will
be unhandled, and may cause flood.

Remove the device in "shutdown" callback to allow device drivers clean
up things.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/virtio/virtio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 5ce2aa4..12f1f1e 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -269,6 +269,19 @@ static int virtio_dev_remove(struct device *_d)
 	return 0;
 }
 
+static void virtio_dev_shutdown(struct device *_d)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	virtio_config_disable(dev);
+
+	drv->remove(dev);
+
+	/* Driver should have reset device. */
+	WARN_ON_ONCE(dev->config->get_status(dev));
+}
+
 static struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -276,6 +289,7 @@ static struct bus_type virtio_bus = {
 	.uevent = virtio_uevent,
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
+	.shutdown = virtio_dev_shutdown,
 };
 
 bool virtio_device_is_legacy_only(struct virtio_device_id id)
-- 
1.9.3
