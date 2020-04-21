From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net] vsock/virtio: postpone packet delivery to monitoring devices
Date: Tue, 21 Apr 2020 11:25:27 +0200
Message-ID: <20200421092527.41651-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Gerard Garcia <ggarcia@abra.uab.cat>
List-Id: virtualization@lists.linuxfoundation.org

We delivering packets to monitoring devices, before to check if
the virtqueue has enough space.

If the virtqueue is full, the transmitting packet is queued up
and it will be sent in the next iteration. This causes the same
packet to be delivered multiple times to monitoring devices.

This patch fixes this issue, postponing the packet delivery
to monitoring devices, only when it is properly queued in the
virqueue.

Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
index dfbaf6bd8b1c..d8db837a96fe 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -115,8 +115,6 @@ virtio_transport_send_pkt_work(struct work_struct *wo=
rk)
 		list_del_init(&pkt->list);
 		spin_unlock_bh(&vsock->send_pkt_list_lock);
=20
-		virtio_transport_deliver_tap_pkt(pkt);
-
 		reply =3D pkt->reply;
=20
 		sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
@@ -137,6 +135,11 @@ virtio_transport_send_pkt_work(struct work_struct *w=
ork)
 			break;
 		}
=20
+		/* Deliver to monitoring devices all correctly transmitted
+		 * packets.
+		 */
+		virtio_transport_deliver_tap_pkt(pkt);
+
 		if (reply) {
 			struct virtqueue *rx_vq =3D vsock->vqs[VSOCK_VQ_RX];
 			int val;
--=20
2.25.3
