From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v7 2/4] net: vhost: replace magic number of lock
	annotation
Date: Tue, 31 Jul 2018 20:00:52 -0700
Message-ID: <1533092454-37196-3-git-send-email-xiangxia.m.yue__112.69998872212$1533092367$gmane$org@gmail.com>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
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
index 367d802..32c1b52 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -712,7 +712,7 @@ static void handle_tx(struct vhost_net *net)
 	struct vhost_virtqueue *vq = &nvq->vq;
 	struct socket *sock;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
@@ -777,7 +777,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 		/* Flush batched heads first */
 		vhost_net_signal_used(rnvq);
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock_nested(&tvq->mutex, 1);
+		mutex_lock_nested(&tvq->mutex, VHOST_NET_VQ_TX);
 		vhost_disable_notify(&net->dev, tvq);
 
 		preempt_disable();
@@ -919,7 +919,7 @@ static void handle_rx(struct vhost_net *net)
 	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
-	mutex_lock_nested(&vq->mutex, 0);
+	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
-- 
1.8.3.1
