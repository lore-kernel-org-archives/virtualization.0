From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 2/9] vhost_net: introduce helper to initialize tx iov
	iter
Date: Fri, 20 Jul 2018 08:15:14 +0800
Message-ID: <1532045721-4958-3-git-send-email-jasowang__28598.665566142$1532045676$gmane$org@redhat.com>
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

Introduce init_iov_iter() in order to be reused by future patch.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 1a8175a..cac28fd 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -466,6 +466,18 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
 	       min_t(unsigned int, VHOST_MAX_PEND, vq->num >> 2);
 }
 
+static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
+			    size_t hdr_size, int out)
+{
+	/* Skip header. TODO: support TSO. */
+	size_t len = iov_length(vq->iov, out);
+
+	iov_iter_init(iter, WRITE, vq->iov, out, len);
+	iov_iter_advance(iter, hdr_size);
+
+	return iov_iter_count(iter);
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -531,18 +543,14 @@ static void handle_tx(struct vhost_net *net)
 			       "out %d, int %d\n", out, in);
 			break;
 		}
-		/* Skip header. TODO: support TSO. */
-		len = iov_length(vq->iov, out);
-		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
-		iov_iter_advance(&msg.msg_iter, hdr_size);
+
 		/* Sanity check */
-		if (!msg_data_left(&msg)) {
-			vq_err(vq, "Unexpected header len for TX: "
-			       "%zd expected %zd\n",
-			       len, hdr_size);
+		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
+		if (!len) {
+			vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
+			len, hdr_size);
 			break;
 		}
-		len = msg_data_left(&msg);
 
 		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
 				   && !vhost_exceeds_maxpend(net)
-- 
2.7.4
