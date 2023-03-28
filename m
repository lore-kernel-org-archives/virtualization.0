Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A574C76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 12:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B10D441795;
	Tue, 28 Mar 2023 12:04:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B10D441795
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id boSGQccupaZz; Tue, 28 Mar 2023 12:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29D2D40436;
	Tue, 28 Mar 2023 12:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29D2D40436
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03ACEC0037;
	Tue, 28 Mar 2023 12:04:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3F04C009A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E61641772
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E61641772
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9rFkKsA85rxp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D017541779
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D017541779
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 12:04:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vet499k_1680005058; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vet499k_1680005058) by smtp.aliyun-inc.com;
 Tue, 28 Mar 2023 20:04:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 6/8] virtio_net: auto release xdp shinfo
Date: Tue, 28 Mar 2023 20:04:10 +0800
Message-Id: <20230328120412.110114-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 822c071fd47f
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

virtnet_build_xdp_buff_mrg() and virtnet_xdp_handler() auto
release xdp shinfo then the caller no need to careful the xdp shinfo.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a3f2bcb3db27..136131a7868a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -833,14 +833,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		stats->xdp_tx++;
 		xdpf = xdp_convert_buff_to_frame(xdp);
 		if (unlikely(!xdpf))
-			return VIRTNET_XDP_RES_DROP;
+			goto drop;
 
 		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
 		if (unlikely(!err)) {
 			xdp_return_frame_rx_napi(xdpf);
 		} else if (unlikely(err < 0)) {
 			trace_xdp_exception(dev, xdp_prog, act);
-			return VIRTNET_XDP_RES_DROP;
+			goto drop;
 		}
 
 		*xdp_xmit |= VIRTIO_XDP_TX;
@@ -850,7 +850,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		stats->xdp_redirects++;
 		err = xdp_do_redirect(dev, xdp, xdp_prog);
 		if (err)
-			return VIRTNET_XDP_RES_DROP;
+			goto drop;
 
 		*xdp_xmit |= VIRTIO_XDP_REDIR;
 		return VIRTNET_XDP_RES_CONSUMED;
@@ -862,8 +862,12 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		trace_xdp_exception(dev, xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
-		return VIRTNET_XDP_RES_DROP;
+		goto drop;
 	}
+
+drop:
+	put_xdp_frags(xdp);
+	return VIRTNET_XDP_RES_DROP;
 }
 
 static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
@@ -1199,7 +1203,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				 dev->name, *num_buf,
 				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
 			dev->stats.rx_length_errors++;
-			return -EINVAL;
+			goto err;
 		}
 
 		stats->bytes += len;
@@ -1218,7 +1222,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
 			dev->stats.rx_length_errors++;
-			return -EINVAL;
+			goto err;
 		}
 
 		frag = &shinfo->frags[shinfo->nr_frags++];
@@ -1233,6 +1237,10 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 
 	*xdp_frags_truesize = xdp_frags_truesz;
 	return 0;
+
+err:
+	put_xdp_frags(xdp);
+	return -EINVAL;
 }
 
 static void *mergeable_xdp_prepare(struct virtnet_info *vi,
@@ -1361,7 +1369,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
 						 &num_buf, &xdp_frags_truesz, stats);
 		if (unlikely(err))
-			goto err_xdp_frags;
+			goto err_xdp;
 
 		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
 
@@ -1369,7 +1377,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		case VIRTNET_XDP_RES_PASS:
 			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 			if (unlikely(!head_skb))
-				goto err_xdp_frags;
+				goto err_xdp;
 
 			rcu_read_unlock();
 			return head_skb;
@@ -1379,11 +1387,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto xdp_xmit;
 
 		case VIRTNET_XDP_RES_DROP:
-			goto err_xdp_frags;
+			goto err_xdp;
 		}
-err_xdp_frags:
-		put_xdp_frags(&xdp);
-		goto err_xdp;
 	}
 	rcu_read_unlock();
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
