From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet header for XDP
Date: Wed,  6 May 2020 14:16:32 +0800
Message-ID: <20200506061633.16327-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We tried to reserve space for vnet header before
xdp.data_hard_start. But this is useless since the packet could be
modified by XDP which may invalidate the information stored in the
header and there's no way for XDP to know the existence of the vnet
header currently.

So let's just not reserve space for vnet header in this case.

Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 11f722460513..98dd75b665a5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -684,8 +684,8 @@ static struct sk_buff *receive_small(struct net_devic=
e *dev,
 			page =3D xdp_page;
 		}
=20
-		xdp.data_hard_start =3D buf + VIRTNET_RX_PAD + vi->hdr_len;
-		xdp.data =3D xdp.data_hard_start + xdp_headroom;
+		xdp.data_hard_start =3D buf + VIRTNET_RX_PAD;
+		xdp.data =3D xdp.data_hard_start + xdp_headroom + vi->hdr_len;
 		xdp.data_end =3D xdp.data + len;
 		xdp.data_meta =3D xdp.data;
 		xdp.rxq =3D &rq->xdp_rxq;
@@ -845,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct net_d=
evice *dev,
 		 * the descriptor on if we get an XDP_TX return code.
 		 */
 		data =3D page_address(xdp_page) + offset;
-		xdp.data_hard_start =3D data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
+		xdp.data_hard_start =3D data - VIRTIO_XDP_HEADROOM;
 		xdp.data =3D data + vi->hdr_len;
 		xdp.data_end =3D xdp.data + (len - vi->hdr_len);
 		xdp.data_meta =3D xdp.data;
--=20
2.20.1
