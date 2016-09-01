From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] virtio: mark vring_dma_dev() static
Date: Thu,  1 Sep 2016 19:02:57 +0800
Message-ID: <1472727777-4695-1-git-send-email-baoyou.xie__46718.6408037834$1473186397$gmane$org@linaro.org>
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
To: mst@redhat.com
Cc: xie.baoyou@zte.com.cn, baoyou.xie@linaro.org, linux-kernel@vger.kernel.org, arnd@arndb.de, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We get 1 warning when building kernel with W=1:
drivers/virtio/virtio_ring.c:170:16: warning: no previous prototype for 'vring_dma_dev' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
so this patch marks this function with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 114a0c8..13b58db 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -167,7 +167,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
  * making all of the arch DMA ops work on the vring device itself
  * is a mess.  For now, we use the parent device for DMA ops.
  */
-struct device *vring_dma_dev(const struct vring_virtqueue *vq)
+static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 {
 	return vq->vq.vdev->dev.parent;
 }
-- 
2.7.4
