Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8139EC4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 18:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10265409B6;
	Tue,  8 Feb 2022 18:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OnK8eosdlAKV; Tue,  8 Feb 2022 18:15:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AECBD4099D;
	Tue,  8 Feb 2022 18:15:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C98C000B;
	Tue,  8 Feb 2022 18:15:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD03C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC344813F0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AggS4SUzVDh4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20392813EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 18:15:45 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id m18so6508373lfq.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zwrnbyLNdtTm0btNv2HP1O4KlFU0i9XXxpiCHX2F+Pc=;
 b=tzNlIqib5jH9XFKGuZa+YMoAj9U8joZMJeU+ui8Zcv/IDBs4+XgzC1gQofsf0pGOJC
 gSlyGOPLYjc8L/Be+N+wb521dnQ/lkySge3j5SGgV1ALefdhamIqPqWmnALQAD25sNca
 O3Jvbze4FPuQv7lPe9KA4pU7Ddl7gqac6dVvmtBTxiFNC8fj5iF9Bp/6LyZqJOHiZYWN
 Nqwq928pL8jsZ7bUVLHpSgRgchGNlAQ4ZpSf+ryLQpNJT3Z34l+7iKpzEkI5rRbhOnSJ
 Kw+mFk4umJjnNojd/XA58TNTwM7zRvY0QxwPkquwrGILglqytsQEzqcgN+BCfP3bOAGq
 nRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zwrnbyLNdtTm0btNv2HP1O4KlFU0i9XXxpiCHX2F+Pc=;
 b=qMkOTKfTV95h4OZHKS1E2AQO7GbBXn9IEDPlH3Uy80Je1Yekb0Nmh3eENirTSmTcRS
 RlFE9iB7bXh9fE2ZeKRdsyFatGgfcoVsnvSg4hBgNnGWVF/zjQ+Rxkony+VAT0m59RUL
 zmVwK/QseyOU4bsZ06VPeUOuHwMMXPOXw/ED6fwK+L/45cWkbHCEJjZkqxiqmbWKseVZ
 dfD1oV3pYcV7e7sP1r58NKk69B2JuqAr/2c2MMfEYZa75LSFq+KrnSh7ZnVFeKtbtiHz
 h0J3HT9wPvP+3whBmRvGrlqd8/4hBO4A5RtcVE8wBQ2b7DEy1Bg2oyGZUXw2g510kk1h
 86zg==
X-Gm-Message-State: AOAM5316NVKB61zO0tMgTUAx4VyXEkmDHRxnT0BOG1Xh3gkWGb85cth0
 f1s0P1RH7SP0EKQbWZP5ej7qRPMMN9Jh4COt
X-Google-Smtp-Source: ABdhPJwAV0zcT5EY4vC/gPjMGB5tdxsfLzkDK1pFzGI5vqPmF/9DgAx4UdfdZdCYsJBKHLDCbJxV1w==
X-Received: by 2002:a05:6512:3ba:: with SMTP id
 v26mr3534983lfp.662.1644344143814; 
 Tue, 08 Feb 2022 10:15:43 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id p16sm2125082ljc.86.2022.02.08.10.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 10:15:43 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v3 1/4] drivers/net/virtio_net: Fixed padded vheader to use v1
 with hash.
Date: Tue,  8 Feb 2022 20:15:07 +0200
Message-Id: <20220208181510.787069-2-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208181510.787069-1-andrew@daynix.com>
References: <20220208181510.787069-1-andrew@daynix.com>
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
 drivers/net/virtio_net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a801ea40908f..1404e683a2fd 100644
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
@@ -1266,7 +1266,8 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 					  struct ewma_pkt_len *avg_pkt_len,
 					  unsigned int room)
 {
-	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	const size_t hdr_len = vi->hdr_len;
 	unsigned int len;
 
 	if (room)
@@ -2851,7 +2852,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
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
