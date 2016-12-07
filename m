From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH v2 2/4] vhost-vsock: add pkt cancel capability
Date: Wed,  7 Dec 2016 23:14:10 +0800
Message-ID: <1481123652-80603-3-git-send-email-bergwolf__7585.55567958883$1481136757$gmane$org@gmail.com>
References: <1481123652-80603-1-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481123652-80603-1-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, Peng Tao <bergwolf@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

To allow canceling all packets of a connection.

Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
 drivers/vhost/vsock.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_vsock.h |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a504e2e0..d01e4a4 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -218,6 +218,46 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 	return len;
 }
 
+static int
+vhost_transport_cancel_pkt(struct vsock_sock *vsk)
+{
+	struct vhost_vsock *vsock;
+	struct virtio_vsock_pkt *pkt, *n;
+	int cnt = 0;
+	LIST_HEAD(freeme);
+
+	/* Find the vhost_vsock according to guest context id  */
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	if (!vsock)
+		return -ENODEV;
+
+	spin_lock_bh(&vsock->send_pkt_list_lock);
+	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
+		if (pkt->vsk != vsk)
+			continue;
+		list_move(&pkt->list, &freeme);
+	}
+	spin_unlock_bh(&vsock->send_pkt_list_lock);
+
+	list_for_each_entry_safe(pkt, n, &freeme, list) {
+		if (pkt->reply)
+			cnt++;
+		list_del(&pkt->list);
+		virtio_transport_free_pkt(pkt);
+	}
+
+	if (cnt) {
+		struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
+		int new_cnt;
+
+		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
+		if (new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
+			vhost_poll_queue(&tx_vq->poll);
+	}
+
+	return 0;
+}
+
 static struct virtio_vsock_pkt *
 vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
@@ -698,6 +738,7 @@ static struct virtio_transport vhost_transport = {
 	},
 
 	.send_pkt = vhost_transport_send_pkt,
+	.cancel_pkt = vhost_transport_cancel_pkt,
 };
 
 static int __init vhost_vsock_init(void)
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 6dd3242..b92e88d 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -72,6 +72,9 @@ struct virtio_transport {
 
 	/* Takes ownership of the packet */
 	int (*send_pkt)(struct virtio_vsock_pkt *pkt);
+
+	/* Cancel packets belonging the same vsock */
+	int (*cancel_pkt)(struct vsock_sock *vsk);
 };
 
 ssize_t
-- 
2.7.4
