Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEADC7EE2D
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 192A660F41;
	Mon,  8 May 2023 06:14:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 192A660F41
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VdxFMCEIlruX; Mon,  8 May 2023 06:14:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54D7F61406;
	Mon,  8 May 2023 06:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54D7F61406
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 382EAC008D;
	Mon,  8 May 2023 06:14:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED238C0089
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC01E821F6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC01E821F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4n3xmIVVWRj9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A68CA82236
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A68CA82236
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:14:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R301e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vi.E88-_1683526471; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vi.E88-_1683526471) by smtp.aliyun-inc.com;
 Mon, 08 May 2023 14:14:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 12/15] virtio_net: small: avoid code duplication
 in xdp scenarios
Date: Mon,  8 May 2023 14:14:14 +0800
Message-Id: <20230508061417.65297-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com>
References: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 847ebbc5df1e
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
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

Avoid the problem that some variables(headroom and so on) will repeat
the calculation when process xdp.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index abf4ddcb686e..b26d907b5ba5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1031,11 +1031,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	struct sk_buff *skb;
 	struct bpf_prog *xdp_prog;
 	unsigned int xdp_headroom = (unsigned long)ctx;
-	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
-	unsigned int headroom = vi->hdr_len + header_offset;
-	unsigned int buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
-			      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct page *page = virt_to_head_page(buf);
+	unsigned int header_offset;
+	unsigned int headroom;
+	unsigned int buflen;
 
 	len -= vi->hdr_len;
 	stats->bytes += len;
@@ -1063,6 +1062,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	rcu_read_unlock();
 
 skip_xdp:
+	header_offset = VIRTNET_RX_PAD + xdp_headroom;
+	headroom = vi->hdr_len + header_offset;
+	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
 	skb = build_skb(buf, buflen);
 	if (!skb)
 		goto err;
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
