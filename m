From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next] vsock/virtio: a better comment on credit update
Date: Tue, 3 Sep 2019 03:38:16 -0400
Message-ID: <20190903073748.25214-1-mst__24128.8648032182$1567496312$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The comment we have is just repeating what the code does.
Include the *reason* for the condition instead.

Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 94cc0fa3e848..5bb70c692b1e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -307,8 +307,13 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 
 	spin_unlock_bh(&vvs->rx_lock);
 
-	/* We send a credit update only when the space available seen
-	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
+	/* To reduce the number of credit update messages,
+	 * don't update credits as long as lots of space is available.
+	 * Note: the limit chosen here is arbitrary. Setting the limit
+	 * too high causes extra messages. Too low causes transmitter
+	 * stalls. As stalls are in theory more expensive than extra
+	 * messages, we set the limit to a high value. TODO: experiment
+	 * with different values.
 	 */
 	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
 		virtio_transport_send_credit_update(vsk,
-- 
MST
