From: Jiri Benc <jbenc@redhat.com>
Subject: [PATCH] virtio: silence compiler warning
Date: Wed, 27 Apr 2016 11:33:15 +0200
Message-ID: <4819fed0abbd533062c09687845a6fe3d759fb22.1461749551.git.jbenc__13757.1245468736$1462273036$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

gcc 4.8.5 emits the following false positive:

drivers/virtio/virtio_ring.c: In function 'vring_create_virtqueue':
drivers/virtio/virtio_ring.c:1032:5: warning: 'queue' may be used uninitialized in this function [-Wmaybe-uninitialized]

Silence it.

Signed-off-by: Jiri Benc <jbenc@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c802d47892c..ca6bfddaacad 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1006,7 +1006,7 @@ struct virtqueue *vring_create_virtqueue(
 	const char *name)
 {
 	struct virtqueue *vq;
-	void *queue;
+	void *queue = NULL;
 	dma_addr_t dma_addr;
 	size_t queue_size_in_bytes;
 	struct vring vring;
-- 
1.8.3.1
