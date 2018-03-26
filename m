From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH V2 4/8] vhost_net: do not explicitly manipulate
	vhost_used_elem
Date: Mon, 26 Mar 2018 11:38:49 +0800
Message-ID: <1522035533-11786-5-git-send-email-jasowang__16837.24378604$1522035494$gmane$org@redhat.com>
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Two helpers of setting/getting used len were introduced to avoid
explicitly manipulating vhost_used_elem in zerocopy code. This will be
used to hide used_elem internals and simplify packed ring
implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 11 +++++------
 drivers/vhost/vhost.c | 12 ++++++++++--
 drivers/vhost/vhost.h |  5 +++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7ea2aee..7be8b55 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -337,9 +337,10 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 	int j = 0;
 
 	for (i = nvq->done_idx; i != nvq->upend_idx; i = (i + 1) % UIO_MAXIOV) {
-		if (vq->heads[i].elem.len == VHOST_DMA_FAILED_LEN)
+		if (vhost_get_used_len(vq, &vq->heads[i]) ==
+		    VHOST_DMA_FAILED_LEN)
 			vhost_net_tx_err(net);
-		if (VHOST_DMA_IS_DONE(vq->heads[i].elem.len)) {
+		if (VHOST_DMA_IS_DONE(vhost_get_used_len(vq, &vq->heads[i]))) {
 			vq->heads[i].elem.len = VHOST_DMA_CLEAR_LEN;
 			++j;
 		} else
@@ -537,10 +538,8 @@ static void handle_tx(struct vhost_net *net)
 			struct ubuf_info *ubuf;
 			ubuf = nvq->ubuf_info + nvq->upend_idx;
 
-			vq->heads[nvq->upend_idx].elem.id =
-				cpu_to_vhost32(vq, used.elem.id);
-			vq->heads[nvq->upend_idx].elem.len =
-				VHOST_DMA_IN_PROGRESS;
+			vhost_set_used_len(vq, &used, VHOST_DMA_IN_PROGRESS);
+			vq->heads[nvq->upend_idx] = used;
 			ubuf->callback = vhost_zerocopy_callback;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8744dae..65954d6 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2100,11 +2100,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
-static void vhost_set_used_len(struct vhost_virtqueue *vq,
-			       struct vhost_used_elem *used, int len)
+void vhost_set_used_len(struct vhost_virtqueue *vq,
+			struct vhost_used_elem *used, int len)
 {
 	used->elem.len = cpu_to_vhost32(vq, len);
 }
+EXPORT_SYMBOL_GPL(vhost_set_used_len);
+
+int vhost_get_used_len(struct vhost_virtqueue *vq,
+		       struct vhost_used_elem *used)
+{
+	return vhost32_to_cpu(vq, used->elem.len);
+}
+EXPORT_SYMBOL_GPL(vhost_get_used_len);
 
 /* This is a multi-buffer version of vhost_get_desc, that works if
  *	vq has read descriptors only.
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 8399887..d57c875 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -198,6 +198,11 @@ int vhost_get_bufs(struct vhost_virtqueue *vq,
 		   unsigned *log_num,
 		   unsigned int quota,
 		   s16 *count);
+void vhost_set_used_len(struct vhost_virtqueue *vq,
+			struct vhost_used_elem *used,
+			int len);
+int vhost_get_used_len(struct vhost_virtqueue *vq,
+		       struct vhost_used_elem *used);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
 int vhost_vq_init_access(struct vhost_virtqueue *);
-- 
2.7.4
