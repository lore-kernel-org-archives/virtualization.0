From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost: reset metadata cache when initializing new IOTLB
Date: Wed,  8 Aug 2018 11:43:04 +0800
Message-ID: <1533699784-4950-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We need to reset metadata cache during new IOTLB initialization,
otherwise the stale pointers to previous IOTLB may be still accessed
which will lead a use after free.

Reported-by: syzbot+c51e6736a1bf614b3272@syzkaller.appspotmail.com
Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a502f1a..ed31145 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1560,9 +1560,12 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
 	d->iotlb = niotlb;
 
 	for (i = 0; i < d->nvqs; ++i) {
-		mutex_lock(&d->vqs[i]->mutex);
-		d->vqs[i]->iotlb = niotlb;
-		mutex_unlock(&d->vqs[i]->mutex);
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = niotlb;
+		__vhost_vq_meta_reset(vq);
+		mutex_unlock(&vq->mutex);
 	}
 
 	vhost_umem_clean(oiotlb);
-- 
2.7.4
