From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 2/2] virtio-net: fix the XDP truesize calculation for mergeable buffers
Date: Wed,  6 May 2020 14:16:33 +0800
Message-ID: <20200506061633.16327-2-jasowang@redhat.com>
References: <20200506061633.16327-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506061633.16327-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We should not exclude headroom and tailroom when XDP is set. So this
patch fixes this by initializing the truesize from PAGE_SIZE when XDP
is set.

Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 98dd75b665a5..3f3aa8308918 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1184,7 +1184,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
 	char *buf;
 	void *ctx;
 	int err;
-	unsigned int len, hole;
+	unsigned int len, hole, truesize;
=20
 	/* Extra tailroom is needed to satisfy XDP's assumption. This
 	 * means rx frags coalescing won't work, but consider we've
@@ -1194,6 +1194,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
 	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
 		return -ENOMEM;
=20
+	truesize =3D headroom ? PAGE_SIZE : len;
 	buf =3D (char *)page_address(alloc_frag->page) + alloc_frag->offset;
 	buf +=3D headroom; /* advance address leaving hole at front of pkt */
 	get_page(alloc_frag->page);
@@ -1205,11 +1206,12 @@ static int add_recvbuf_mergeable(struct virtnet_i=
nfo *vi,
 		 * the current buffer.
 		 */
 		len +=3D hole;
+		truesize +=3D hole;
 		alloc_frag->offset +=3D hole;
 	}
=20
 	sg_init_one(rq->sg, buf, len);
-	ctx =3D mergeable_len_to_ctx(len, headroom);
+	ctx =3D mergeable_len_to_ctx(truesize, headroom);
 	err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0)
 		put_page(virt_to_head_page(buf));
--=20
2.20.1
