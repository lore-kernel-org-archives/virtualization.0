Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D368BC636D3
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87BC06116D;
	Thu,  2 Feb 2023 11:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87BC06116D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KksPLMHydrcz; Thu,  2 Feb 2023 11:01:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E17E56114F;
	Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E17E56114F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2D84C002B;
	Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34F91C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CEF740048
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CEF740048
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHeTXrTMQbX9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A47B6402E0
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A47B6402E0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:23 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VakkM5e_1675335677; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VakkM5e_1675335677) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 16/33] virtio_net: introduce virtnet_xdp_handler() to seprate
 the logic of run xdp
Date: Thu,  2 Feb 2023 19:00:41 +0800
Message-Id: <20230202110058.130695-17-xuanzhuo@linux.alibaba.com>
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

At present, we have two long similar logic to perform XDP Progs. And in
the implementation of XSK, we will have this need.

Therefore, this PATCH separates the code of executing XDP, which is
conducive to later maintenance and facilitates subsequent XSK for reuse.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 53 +++++++++++++++++++++++++++++++++
 drivers/net/virtio/virtio_net.h | 11 +++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 5683cb576474..9d4b84b23ef7 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -478,6 +478,59 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	return ret;
 }
 
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats)
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
+		return VIRTNET_XDP_RES_PASS;
+
+	case XDP_TX:
+		stats->xdp_tx++;
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf))
+			return VIRTNET_XDP_RES_DROP;
+
+		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
+		if (unlikely(!err)) {
+			xdp_return_frame_rx_napi(xdpf);
+		} else if (unlikely(err < 0)) {
+			trace_xdp_exception(dev, xdp_prog, act);
+			return VIRTNET_XDP_RES_DROP;
+		}
+
+		*xdp_xmit |= VIRTIO_XDP_TX;
+		return VIRTNET_XDP_RES_CONSUMED;
+
+	case XDP_REDIRECT:
+		stats->xdp_redirects++;
+		err = xdp_do_redirect(dev, xdp, xdp_prog);
+		if (err)
+			return VIRTNET_XDP_RES_DROP;
+
+		*xdp_xmit |= VIRTIO_XDP_REDIR;
+		return VIRTNET_XDP_RES_CONSUMED;
+
+	default:
+		bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(dev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		return VIRTNET_XDP_RES_DROP;
+	}
+}
+
 static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
 {
 	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 8bf31429ae28..af3e7e817f9e 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -22,6 +22,12 @@
 #include <net/net_failover.h>
 #include <net/xdp_sock_drv.h>
 
+enum {
+	VIRTNET_XDP_RES_PASS,
+	VIRTNET_XDP_RES_DROP,
+	VIRTNET_XDP_RES_CONSUMED,
+};
+
 #define VIRTIO_XDP_FLAG	BIT(0)
 
 struct virtnet_info {
@@ -262,4 +268,9 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 		stats->packets++;
 	}
 }
+
+int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
+			struct net_device *dev,
+			unsigned int *xdp_xmit,
+			struct virtnet_rq_stats *stats);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
