From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH net-next 01/12] vhost_net: introduce helper to initialize
	tx iov iter
Date: Mon, 21 May 2018 17:04:22 +0800
Message-ID: <1526893473-20128-2-git-send-email-jasowang__41713.5851727382$1526893397$gmane$org@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
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

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c4b49fc..15d191a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -459,6 +459,26 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
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
+	/* Sanity check */
+	if (!iov_iter_count(iter)) {
+		vq_err(vq, "Unexpected header len for TX: "
+			"%zd expected %zd\n",
+			len, hdr_size);
+		return -EFAULT;
+	}
+	len = iov_iter_count(iter);
+
+	return len;
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -521,18 +541,10 @@ static void handle_tx(struct vhost_net *net)
 			       "out %d, int %d\n", out, in);
 			break;
 		}
-		/* Skip header. TODO: support TSO. */
-		len = iov_length(vq->iov, out);
-		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
-		iov_iter_advance(&msg.msg_iter, hdr_size);
-		/* Sanity check */
-		if (!msg_data_left(&msg)) {
-			vq_err(vq, "Unexpected header len for TX: "
-			       "%zd expected %zd\n",
-			       len, hdr_size);
+
+		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
+		if (len < 0)
 			break;
-		}
-		len = msg_data_left(&msg);
 
 		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
 				   && !vhost_exceeds_maxpend(net)
-- 
2.7.4
