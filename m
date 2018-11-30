From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH] vhost: fix IOTLB locking
Date: Fri, 30 Nov 2018 11:37:02 +0000
Message-ID: <20181130113702.1565-1-jean-philippe.brucker@arm.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Commit 78139c94dc8c ("net: vhost: lock the vqs one by one") moved the vq
lock to improve scalability, but introduced a possible deadlock in
vhost-iotlb. vhost_iotlb_notify_vq() now takes vq->mutex while holding
the device's IOTLB spinlock. And on the vhost_iotlb_miss() path, the
spinlock is taken while holding vq->mutex.

As long as we hold dev->mutex to prevent an ioctl from modifying
vq->poll concurrently, we can safely call vhost_poll_queue() without
holding vq->mutex. Since vhost_process_iotlb_msg() holds dev->mutex when
calling vhost_iotlb_notify_vq(), avoid the deadlock by not taking
vq->mutex.

Fixes: 78139c94dc8c ("net: vhost: lock the vqs one by one")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/vhost/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5f81a66d34..1cbb17f898f7 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -944,10 +944,10 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
 		if (msg->iova <= vq_msg->iova &&
 		    msg->iova + msg->size - 1 >= vq_msg->iova &&
 		    vq_msg->type == VHOST_IOTLB_MISS) {
-			mutex_lock(&node->vq->mutex);
+			/* Safe to call outside vq->mutex as long as dev->mutex
+			 * is held.
+			 */
 			vhost_poll_queue(&node->vq->poll);
-			mutex_unlock(&node->vq->mutex);
-
 			list_del(&node->node);
 			kfree(node);
 		}
-- 
2.19.1
