From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2 3/3] vhost: don't touch avail ring if in_order is
	negotiated
Date: Wed,  9 Jan 2019 16:05:30 +0800
Message-ID: <20190109080530.18572-4-jasowang__35589.5842229531$1547021057$gmane$org@redhat.com>
References: <20190109080530.18572-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190109080530.18572-1-jasowang@redhat.com>
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

Device use descriptors table in order, so there's no need to read
index from available ring. This eliminate the cache contention on
available ring completely.

Virito-user + vhost_kernel + XDP_DROP on 2.60GHz Broadwell

            Before /After
SMAP on:  4.8Mpps   5.3Mpps(+10%)
SMAP off: 6.6Mpps   7.0Mpps(+6%)

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 55e5aa662ad5..ab0d05262235 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2012,6 +2012,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	__virtio16 avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
+	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
 
 	/* Check it isn't doing very strange things with descriptor numbers. */
 	last_avail_idx = vq->last_avail_idx;
@@ -2044,15 +2045,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
 	/* Grab the next descriptor number they're advertising, and increment
 	 * the index we've seen. */
-	if (unlikely(vhost_get_avail(vq, ring_head,
-		     &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
-		vq_err(vq, "Failed to read head: idx %d address %p\n",
-		       last_avail_idx,
-		       &vq->avail->ring[last_avail_idx % vq->num]);
-		return -EFAULT;
+	if (!in_order) {
+		if (unlikely(vhost_get_avail(vq, ring_head,
+		    &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
+			vq_err(vq, "Failed to read head: idx %d address %p\n",
+				last_avail_idx,
+				&vq->avail->ring[last_avail_idx % vq->num]);
+			return -EFAULT;
+		}
+		head = vhost16_to_cpu(vq, ring_head);
+	} else {
+		head = last_avail_idx & (vq->num - 1);
 	}
 
-	head = vhost16_to_cpu(vq, ring_head);
 
 	/* If their number is silly, that's an error. */
 	if (unlikely(head >= vq->num)) {
-- 
2.17.1
