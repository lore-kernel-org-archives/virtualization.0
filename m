From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] virtio_ring: fix delayed enable cb implementation
Date: Thu, 19 May 2011 20:12:47 +0300
Message-ID: <20110519171246.GA8650__32540.0994196118$1305825314$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: rusty@rustcorp.com.au, habanero@linux.vnet.ibm.com, Shirley Ma <mashirle@us.ibm.com>, Krishna Kumar2 <krkumar2@in.ibm.com>, kvm@vger.kernel.org, steved@us.ibm.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Fix some signed/assigned mistakes in virtqueue_enable_cb_delayed
by using u16 math all over.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

I'll put this on my v1 branch as well

@@ -398,7 +397,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
 bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	int bufs;
+	u16 bufs;
 
 	START_USE(vq);
 
@@ -412,7 +411,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	bufs = (vq->vring.avail->idx - vq->last_used_idx) * 3 / 4;
 	vring_used_event(&vq->vring) = vq->last_used_idx + bufs;
 	virtio_mb();
-	if (unlikely(vq->vring.used->idx - vq->last_used_idx > bufs)) {
+	if (unlikely((u16)(vq->vring.used->idx - vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
 	}
 
-- 
1.7.5.53.gc233e
