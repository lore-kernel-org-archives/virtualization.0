From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 6/6] virtio: drop virtio_device_is_legacy_only
Date: Tue, 31 Mar 2015 21:52:54 +0200
Message-ID: <1427831230-28044-7-git-send-email-mst@redhat.com>
References: <1427831230-28044-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427831230-28044-1-git-send-email-mst@redhat.com>
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
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, Paul Bolle <pebolle@tiscali.nl>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_device_is_legacy_only is now unused, drop
it from core.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h  | 2 --
 drivers/virtio/virtio.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 28f0e65..8f4d4bf 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -108,8 +108,6 @@ struct virtio_device {
 	void *priv;
 };
 
-bool virtio_device_is_legacy_only(struct virtio_device_id id);
-
 static inline struct virtio_device *dev_to_virtio(struct device *_dev)
 {
 	return container_of(_dev, struct virtio_device, dev);
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 5fa67b5..b1877d7 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -278,12 +278,6 @@ static struct bus_type virtio_bus = {
 	.remove = virtio_dev_remove,
 };
 
-bool virtio_device_is_legacy_only(struct virtio_device_id id)
-{
-	return false;
-}
-EXPORT_SYMBOL_GPL(virtio_device_is_legacy_only);
-
 int register_virtio_driver(struct virtio_driver *driver)
 {
 	/* Catch this early. */
-- 
MST
