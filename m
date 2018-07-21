From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v6 2/4] net: vhost: replace magic number of lock
	annotation
Date: Sat, 21 Jul 2018 11:04:00 -0700
Message-ID: <1532196242-2998-3-git-send-email-xiangxia.m.yue__6367.36224773831$1532196310$gmane$org@gmail.com>
References: <1532196242-2998-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532196242-2998-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Use the VHOST_NET_VQ_XXX as a subclass for mutex_lock_nested.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b224036..321264c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -490,7 +490,7 @@ static void handle_tx(struct vhost_net *net)
 	bool zcopy, zcopy_used;
 	int sent_pkts = 0;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
@@ -667,7 +667,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 		/* Flush batched heads first */
 		vhost_rx_signal_used(rnvq);
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&tvq->mutex, 1);
+		mutex_lock_nested(&tvq->mutex, VHOST_NET_VQ_TX);
 		vhost_disable_notify(&net->dev, tvq);
 
 		preempt_disable();
@@ -809,7 +809,7 @@ static void handle_rx(struct vhost_net *net)
 	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
-	mutex_lock_nested(&vq->mutex, 0);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
-- 
1.8.3.1
