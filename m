From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vsock/virtio: fix sock refcnt holding during the shutdown
Date: Fri,  8 Nov 2019 17:08:50 +0100
Message-ID: <20191108160850.51278-1-sgarzare__45137.2024997667$1573229351$gmane$org@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

The "42f5cda5eaf4" commit rightly set SOCK_DONE on peer shutdown,
but there is an issue if we receive the SHUTDOWN(RDWR) while the
virtio_transport_close_timeout() is scheduled.
In this case, when the timeout fires, the SOCK_DONE is already
set and the virtio_transport_close_timeout() will not call
virtio_transport_reset() and virtio_transport_do_close().
This causes that both sockets remain open and will never be released,
preventing the unloading of [virtio|vhost]_transport modules.

This patch fixes this issue, calling virtio_transport_reset() and
virtio_transport_do_close() when we receive the SHUTDOWN(RDWR)
and there is nothing left to read.

Fixes: 42f5cda5eaf4 ("vsock/virtio: set SOCK_DONE on peer shutdown")
Cc: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 481f7f8a1655..fb2060dffb0a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -947,9 +947,11 @@ virtio_transport_recv_connected(struct sock *sk,
 		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
 			vsk->peer_shutdown |= SEND_SHUTDOWN;
 		if (vsk->peer_shutdown == SHUTDOWN_MASK &&
-		    vsock_stream_has_data(vsk) <= 0) {
-			sock_set_flag(sk, SOCK_DONE);
-			sk->sk_state = TCP_CLOSING;
+		    vsock_stream_has_data(vsk) <= 0 &&
+		    !sock_flag(sk, SOCK_DONE)) {
+			(void)virtio_transport_reset(vsk, NULL);
+
+			virtio_transport_do_close(vsk, true);
 		}
 		if (le32_to_cpu(pkt->hdr.flags))
 			sk->sk_state_change(sk);
-- 
2.21.0
