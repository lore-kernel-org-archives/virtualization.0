From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 14/14] vhost: drop head based APIs
Date: Wed, 10 Jun 2020 07:36:33 -0400
Message-ID: <20200610113515.1497099-15-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Everyone's using buf APIs, no need for head based ones anymore.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 64 ++++++-------------------------------------
 drivers/vhost/vhost.h | 12 --------
 2 files changed, 8 insertions(+), 68 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 03e6bca02288..9096bd291c91 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2425,39 +2425,11 @@ EXPORT_SYMBOL_GPL(vhost_get_avail_buf);
 void vhost_discard_avail_bufs(struct vhost_virtqueue *vq,
 			      struct vhost_buf *buf, unsigned count)
 {
-	vhost_discard_vq_desc(vq, count);
+	unfetch_descs(vq);
+	vq->last_avail_idx -= count;
 }
 EXPORT_SYMBOL_GPL(vhost_discard_avail_bufs);
 
-/* This function returns the descriptor number found, or vq->num (which is
- * never a valid descriptor number) if none was found.  A negative code is
- * returned on error. */
-int vhost_get_vq_desc(struct vhost_virtqueue *vq,
-		      struct iovec iov[], unsigned int iov_size,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num)
-{
-	struct vhost_buf buf;
-	int ret = vhost_get_avail_buf(vq, &buf,
-				      iov, iov_size, out_num, in_num,
-				      log, log_num);
-
-	if (likely(ret > 0))
-		return buf->id;
-	if (likely(!ret))
-		return vq->num;
-	return ret;
-}
-EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
-
-/* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
-void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
-{
-	unfetch_descs(vq);
-	vq->last_avail_idx -= n;
-}
-EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
-
 static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 			    struct vring_used_elem *heads,
 			    unsigned count)
@@ -2490,8 +2462,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 	return 0;
 }
 
-/* After we've used one of their buffers, we tell them about it.  We'll then
- * want to notify the guest, using eventfd. */
+static
 int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 		     unsigned count)
 {
@@ -2525,10 +2496,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	}
 	return r;
 }
-EXPORT_SYMBOL_GPL(vhost_add_used_n);
 
-/* After we've used one of their buffers, we tell them about it.  We'll then
- * want to notify the guest, using eventfd. */
+static
 int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
 {
 	struct vring_used_elem heads = {
@@ -2538,14 +2507,17 @@ int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
 
 	return vhost_add_used_n(vq, &heads, 1);
 }
-EXPORT_SYMBOL_GPL(vhost_add_used);
 
+/* After we've used one of their buffers, we tell them about it.  We'll then
+ * want to notify the guest, using vhost_signal. */
 int vhost_put_used_buf(struct vhost_virtqueue *vq, struct vhost_buf *buf)
 {
 	return vhost_add_used(vq, buf->id, buf->in_len);
 }
 EXPORT_SYMBOL_GPL(vhost_put_used_buf);
 
+/* After we've used one of their buffers, we tell them about it.  We'll then
+ * want to notify the guest, using vhost_signal. */
 int vhost_put_used_n_bufs(struct vhost_virtqueue *vq,
 			  struct vhost_buf *bufs, unsigned count)
 {
@@ -2606,26 +2578,6 @@ void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(vhost_signal);
 
-/* And here's the combo meal deal.  Supersize me! */
-void vhost_add_used_and_signal(struct vhost_dev *dev,
-			       struct vhost_virtqueue *vq,
-			       unsigned int head, int len)
-{
-	vhost_add_used(vq, head, len);
-	vhost_signal(dev, vq);
-}
-EXPORT_SYMBOL_GPL(vhost_add_used_and_signal);
-
-/* multi-buffer version of vhost_add_used_and_signal */
-void vhost_add_used_and_signal_n(struct vhost_dev *dev,
-				 struct vhost_virtqueue *vq,
-				 struct vring_used_elem *heads, unsigned count)
-{
-	vhost_add_used_n(vq, heads, count);
-	vhost_signal(dev, vq);
-}
-EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
-
 /* return true if we're sure that avaiable ring is empty */
 bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 28eea0155efb..264a2a2fae97 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -197,11 +197,6 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
 bool vhost_log_access_ok(struct vhost_dev *);
 
-int vhost_get_vq_desc(struct vhost_virtqueue *,
-		      struct iovec iov[], unsigned int iov_count,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num);
-void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 int vhost_get_avail_buf(struct vhost_virtqueue *, struct vhost_buf *buf,
 			struct iovec iov[], unsigned int iov_count,
 			unsigned int *out_num, unsigned int *in_num,
@@ -209,13 +204,6 @@ int vhost_get_avail_buf(struct vhost_virtqueue *, struct vhost_buf *buf,
 void vhost_discard_avail_bufs(struct vhost_virtqueue *,
 			      struct vhost_buf *, unsigned count);
 int vhost_vq_init_access(struct vhost_virtqueue *);
-int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
-int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
-		     unsigned count);
-void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
-			       unsigned int id, int len);
-void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
-			       struct vring_used_elem *heads, unsigned count);
 int vhost_put_used_buf(struct vhost_virtqueue *, struct vhost_buf *buf);
 int vhost_put_used_n_bufs(struct vhost_virtqueue *,
 			  struct vhost_buf *bufs, unsigned count);
-- 
MST
