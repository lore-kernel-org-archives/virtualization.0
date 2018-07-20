From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 5/9] vhost_net: introduce tx_can_batch()
Date: Fri, 20 Jul 2018 08:15:17 +0800
Message-ID: <1532045721-4958-6-git-send-email-jasowang__48760.625269688$1532045901$gmane$org@redhat.com>
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

Introduce tx_can_batch() to determine whether TX could be
batched. This will help to reduce the code duplication in the future.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index a014ca0..f59b615 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -514,6 +514,12 @@ static int get_tx_bufs(struct vhost_net *net,
 	return ret;
 }
 
+static bool tx_can_batch(struct vhost_virtqueue *vq, size_t total_len)
+{
+	return total_len < VHOST_NET_WEIGHT &&
+	       !vhost_vq_avail_empty(vq->dev, vq);
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -598,8 +604,7 @@ static void handle_tx(struct vhost_net *net)
 			ubufs = NULL;
 		}
 		total_len += len;
-		if (total_len < VHOST_NET_WEIGHT &&
-		    !vhost_vq_avail_empty(&net->dev, vq) &&
+		if (tx_can_batch(vq, total_len) &&
 		    likely(!vhost_exceeds_maxpend(net))) {
 			msg.msg_flags |= MSG_MORE;
 		} else {
-- 
2.7.4
