From: xiangxia.m.yue@gmail.com
Subject: [REBASE PATCH net-next v9 2/4] net: vhost: replace magic number of
	lock annotation
Date: Tue, 25 Sep 2018 05:36:50 -0700
Message-ID: <1537879012-20859-3-git-send-email-xiangxia.m.yue__4639.35184893689$1537878932$gmane$org@gmail.com>
References: <1537879012-20859-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1537879012-20859-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp, davem@davemloft.net
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Use the VHOST_NET_VQ_XXX as a subclass for mutex_lock_nested.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 1bff6bc..5fe57ab 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -856,7 +856,7 @@ static void handle_tx(struct vhost_net *net)
 	struct vhost_virtqueue *vq = &nvq->vq;
 	struct socket *sock;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
@@ -921,7 +921,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 		/* Flush batched heads first */
 		vhost_net_signal_used(rnvq);
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&tvq->mutex, 1);
+		mutex_lock_nested(&tvq->mutex, VHOST_NET_VQ_TX);
 		vhost_disable_notify(&net->dev, tvq);
 
 		preempt_disable();
@@ -1063,7 +1063,7 @@ static void handle_rx(struct vhost_net *net)
 	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
-	mutex_lock_nested(&vq->mutex, 0);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
-- 
1.8.3.1
