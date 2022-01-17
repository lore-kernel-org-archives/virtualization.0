Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DC7C433EF
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 08:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 989F040345;
	Mon, 17 Jan 2022 08:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e19JDO_YjYON; Mon, 17 Jan 2022 08:00:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 597F54038C;
	Mon, 17 Jan 2022 08:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDF86C007B;
	Mon, 17 Jan 2022 08:00:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A9EC0039
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04A758144C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jnv3CKYjcnzt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 391C28144D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:00:34 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id e3so51640250lfc.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 00:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aE+gOvLd3VLDh4TGDkR9cJ5k95oZ+26Kjnw0rS0ttNo=;
 b=DfxL1QWHgUjqNAn2Tt/PAep9IT/Qnv557uZrmdj0BN53Xo5Io9ZI7yokDnufroR+Gt
 6FtLF5vHW56MO7SdFiNf0PaJUpsODk/DhzUYWL0Tyk468Ia42X9GQIBnrnft5iYDX7aH
 kvQvZSU4hBYcJ/1X2JIUK9/1Om8cDfM3cznV/wGAQc5Hx/EG4T0/fon8y0FqN3LOBydD
 P/yRPNP3bBGreriRG/a5SPq3HViPHa2YZOzM1iDlgGVnXYwNyfhU8SPnPxOv3VBe8cT0
 NDDJ7868yppWnb4L3rKfxpb+GJOKMVM8stVJQEK05PAEExxbzf7m7uIlBnwvxfO+Pqbt
 F8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aE+gOvLd3VLDh4TGDkR9cJ5k95oZ+26Kjnw0rS0ttNo=;
 b=m2248TNsVFroebQCtx/PFq9/YAPV+BrOCSmdHEydreQKVTGmQjNvLSahl5bG32x+el
 lL1dWtTg9qhP5DbtIYAlroWsjOvGKeNSQa/ImiyyfKAtJQPBF4qxxPmr87C6wNYufPga
 e9JKTRUu9GQ8LT4UHe2BR2cO6Eqf2HbNdp38rHuU9cEIWFRaiHgkZDfGwsnuWMxtkX7E
 /DKmkBqfUbOhtd/drjk9St07+bAIqVF265wQxOIqGn5o8CD29YwBkoW3n80k/OUiMZr4
 qDXoy6zL1nVuCMNhnHyWra7E+ELDwQQFHjXOv7kG5nx2FswS8G6IJGWa0vCY10Imief+
 qEOA==
X-Gm-Message-State: AOAM5329kAGuOaF2WfhVngx+0Dh9/RCqUhQ6XgQIFPWDNSzc5wFFdQ4I
 7WHHiPfy7jr3j0lpvMRN0b41iA==
X-Google-Smtp-Source: ABdhPJxOzAx74592F+FW3dwVZjqGCvoIwq/B+TmrOWzKFWTocF/luxu/JYeT4FVVLUDrrilZMYcc7A==
X-Received: by 2002:a05:6512:3184:: with SMTP id
 i4mr15831976lfe.673.1642406432060; 
 Mon, 17 Jan 2022 00:00:32 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id x18sm1279423ljd.105.2022.01.17.00.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 00:00:31 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v2 1/4] drivers/net/virtio_net: Fixed padded vheader to use v1
 with hash.
Date: Mon, 17 Jan 2022 10:00:06 +0200
Message-Id: <20220117080009.3055012-2-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117080009.3055012-1-andrew@daynix.com>
References: <20220117080009.3055012-1-andrew@daynix.com>
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
index 569eecfbc2cd..05fe5ba32187 100644
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
