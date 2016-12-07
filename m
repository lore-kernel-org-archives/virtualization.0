From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH v2 3/4] vsock: add pkt cancel capability
Date: Wed,  7 Dec 2016 23:14:11 +0800
Message-ID: <1481123652-80603-4-git-send-email-bergwolf__45946.2277278819$1481136772$gmane$org@gmail.com>
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

Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 936d7ee..a5f3833 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -170,6 +170,47 @@ virtio_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 	return len;
 }
 
+static int
+virtio_transport_cancel_pkt(struct vsock_sock *vsk)
+{
+	struct virtio_vsock *vsock;
+	struct virtio_vsock_pkt *pkt, *n;
+	int cnt = 0;
+	LIST_HEAD(freeme);
+
+	vsock = virtio_vsock_get();
+	if (!vsock) {
+		return -ENODEV;
+	}
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
+		struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
+		int new_cnt;
+
+		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
+		if (new_cnt + cnt >= virtqueue_get_vring_size(rx_vq) &&
+		    new_cnt < virtqueue_get_vring_size(rx_vq))
+			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
+	}
+
+	return 0;
+}
+
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
 	int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
@@ -453,6 +494,7 @@ static struct virtio_transport virtio_transport = {
 	},
 
 	.send_pkt = virtio_transport_send_pkt,
+	.cancel_pkt = virtio_transport_cancel_pkt,
 };
 
 static int virtio_vsock_probe(struct virtio_device *vdev)
-- 
2.7.4
