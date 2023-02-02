Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DBFC636D6
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EB1F8148A;
	Thu,  2 Feb 2023 11:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EB1F8148A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCAyhsXqLNS8; Thu,  2 Feb 2023 11:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F7938132E;
	Thu,  2 Feb 2023 11:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F7938132E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BF98C007D;
	Thu,  2 Feb 2023 11:01:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD6FEC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95803403C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95803403C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id datspSUIAFaY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B855E4046D
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B855E4046D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:24 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VakpyEf_1675335679; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VakpyEf_1675335679) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 18/33] virtio_net: receive_merageable() use
 virtnet_xdp_handler()
Date: Thu,  2 Feb 2023 19:00:43 +0800
Message-Id: <20230202110058.130695-19-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d7589ab6ea10
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

receive_merageable() use virtnet_xdp_handler()

Meanwhile, support Multi Buffer XDP.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c | 88 +++++++++++++++------------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index d7a856bd8862..fb82035a0b7f 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -483,8 +483,10 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			unsigned int *xdp_xmit,
 			struct virtnet_rq_stats *stats)
 {
+	struct skb_shared_info *shinfo;
 	struct xdp_frame *xdpf;
-	int err;
+	struct page *xdp_page;
+	int err, i;
 	u32 act;
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
@@ -527,6 +529,13 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		trace_xdp_exception(dev, xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
+		if (xdp_buff_has_frags(xdp)) {
+			shinfo = xdp_get_shared_info_from_buff(xdp);
+			for (i = 0; i < shinfo->nr_frags; i++) {
+				xdp_page = skb_frag_page(&shinfo->frags[i]);
+				put_page(xdp_page);
+			}
+		}
 		return VIRTNET_XDP_RES_DROP;
 	}
 }
@@ -809,7 +818,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 	unsigned int xdp_frags_truesz = 0;
 	struct page *page;
 	skb_frag_t *frag;
-	int offset;
+	int offset, i;
 	void *ctx;
 
 	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
@@ -842,7 +851,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				 dev->name, *num_buf,
 				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
 			dev->stats.rx_length_errors++;
-			return -EINVAL;
+			goto err;
 		}
 
 		stats->bytes += len;
@@ -861,7 +870,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
 			dev->stats.rx_length_errors++;
-			return -EINVAL;
+			goto err;
 		}
 
 		frag = &shinfo->frags[shinfo->nr_frags++];
@@ -876,6 +885,14 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 
 	*xdp_frags_truesize = xdp_frags_truesz;
 	return 0;
+
+err:
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		page = skb_frag_page(&shinfo->frags[i]);
+		put_page(page);
+	}
+
+	return -EINVAL;
 }
 
 static struct sk_buff *receive_mergeable(struct net_device *dev,
@@ -919,13 +936,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	xdp_prog = rcu_dereference(rq->xdp_prog);
 	if (xdp_prog) {
 		unsigned int xdp_frags_truesz = 0;
-		struct skb_shared_info *shinfo;
-		struct xdp_frame *xdpf;
 		struct page *xdp_page;
 		struct xdp_buff xdp;
 		void *data;
 		u32 act;
-		int i;
 
 		/* Transient failure which in theory could occur if
 		 * in-flight packets from before XDP was enabled reach
@@ -983,69 +997,33 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
 						 &num_buf, &xdp_frags_truesz, stats);
 		if (unlikely(err))
-			goto err_xdp_frags;
+			goto err_xdp;
 
-		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-		stats->xdp_packets++;
+		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
 
 		switch (act) {
-		case XDP_PASS:
+		case VIRTNET_XDP_RES_PASS:
 			if (unlikely(xdp_page != page))
 				put_page(page);
+
 			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 			rcu_read_unlock();
 			return head_skb;
-		case XDP_TX:
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
-			if (unlikely(xdp_page != page))
-				put_page(page);
-			rcu_read_unlock();
-			goto xdp_xmit;
-		case XDP_REDIRECT:
-			stats->xdp_redirects++;
-			err = xdp_do_redirect(dev, &xdp, xdp_prog);
-			if (err)
-				goto err_xdp_frags;
-			*xdp_xmit |= VIRTIO_XDP_REDIR;
+
+		case VIRTNET_XDP_RES_CONSUMED:
 			if (unlikely(xdp_page != page))
 				put_page(page);
+
 			rcu_read_unlock();
 			goto xdp_xmit;
-		default:
-			bpf_warn_invalid_xdp_action(vi->dev, xdp_prog, act);
-			fallthrough;
-		case XDP_ABORTED:
-			trace_xdp_exception(vi->dev, xdp_prog, act);
-			fallthrough;
-		case XDP_DROP:
-			goto err_xdp_frags;
-		}
-err_xdp_frags:
-		if (unlikely(xdp_page != page))
-			__free_pages(xdp_page, 0);
 
-		if (xdp_buff_has_frags(&xdp)) {
-			shinfo = xdp_get_shared_info_from_buff(&xdp);
-			for (i = 0; i < shinfo->nr_frags; i++) {
-				xdp_page = skb_frag_page(&shinfo->frags[i]);
+		case VIRTNET_XDP_RES_DROP:
+			if (unlikely(xdp_page != page))
 				put_page(xdp_page);
-			}
-		}
 
-		goto err_xdp;
+			rcu_read_unlock();
+			goto err_xdp;
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
