From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V2 4/4] vhost: log dirty page correctly
Date: Wed, 12 Dec 2018 18:08:19 +0800
Message-ID: <20181212100819.21295-5-jasowang__5145.28520075164$1544609493$gmane$org@redhat.com>
References: <20181212100819.21295-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212100819.21295-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jintack Lim <jintack@cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

Vhost dirty page logging API is designed to sync through GPA. But we
try to log GIOVA when device IOTLB is enabled. This is wrong and may
lead to missing data after migration.

To solve this issue, when logging with device IOTLB enabled, we will:

1) reuse the device IOTLB translation result of GIOVA->HVA mapping to
   get HVA, for writable descriptor, get HVA through iovec. For used
   ring update, translate its GIOVA to HVA
2) traverse the GPA->HVA mapping to get the possible GPA and log
   through GPA. Pay attention this reverse mapping is not guaranteed
   to be unique, so we should log each possible GPA in this case.

This fix the failure of scp to guest during migration. In -next, we
will probably support passing GIOVA->GPA instead of GIOVA->HVA.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Reported-by: Jintack Lim <jintack@cs.columbia.edu>
Cc: Jintack Lim <jintack@cs.columbia.edu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   |  3 +-
 drivers/vhost/vhost.c | 79 +++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.h |  3 +-
 3 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ad7a6f475a44..784df2b49628 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1192,7 +1192,8 @@ static void handle_rx(struct vhost_net *net)
 		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
 		if (unlikely(vq_log))
-			vhost_log_write(vq, vq_log, log, vhost_len);
+			vhost_log_write(vq, vq_log, log, vhost_len,
+					vq->iov, in);
 		total_len += vhost_len;
 		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
 			vhost_poll_queue(&vq->poll);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 55e5aa662ad5..3660310604fd 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1733,11 +1733,67 @@ static int log_write(void __user *log_base,
 	return r;
 }
 
+static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
+{
+	struct vhost_umem *umem = vq->umem;
+	struct vhost_umem_node *u;
+	u64 gpa;
+	int r;
+	bool hit = false;
+
+	list_for_each_entry(u, &umem->umem_list, link) {
+		if (u->userspace_addr < hva &&
+		    u->userspace_addr + u->size >=
+		    hva + len) {
+			gpa = u->start + hva - u->userspace_addr;
+			r = log_write(vq->log_base, gpa, len);
+			if (r < 0)
+				return r;
+			hit = true;
+		}
+	}
+
+	/* No reverse mapping, should be a bug */
+	WARN_ON(!hit);
+	return 0;
+}
+
+static void log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
+{
+	struct iovec iov[64];
+	int i, ret;
+
+	if (!vq->iotlb) {
+		log_write(vq->log_base, vq->log_addr + used_offset, len);
+		return;
+	}
+
+	ret = translate_desc(vq, (u64)(uintptr_t)vq->used + used_offset,
+			     len, iov, 64, VHOST_ACCESS_WO);
+	WARN_ON(ret < 0);
+
+	for (i = 0; i < ret; i++) {
+		ret = log_write_hva(vq,	(u64)(uintptr_t)iov[i].iov_base,
+				    iov[i].iov_len);
+		WARN_ON(ret);
+	}
+}
+
 int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
-		    unsigned int log_num, u64 len)
+		    unsigned int log_num, u64 len, struct iovec *iov, int count)
 {
 	int i, r;
 
+	if (vq->iotlb) {
+		for (i = 0; i < count; i++) {
+			r = log_write_hva(vq, (u64)(uintptr_t)iov[i].iov_base,
+					  iov[i].iov_len);
+			if (r < 0)
+				return r;
+		}
+		return 0;
+	}
+
 	/* Make sure data written is seen before log. */
 	smp_wmb();
 	for (i = 0; i < log_num; ++i) {
@@ -1769,9 +1825,8 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 		smp_wmb();
 		/* Log used flag write. */
 		used = &vq->used->flags;
-		log_write(vq->log_base, vq->log_addr +
-			  (used - (void __user *)vq->used),
-			  sizeof vq->used->flags);
+		log_used(vq, (used - (void __user *)vq->used),
+			 sizeof vq->used->flags);
 		if (vq->log_ctx)
 			eventfd_signal(vq->log_ctx, 1);
 	}
@@ -1789,9 +1844,8 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 		smp_wmb();
 		/* Log avail event write */
 		used = vhost_avail_event(vq);
-		log_write(vq->log_base, vq->log_addr +
-			  (used - (void __user *)vq->used),
-			  sizeof *vhost_avail_event(vq));
+		log_used(vq, (used - (void __user *)vq->used),
+			 sizeof *vhost_avail_event(vq));
 		if (vq->log_ctx)
 			eventfd_signal(vq->log_ctx, 1);
 	}
@@ -2191,10 +2245,8 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 		/* Make sure data is seen before log. */
 		smp_wmb();
 		/* Log used ring entry write. */
-		log_write(vq->log_base,
-			  vq->log_addr +
-			   ((void __user *)used - (void __user *)vq->used),
-			  count * sizeof *used);
+		log_used(vq, ((void __user *)used - (void __user *)vq->used),
+			 count * sizeof *used);
 	}
 	old = vq->last_used_idx;
 	new = (vq->last_used_idx += count);
@@ -2236,9 +2288,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 		/* Make sure used idx is seen before log. */
 		smp_wmb();
 		/* Log used index update. */
-		log_write(vq->log_base,
-			  vq->log_addr + offsetof(struct vring_used, idx),
-			  sizeof vq->used->idx);
+		log_used(vq, offsetof(struct vring_used, idx),
+			 sizeof vq->used->idx);
 		if (vq->log_ctx)
 			eventfd_signal(vq->log_ctx, 1);
 	}
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 466ef7542291..1b675dad5e05 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -205,7 +205,8 @@ bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
 bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
 
 int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
-		    unsigned int log_num, u64 len);
+		    unsigned int log_num, u64 len,
+		    struct iovec *iov, int count);
 int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
 
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);
-- 
2.17.1
