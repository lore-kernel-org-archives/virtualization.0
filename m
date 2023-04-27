Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846EC7EE24
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 03:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D950D41E7D;
	Thu, 27 Apr 2023 03:05:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D950D41E7D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B4-pwHD092Yl; Thu, 27 Apr 2023 03:05:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9589E41EC4;
	Thu, 27 Apr 2023 03:05:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9589E41EC4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9ABAC002A;
	Thu, 27 Apr 2023 03:05:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DAB2C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A22C40924
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A22C40924
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1thRcNKvgFH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E064F40602
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E064F40602
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:05:44 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vh5kKlL_1682564739; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vh5kKlL_1682564739) by smtp.aliyun-inc.com;
 Thu, 27 Apr 2023 11:05:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v4 04/15] virtio_net: introduce virtnet_xdp_handler()
 to seprate the logic of run xdp
Date: Thu, 27 Apr 2023 11:05:23 +0800
Message-Id: <20230427030534.115066-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
References: <20230427030534.115066-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 69b1082fef22
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

At present, we have two similar logic to perform the XDP prog.

Therefore, this patch separates the code of executing XDP, which is
conducive to later maintenance.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 118 +++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 60 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f66d73097b4..264945dd7a35 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -789,6 +789,60 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	return ret;
 }
 
+static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			       struct net_device *dev,
+			       unsigned int *xdp_xmit,
+			       struct virtnet_rq_stats *stats)
+{
+	struct xdp_frame *xdpf;
+	int err;
+	u32 act;
+
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	stats->xdp_packets++;
+
+	switch (act) {
+	case XDP_PASS:
+		return act;
+
+	case XDP_TX:
+		stats->xdp_tx++;
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			netdev_dbg(dev, "convert buff to frame failed for xdp\n");
+			return XDP_DROP;
+		}
+
+		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
+		if (unlikely(!err)) {
+			xdp_return_frame_rx_napi(xdpf);
+		} else if (unlikely(err < 0)) {
+			trace_xdp_exception(dev, xdp_prog, act);
+			return XDP_DROP;
+		}
+		*xdp_xmit |= VIRTIO_XDP_TX;
+		return act;
+
+	case XDP_REDIRECT:
+		stats->xdp_redirects++;
+		err = xdp_do_redirect(dev, xdp, xdp_prog);
+		if (err)
+			return XDP_DROP;
+
+		*xdp_xmit |= VIRTIO_XDP_REDIR;
+		return act;
+
+	default:
+		bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(dev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		return XDP_DROP;
+	}
+}
+
 static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
 {
 	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
@@ -876,7 +930,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	struct page *page = virt_to_head_page(buf);
 	unsigned int delta = 0;
 	struct page *xdp_page;
-	int err;
 	unsigned int metasize = 0;
 
 	len -= vi->hdr_len;
@@ -898,7 +951,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
 		struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
-		struct xdp_frame *xdpf;
 		struct xdp_buff xdp;
 		void *orig_data;
 		u32 act;
@@ -931,8 +983,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 				 xdp_headroom, len, true);
 		orig_data = xdp.data;
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-		stats->xdp_packets++;
+
+		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
 
 		switch (act) {
 		case XDP_PASS:
@@ -942,35 +994,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
 			metasize = xdp.data - xdp.data_meta;
 			break;
 		case XDP_TX:
-			stats->xdp_tx++;
-			xdpf = xdp_convert_buff_to_frame(&xdp);
-			if (unlikely(!xdpf))
-				goto err_xdp;
-			err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
-			if (unlikely(!err)) {
-				xdp_return_frame_rx_napi(xdpf);
-			} else if (unlikely(err < 0)) {
-				trace_xdp_exception(vi->dev, xdp_prog, act);
-				goto err_xdp;
-			}
-			*xdp_xmit |= VIRTIO_XDP_TX;
-			rcu_read_unlock();
-			goto xdp_xmit;
 		case XDP_REDIRECT:
-			stats->xdp_redirects++;
-			err = xdp_do_redirect(dev, &xdp, xdp_prog);
-			if (err)
-				goto err_xdp;
-			*xdp_xmit |= VIRTIO_XDP_REDIR;
 			rcu_read_unlock();
 			goto xdp_xmit;
 		default:
-			bpf_warn_invalid_xdp_action(vi->dev, xdp_prog, act);
-			fallthrough;
-		case XDP_ABORTED:
-			trace_xdp_exception(vi->dev, xdp_prog, act);
-			goto err_xdp;
-		case XDP_DROP:
 			goto err_xdp;
 		}
 	}
@@ -1278,7 +1305,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (xdp_prog) {
 		unsigned int xdp_frags_truesz = 0;
 		struct skb_shared_info *shinfo;
-		struct xdp_frame *xdpf;
 		struct page *xdp_page;
 		struct xdp_buff xdp;
 		void *data;
@@ -1295,8 +1321,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		if (unlikely(err))
 			goto err_xdp_frags;
 
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-		stats->xdp_packets++;
+		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
 
 		switch (act) {
 		case XDP_PASS:
@@ -1307,38 +1332,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			rcu_read_unlock();
 			return head_skb;
 		case XDP_TX:
-			stats->xdp_tx++;
-			xdpf = xdp_convert_buff_to_frame(&xdp);
-			if (unlikely(!xdpf)) {
-				netdev_dbg(dev, "convert buff to frame failed for xdp\n");
-				goto err_xdp_frags;
-			}
-			err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
-			if (unlikely(!err)) {
-				xdp_return_frame_rx_napi(xdpf);
-			} else if (unlikely(err < 0)) {
-				trace_xdp_exception(vi->dev, xdp_prog, act);
-				goto err_xdp_frags;
-			}
-			*xdp_xmit |= VIRTIO_XDP_TX;
-			rcu_read_unlock();
-			goto xdp_xmit;
 		case XDP_REDIRECT:
-			stats->xdp_redirects++;
-			err = xdp_do_redirect(dev, &xdp, xdp_prog);
-			if (err)
-				goto err_xdp_frags;
-			*xdp_xmit |= VIRTIO_XDP_REDIR;
 			rcu_read_unlock();
 			goto xdp_xmit;
 		default:
-			bpf_warn_invalid_xdp_action(vi->dev, xdp_prog, act);
-			fallthrough;
-		case XDP_ABORTED:
-			trace_xdp_exception(vi->dev, xdp_prog, act);
-			fallthrough;
-		case XDP_DROP:
-			goto err_xdp_frags;
+			break;
 		}
 err_xdp_frags:
 		if (xdp_buff_has_frags(&xdp)) {
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
