From: Felipe Franciosi <felipe@nutanix.com>
Subject: [PATCH] virtio_ring: fix description of virtqueue_get_buf
Date: Mon, 14 Nov 2016 06:16:15 -0800
Message-ID: <1479132975-8517-1-git-send-email-felipe@nutanix.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The device (not the driver) populates the used ring and includes the len
of how much data was written.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 489bfc6..8a0d6a9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -649,7 +649,7 @@ static inline bool more_used(const struct vring_virtqueue *vq)
  * @vq: the struct virtqueue we're talking about.
  * @len: the length written into the buffer
  *
- * If the driver wrote data into the buffer, @len will be set to the
+ * If the device wrote data into the buffer, @len will be set to the
  * amount written.  This means you don't need to clear the buffer
  * beforehand to ensure there's no data leakage in the case of short
  * writes.
-- 
1.9.4
