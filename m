Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46516C4332F
	for <virtualization@archiver.kernel.org>; Sun,  9 Jan 2022 21:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E374B405BF;
	Sun,  9 Jan 2022 21:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5GXcYmmbU8MH; Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2534F4058E;
	Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7240C0031;
	Sun,  9 Jan 2022 21:07:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B066C001E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A4284058E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xedq3HDkfBND
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69F46404D4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:18 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id k21so37601886lfu.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uG1TFygcuHO7vcN1VeccDOe78rhsfnpTNXRs/s5AciY=;
 b=IB0QPQ0bTMVO7PZtDHKhx20evVfLgpnfnA6QKEYRn+WQLPF6DWJ2RxtA2/0/eb3atB
 3ZCsAEtXrRNOU9p4RBDkWzzPlwhabrXhSU9/ofxE/zKFTl1q0pw3rvY5eDx3gsvkRlnS
 mrPcDaRcxKCigvj0Cz8nKdMmW0SlFiMSvn4euaGhaW1Y0r4zogX9OLDMZGasx1DG+wuw
 sGFtWFrdqndEP+ONlh0ouUUVHXtynScLstgUiZqvqgMgVy5D+oA23pOS8hlm/FoCpvgd
 WJl3oA4yTmQWld1uQhZc9Pck/ww1xQiCKKoXBY+Gn+248cyLM7D97JwEuaznaY4MuAKj
 tLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uG1TFygcuHO7vcN1VeccDOe78rhsfnpTNXRs/s5AciY=;
 b=f3Izn5ZIat3cKg1L79FeHkIjw8adhdD3/89qpU4+SC2s7pbfdqdFjkX7rGoESi9fZP
 /yH5prhfCjw9G3hWxz1gHT7MJE4v0do3NEhFx5X4VAfunWKNLdcJHN9vTb1Mb6Q0Izl8
 cPAMekUlu9lmVM29HfyfgGaATgyAjZR8Ir771SXejWuJFPNKff90pdCcuaS1H7DVeg+N
 kuFy3imum4y+rXtLRfjOKzlwx9Y5wMkoZqSG+iV1qmjkP2nLpL96tmdwed10IvV9GNNv
 In6/rDVyt0b3VJyS30HnHSwjiGu5TVXMAYSRwYBYcAlfwCRrKODHCJAEYkoZEHuOuS6r
 lB9g==
X-Gm-Message-State: AOAM531p6i+ciAJrRo1CAgW9s9l1oa1UXbiw/Y1A6/OdyXO7wmJOKI/+
 Fx2OreImn7QN4uZwMJrnAsPlTw==
X-Google-Smtp-Source: ABdhPJxeRI+9T37ZGNuxNPDVJXBNo2d8k6wTSUFr4KBufW5inOMyrUHtS3fD/r5SHOBxdL/rymmUkQ==
X-Received: by 2002:a2e:8802:: with SMTP id x2mr57534346ljh.382.1641762436228; 
 Sun, 09 Jan 2022 13:07:16 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id p17sm766129lfu.233.2022.01.09.13.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 13:07:15 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH 1/4] drivers/net/virtio_net: Fixed padded vheader to use v1
 with hash.
Date: Sun,  9 Jan 2022 23:06:56 +0200
Message-Id: <20220109210659.2866740-2-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220109210659.2866740-1-andrew@daynix.com>
References: <20220109210659.2866740-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

The header v1 provides additional info about RSS.
Added changes to computing proper header length.
In the next patches, the header may contain RSS hash info
for the hash population.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b107835242ad..66439ca488f4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -242,13 +242,13 @@ struct virtnet_info {
 };
 
 struct padded_vnet_hdr {
-	struct virtio_net_hdr_mrg_rxbuf hdr;
+	struct virtio_net_hdr_v1_hash hdr;
 	/*
 	 * hdr is in a separate sg buffer, and data sg buffer shares same page
 	 * with this header sg. This padding makes next sg 16 byte aligned
 	 * after the header.
 	 */
-	char padding[4];
+	char padding[12];
 };
 
 static bool is_xdp_frame(void *ptr)
@@ -395,7 +395,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	hdr_p = p;
 
 	hdr_len = vi->hdr_len;
-	if (vi->mergeable_rx_bufs)
+	if (vi->has_rss_hash_report)
+		hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (vi->mergeable_rx_bufs)
 		hdr_padded_len = sizeof(*hdr);
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
@@ -1266,7 +1268,8 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 					  struct ewma_pkt_len *avg_pkt_len,
 					  unsigned int room)
 {
-	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	const size_t hdr_len = vi->hdr_len;
 	unsigned int len;
 
 	if (room)
@@ -2849,7 +2852,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
  */
 static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqueue *vq)
 {
-	const unsigned int hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const unsigned int hdr_len = vi->hdr_len;
 	unsigned int rq_size = virtqueue_get_vring_size(vq);
 	unsigned int packet_len = vi->big_packets ? IP_MAX_MTU : vi->dev->max_mtu;
 	unsigned int buf_len = hdr_len + ETH_HLEN + VLAN_HLEN + packet_len;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
