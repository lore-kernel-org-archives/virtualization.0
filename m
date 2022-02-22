Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEB5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 12:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8EEF405AF;
	Tue, 22 Feb 2022 12:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1MXOMPoMfu3; Tue, 22 Feb 2022 12:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2EACD405B1;
	Tue, 22 Feb 2022 12:01:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71DF5C0077;
	Tue, 22 Feb 2022 12:01:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C7C9C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B6FA409A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zUe8jP36TM20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 851B64099E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:01:34 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id i11so24322117lfu.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n3UASRZlY1ToiL7j+vac0NlVXBZTlgkBMPexZZH8C6k=;
 b=jfaaQzt2S7n0OU7ynyl2Zhip7Vyr+DHnL9LJyepA4ZNXRE9resVnk0PfuPpiHwVgmv
 vc2LMRDDw7PXrFF+RwoHuL+N5XGRecNv6Xdg2nxH+WmG8dHpIOlsC7h/xjSmDqT0QYoN
 7UedikiWkX28zzjYFTqfQz0kVkC/9ZWleFJq/VRgEkI0cuWLLa5npcR5eH3D+jBW7dn8
 Dd2FqZpaSxA+qcvhd9TwDpaa64BxgJPmQ5Bpyl2JJKYpz7azy4CKTbT/wyDTFC98cQLt
 8XwUZI/LOEiVm3Kq98P+TPakizi5Yu9yMEPTFVB4ObozltO0EN2e7if4eM8qYhMomM8D
 BS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n3UASRZlY1ToiL7j+vac0NlVXBZTlgkBMPexZZH8C6k=;
 b=FMLbGX+VIdFvPA3WxliWlIrmW/hDpq6w59VhTBzE83MmB8aIDAqMoLElK7lRjJI/xP
 zj+1IPYP/zRzwAUhnaiYwfdR+RW3qFSKinudq/bXTUwYYANgV5Jl6wOoztDsX9wZujQR
 WVfTAkTLbdAnNjk8afFoa7fWWWKaJuY2yF0TLGErgJOhl+tqc7TxkowPbvraOr9BIIcE
 Px45MytHMzwHLzy6hbBlw4AH0zZlmN1nAqFbeRGaHVY1h2JmLEWHBp9CrPJ4mIAJUsOS
 45Gq/7k5CDieFKl1rNKeOZKjPIlws5Y6p7ZKGgtySr1lmq+vWDvEovd5twP4oLHIPXFW
 970A==
X-Gm-Message-State: AOAM531j6uAlEbxLFqmEzIoXLEb7QX7nCl1+Z/UAv7UuBq6AXRrRFgeX
 Ev3mLshZdJWUkI3qdb5QuwcQ4A==
X-Google-Smtp-Source: ABdhPJxfECW7k15BXfCXRoSbeWdHBJQv9NiMF3cf/3Wxvkuewc/sFAJroFOpkeE7UPLyzzlXEZPF9Q==
X-Received: by 2002:a05:6512:3698:b0:443:a348:d252 with SMTP id
 d24-20020a056512369800b00443a348d252mr16851784lfs.193.1645531292541; 
 Tue, 22 Feb 2022 04:01:32 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id v29sm1664024ljv.72.2022.02.22.04.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 04:01:32 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v4 1/4] drivers/net/virtio_net: Fixed padded vheader to use v1
 with hash.
Date: Tue, 22 Feb 2022 14:00:51 +0200
Message-Id: <20220222120054.400208-2-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222120054.400208-1-andrew@daynix.com>
References: <20220222120054.400208-1-andrew@daynix.com>
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
 drivers/net/virtio_net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a801ea40908f..b9ed7c55d9a0 100644
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
@@ -396,7 +396,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	hdr_len = vi->hdr_len;
 	if (vi->mergeable_rx_bufs)
-		hdr_padded_len = sizeof(*hdr);
+		hdr_padded_len = hdr_len;
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
 
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
