From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 10/16] virtio: add API to enable VQs early
Date: Sun, 5 Oct 2014 19:07:19 +0300
Message-ID: <1412525038-15871-11-git-send-email-mst__5313.77324737168$1412525096$gmane$org@redhat.com>
References: <1412525038-15871-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1412525038-15871-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio spec requires DRIVER_OK to be set before
VQs are used, but some drivers use VQs before probe
function returns.
Since DRIVER_OK is set after probe, this violates the spec.

Add API for drivers to call before using VQs.

Sets DRIVER_OK internally.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e8f8f71..6127fc8 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -109,6 +109,23 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 	return vq;
 }
 
+/**
+ * virtio_early_enable_vqs - enable vq use in probe function
+ * @vdev: the device
+ *
+ * Driver must call this to use vqs in the probe function.
+ *
+ * Note: vqs are enabled automatically after probe returns.
+ */
+static inline
+void virtio_early_enable_vqs(struct virtio_device *dev)
+{
+	unsigned status = dev->config->get_status(dev);
+
+	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
+}
+
 static inline
 const char *virtio_bus_name(struct virtio_device *vdev)
 {
-- 
MST
