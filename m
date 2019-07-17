From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 5/5] vsock/virtio: change the maximum packet size allowed
Date: Wed, 17 Jul 2019 13:30:30 +0200
Message-ID: <20190717113030.163499-6-sgarzare__6218.27129959769$1563363109$gmane$org@redhat.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717113030.163499-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Since now we are able to split packets, we can avoid limiting
their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
packet size.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 56fab3f03d0e..94cc0fa3e848 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -181,8 +181,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	vvs = vsk->trans;
 
 	/* we can send less than pkt_len bytes */
-	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
-		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
+		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 
 	/* virtio_transport_get_credit might return less than pkt_len credit */
 	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
-- 
2.20.1
