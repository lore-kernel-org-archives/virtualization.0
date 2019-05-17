From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3] vsock/virtio: free packets during the socket release
Date: Fri, 17 May 2019 16:45:43 +0200
Message-ID: <20190517144543.362935-1-sgarzare__26082.7542095043$1558104390$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

When the socket is released, we should free all packets
queued in the per-socket list in order to avoid a memory
leak.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
This patch was in the series "[PATCH v2 0/8] vsock/virtio: optimizations
to increase the throughput" [1]. As Stefan suggested, I'm sending it as
a separated patch.

v3:
  - use list_for_each_entry_safe() [David]

[1] https://patchwork.kernel.org/cover/10938743/
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 602715fc9a75..f3f3d06cb6d8 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -786,12 +786,19 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
 
 void virtio_transport_release(struct vsock_sock *vsk)
 {
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	struct virtio_vsock_pkt *pkt, *tmp;
 	struct sock *sk = &vsk->sk;
 	bool remove_sock = true;
 
 	lock_sock(sk);
 	if (sk->sk_type == SOCK_STREAM)
 		remove_sock = virtio_transport_close(vsk);
+
+	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
+		list_del(&pkt->list);
+		virtio_transport_free_pkt(pkt);
+	}
 	release_sock(sk);
 
 	if (remove_sock)
-- 
2.20.1
