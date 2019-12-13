From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 1/2] vsock/virtio: fix null-pointer dereference in
 virtio_transport_recv_listen()
Date: Fri, 13 Dec 2019 19:48:00 +0100
Message-ID: <20191213184801.486675-2-sgarzare__20948.8544658356$1576262907$gmane$org@redhat.com>
References: <20191213184801.486675-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191213184801.486675-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: davem@davemloft.net
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

With multi-transport support, listener sockets are not bound to any
transport. So, calling virtio_transport_reset(), when an error
occurs, on a listener socket produces the following null-pointer
dereference:

  BUG: kernel NULL pointer dereference, address: 00000000000000e8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 0 PID: 20 Comm: kworker/0:1 Not tainted 5.5.0-rc1-ste-00003-gb4be21f316ac-dirty #56
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
  Workqueue: virtio_vsock virtio_transport_rx_work [vmw_vsock_virtio_transport]
  RIP: 0010:virtio_transport_send_pkt_info+0x20/0x130 [vmw_vsock_virtio_transport_common]
  Code: 1f 84 00 00 00 00 00 0f 1f 00 55 48 89 e5 41 57 41 56 41 55 49 89 f5 41 54 49 89 fc 53 48 83 ec 10 44 8b 76 20 e8 c0 ba fe ff <48> 8b 80 e8 00 00 00 e8 64 e3 7d c1 45 8b 45 00 41 8b 8c 24 d4 02
  RSP: 0018:ffffc900000b7d08 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: ffff88807bf12728 RCX: 0000000000000000
  RDX: ffff88807bf12700 RSI: ffffc900000b7d50 RDI: ffff888035c84000
  RBP: ffffc900000b7d40 R08: ffff888035c84000 R09: ffffc900000b7d08
  R10: ffff8880781de800 R11: 0000000000000018 R12: ffff888035c84000
  R13: ffffc900000b7d50 R14: 0000000000000000 R15: ffff88807bf12724
  FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000000000e8 CR3: 00000000790f4004 CR4: 0000000000160ef0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   virtio_transport_reset+0x59/0x70 [vmw_vsock_virtio_transport_common]
   virtio_transport_recv_pkt+0x5bb/0xe50 [vmw_vsock_virtio_transport_common]
   ? detach_buf_split+0xf1/0x130
   virtio_transport_rx_work+0xba/0x130 [vmw_vsock_virtio_transport]
   process_one_work+0x1c0/0x300
   worker_thread+0x45/0x3c0
   kthread+0xfc/0x130
   ? current_work+0x40/0x40
   ? kthread_park+0x90/0x90
   ret_from_fork+0x35/0x40
  Modules linked in: sunrpc kvm_intel kvm vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common irqbypass vsock virtio_rng rng_core
  CR2: 00000000000000e8
  ---[ end trace e75400e2ea2fa824 ]---

This happens because virtio_transport_reset() calls
virtio_transport_send_pkt_info() that can be used only on
connecting/connected sockets.

This patch fixes the issue, using virtio_transport_reset_no_sock()
instead of virtio_transport_reset() when we are handling a listener
socket.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e5ea29c6bca7..f5991006190e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1021,18 +1021,18 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 	int ret;
 
 	if (le16_to_cpu(pkt->hdr.op) != VIRTIO_VSOCK_OP_REQUEST) {
-		virtio_transport_reset(vsk, pkt);
+		virtio_transport_reset_no_sock(t, pkt);
 		return -EINVAL;
 	}
 
 	if (sk_acceptq_is_full(sk)) {
-		virtio_transport_reset(vsk, pkt);
+		virtio_transport_reset_no_sock(t, pkt);
 		return -ENOMEM;
 	}
 
 	child = vsock_create_connected(sk);
 	if (!child) {
-		virtio_transport_reset(vsk, pkt);
+		virtio_transport_reset_no_sock(t, pkt);
 		return -ENOMEM;
 	}
 
@@ -1054,7 +1054,7 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
-		virtio_transport_reset(vsk, pkt);
+		virtio_transport_reset_no_sock(t, pkt);
 		sock_put(child);
 		return ret;
 	}
-- 
2.23.0
