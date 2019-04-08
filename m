From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] virtio: Honour 'may_reduce_num' in vring_create_virtqueue
Date: Mon,  8 Apr 2019 14:33:22 +0200
Message-ID: <20190408123322.24086-1-cohuck__33180.7420401432$1554726816$gmane$org@redhat.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

vring_create_virtqueue() allows the caller to specify via the
may_reduce_num parameter whether the vring code is allowed to
allocate a smaller ring than specified.

However, the split ring allocation code tries to allocate a
smaller ring on allocation failure regardless of what the
caller specified. This may cause trouble for e.g. virtio-pci
in legacy mode, which does not support ring resizing. (The
packed ring code does not resize in any case.)

Let's fix this by bailing out immediately in the split ring code
if the requested size cannot be allocated and may_reduce_num has
not been specified.

While at it, fix a typo in the usage instructions.

Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 include/linux/virtio_ring.h  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 18846afb39da..5df92c308286 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -882,6 +882,8 @@ static struct virtqueue *vring_create_virtqueue_split(
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
 			break;
+		if (!may_reduce_num)
+			return NULL;
 	}
 
 	if (!num)
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index fab02133a919..3dc70adfe5f5 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -63,7 +63,7 @@ struct virtqueue;
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
- * expected.  The caller should query virtqueue_get_ring_size to learn
+ * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
  */
 struct virtqueue *vring_create_virtqueue(unsigned int index,
-- 
2.17.2
