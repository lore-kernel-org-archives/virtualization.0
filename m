From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 1/3] virtio: add API to detect legacy devices
Date: Thu, 4 Dec 2014 19:26:42 +0200
Message-ID: <1417713984-23771-1-git-send-email-mst@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

transports need to be able to detect legacy-only
devices (ATM balloon only) to use legacy path
to drive them.

Add a core API to do just that.
The implementation just blacklists balloon:
not too pretty, but let's not over-engineer.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h  | 2 ++
 drivers/virtio/virtio.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2bbf626..d666bcb 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -108,6 +108,8 @@ struct virtio_device {
 	void *priv;
 };
 
+bool virtio_device_is_legacy_only(struct virtio_device_id id);
+
 static inline struct virtio_device *dev_to_virtio(struct device *_dev)
 {
 	return container_of(_dev, struct virtio_device, dev);
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index fa6b75d..6b4c1113 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -267,6 +267,12 @@ static struct bus_type virtio_bus = {
 	.remove = virtio_dev_remove,
 };
 
+bool virtio_device_is_legacy_only(struct virtio_device_id id)
+{
+	return id.device == VIRTIO_ID_BALLOON;
+}
+EXPORT_SYMBOL_GPL(register_virtio_driver);
+
 int register_virtio_driver(struct virtio_driver *driver)
 {
 	/* Catch this early. */
-- 
MST
