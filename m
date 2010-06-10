From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH for-2.6.35] virtio: return ENOMEM on out of memory
Date: Thu, 10 Jun 2010 18:16:11 +0300
Message-ID: <20100610151611.GA3430__44497.5970466205$1276183609$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20100610151901.GA3455@redhat.com>
Resent-To: virtualization@lists.linux-foundation.org
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit.shah@redhat.com>, Mark McLoughlin <markmc@redhat.com>, Tejun Heo <tj>
List-Id: virtualization@lists.linuxfoundation.org

add_buf returns ring size on out of memory,
this is not what devices expect.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Please consider this patch for 2.6.35.

 drivers/virtio/virtio_ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ed845b7..dd35b34 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -119,7 +119,7 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 
 	desc = kmalloc((out + in) * sizeof(struct vring_desc), gfp);
 	if (!desc)
-		return vq->vring.num;
+		return -ENOMEM;
 
 	/* Transfer entries from the sg list into the indirect page */
 	for (i = 0; i < out; i++) {
-- 
1.7.1.12.g42b7f
