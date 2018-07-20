From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 4/9] vhost_net: introduce get_tx_bufs()
Date: Fri, 20 Jul 2018 08:15:16 +0800
Message-ID: <1532045721-4958-5-git-send-email-jasowang__22586.839242331$1532045833$gmane$org@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Factor out logic of getting tx buffer and iov iter
initialization. This will be used for reducing codes duplication in
the future.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9e1674..a014ca0 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -484,6 +484,36 @@ static bool vhost_exceeds_weight(int pkts, int total_len)
 	       pkts >= VHOST_NET_PKT_WEIGHT;
 }
 
+static int get_tx_bufs(struct vhost_net *net,
+		       struct vhost_net_virtqueue *nvq,
+		       struct msghdr *msg,
+		       unsigned int *out, unsigned int *in,
+		       size_t *len, bool *busyloop_intr)
+{
+	struct vhost_virtqueue *vq = &nvq->vq;
+	int ret;
+
+	ret = vhost_net_tx_get_vq_desc(net, vq, out, in, busyloop_intr);
+	if (ret < 0 || ret == vq->num)
+		return ret;
+
+	if (*in) {
+		vq_err(vq, "Unexpected descriptor format for TX: out %d, int %d\n",
+			*out, *in);
+		return -EFAULT;
+	}
+
+	/* Sanity check */
+	*len = init_iov_iter(vq, &msg->msg_iter, nvq->vhost_hlen, *out);
+	if (*len == 0) {
+		vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
+			*len, nvq->vhost_hlen);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -501,7 +531,6 @@ static void handle_tx(struct vhost_net *net)
 	};
 	size_t len, total_len = 0;
 	int err;
-	size_t hdr_size;
 	struct socket *sock;
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy, zcopy_used;
@@ -518,7 +547,6 @@ static void handle_tx(struct vhost_net *net)
 	vhost_disable_notify(&net->dev, vq);
 	vhost_net_disable_vq(net, vq);
 
-	hdr_size = nvq->vhost_hlen;
 	zcopy = nvq->ubufs;
 
 	for (;;) {
@@ -529,8 +557,8 @@ static void handle_tx(struct vhost_net *net)
 			vhost_zerocopy_signal_used(net, vq);
 
 		busyloop_intr = false;
-		head = vhost_net_tx_get_vq_desc(net, vq, &out, &in,
-						&busyloop_intr);
+		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
+				   &busyloop_intr);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
@@ -544,19 +572,6 @@ static void handle_tx(struct vhost_net *net)
 			}
 			break;
 		}
-		if (in) {
-			vq_err(vq, "Unexpected descriptor format for TX: "
-			       "out %d, int %d\n", out, in);
-			break;
-		}
-
-		/* Sanity check */
-		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
-		if (!len) {
-			vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
-			len, hdr_size);
-			break;
-		}
 
 		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
 				   && !vhost_exceeds_maxpend(net)
-- 
2.7.4
