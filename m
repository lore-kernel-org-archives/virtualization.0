From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net v2 1/2] vhost/vsock: fix packet delivery order to monitoring devices
Date: Fri, 24 Apr 2020 17:08:29 +0200
Message-ID: <20200424150830.183113-2-sgarzare@redhat.com>
References: <20200424150830.183113-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200424150830.183113-1-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

We want to deliver packets to monitoring devices before it is
put in the virtqueue, to avoid that replies can appear in the
packet capture before the transmitted packet.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 97669484a3f6..18aff350a405 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -181,14 +181,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
 			break;
 		}
=20
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
-		added =3D true;
-
-		/* Deliver to monitoring devices all correctly transmitted
-		 * packets.
+		/* Deliver to monitoring devices all packets that we
+		 * will transmit.
 		 */
 		virtio_transport_deliver_tap_pkt(pkt);
=20
+		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
+		added =3D true;
+
 		pkt->off +=3D payload_len;
 		total_len +=3D payload_len;
=20
--=20
2.25.3
