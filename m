From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [RFC v9 07/11] vhost/net: avoid iov length math
Date: Fri, 19 Jun 2020 20:22:58 +0200
Message-ID: <20200619182302.850-8-eperezma@redhat.com>
References: <20200619182302.850-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200619182302.850-1-eperezma@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com
Cc: kvm list <kvm@vger.kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>

Now that API exposes buffer length, we no longer need to
scan IOVs to figure it out.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vhost/net.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 871214d8c64d..3356b249bf64 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -607,11 +607,9 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
 }
 
 static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
-			    size_t hdr_size, int out)
+			    size_t len, size_t hdr_size, int out)
 {
 	/* Skip header. TODO: support TSO. */
-	size_t len = iov_length(vq->iov, out);
-
 	iov_iter_init(iter, WRITE, vq->iov, out, len);
 	iov_iter_advance(iter, hdr_size);
 
@@ -640,7 +638,7 @@ static int get_tx_bufs(struct vhost_net *net,
 	}
 
 	/* Sanity check */
-	*len = init_iov_iter(vq, &msg->msg_iter, nvq->vhost_hlen, *out);
+	*len = init_iov_iter(vq, &msg->msg_iter, buf->out_len, nvq->vhost_hlen, *out);
 	if (*len == 0) {
 		vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
 			*len, nvq->vhost_hlen);
@@ -1081,7 +1079,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			nlogs += *log_num;
 			log += *log_num;
 		}
-		len = iov_length(vq->iov + seg, in);
+		len = bufs[bufcount].in_len;
 		datalen -= len;
 		++bufcount;
 		seg += in;
-- 
2.18.1
