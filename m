From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v4 2/4] net: vhost: replace magic number of lock
	annotation
Date: Mon,  2 Jul 2018 05:57:06 -0700
Message-ID: <1530536228-17462-3-git-send-email-xiangxia.m.yue__36886.7773715921$1530536209$gmane$org@gmail.com>
References: <1530536228-17462-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1530536228-17462-1-git-send-email-xiangxia.m.yue@gmail.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Tonghao Zhang <zhangtonghao@didichuxing.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Use the VHOST_NET_VQ_XXX as a subclass for mutex_lock_nested.

Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index e7cf7d2..62bb8e8 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -484,7 +484,7 @@ static void handle_tx(struct vhost_net *net)
 	bool zcopy, zcopy_used;
 	int sent_pkts = 0;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
@@ -655,7 +655,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
 		/* Flush batched heads first */
 		vhost_rx_signal_used(rvq);
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&vq->mutex, 1);
+		mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
 		vhost_disable_notify(&net->dev, vq);
 
 		preempt_disable();
@@ -789,7 +789,7 @@ static void handle_rx(struct vhost_net *net)
 	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
-	mutex_lock_nested(&vq->mutex, 0);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
-- 
1.8.3.1
