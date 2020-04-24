From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net v2 2/2] vsock/virtio: fix multiple packet delivery to monitoring devices
Date: Fri, 24 Apr 2020 17:08:30 +0200
Message-ID: <20200424150830.183113-3-sgarzare@redhat.com>
References: <20200424150830.183113-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200424150830.183113-1-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

In virtio_transport.c, if the virtqueue is full, the transmitting
packet is queued up and it will be sent in the next iteration.
This causes the same packet to be delivered multiple times to
monitoring devices.

We want to continue to deliver packets to monitoring devices before
it is put in the virtqueue, to avoid that replies can appear in the
packet capture before the transmitted packet.

This patch fixes the issue, adding a new flag (tap_delivered) in
struct virtio_vsock_pkt, to check if the packet is already delivered
to monitoring devices.

In vhost/vsock.c, we are splitting packets, so we must set
'tap_delivered' to false when we queue up the same virtio_vsock_pkt
to handle the remaining bytes.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c                   | 6 ++++++
 include/linux/virtio_vsock.h            | 1 +
 net/vmw_vsock/virtio_transport_common.c | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 18aff350a405..11f066c76a25 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -196,6 +196,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
 		 * to send it with the next available buffer.
 		 */
 		if (pkt->off < pkt->len) {
+			/* We are queueing the same virtio_vsock_pkt to handle
+			 * the remaining bytes, and we want to deliver it
+			 * to monitoring devices in the next iteration.
+			 */
+			pkt->tap_delivered =3D false;
+
 			spin_lock_bh(&vsock->send_pkt_list_lock);
 			list_add(&pkt->list, &vsock->send_pkt_list);
 			spin_unlock_bh(&vsock->send_pkt_list_lock);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 71c81e0dc8f2..dc636b727179 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -48,6 +48,7 @@ struct virtio_vsock_pkt {
 	u32 len;
 	u32 off;
 	bool reply;
+	bool tap_delivered;
 };
=20
 struct virtio_vsock_pkt_info {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
index 709038a4783e..69efc891885f 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -157,7 +157,11 @@ static struct sk_buff *virtio_transport_build_skb(vo=
id *opaque)
=20
 void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
 {
+	if (pkt->tap_delivered)
+		return;
+
 	vsock_deliver_tap(virtio_transport_build_skb, pkt);
+	pkt->tap_delivered =3D true;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
=20
--=20
2.25.3
