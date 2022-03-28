Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22633C433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 18:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB7BF410E8;
	Mon, 28 Mar 2022 18:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AnuTg8194gFL; Mon, 28 Mar 2022 18:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 48CE5410D0;
	Mon, 28 Mar 2022 18:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30C31C001D;
	Mon, 28 Mar 2022 18:01:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3195AC0083
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FFF681767
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZs1_rXAS5gP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A13A881766
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 18:01:43 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id 17so20329902lji.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=03PefwHsmItmTHhL6lJqxa9zDP27cAxap27LRrEspsw=;
 b=nfEeQvfRPoop5plFvifW8xUkvneLhLrM5cl1yZzcG3YIDt2bpnZh7Qb9BRBR1KMqmL
 kfO1vMpuGZgnfmUwktAGevzrihWEkV9fN4OOcZXIbkx0MTCNrzRZsnEGnalt+4oRAgTE
 m06MWgTGnRU1nxRZ7Lkhc+foCiS3XRX7xJrah10DtdHgJ5xYYz4c7gjJdZ3vNIfdmi0z
 lVqA8TavemfrvABP0O/yjV5G007U9UPNqy0mBinYHmnnpc1+vllkqfZojYw9uy/thFnS
 XN3ewSHXVb6Mkm52MJBdCvDzPa25xYyuiXDOAKL2JXf2hB/RxZ8Ez8I5pn+Q3HdNdJ7R
 jw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=03PefwHsmItmTHhL6lJqxa9zDP27cAxap27LRrEspsw=;
 b=pCUHzd8viX2INPbKgui9hzihTdSLSX78Y+Ff2v0Pe95RWD+QqRLKb6odcQnbq0VLbo
 7bV2T7VXAjHysO9ce6YYvvD2cJFWawY0mgh5T44xGU2DuukCzajXXwC0P6rI4KlZUCR4
 Zp3enOmIoi+yaWqZL1BusEj37zIGzIvImOZ7e8+rBzKPxJ+sxUg2kCk4+ddchjvhumzr
 +VBE9DE3RMLkhRouYBPKToKOqdB2uUnh4VcXQ3faVD3HBMgedVUqFpdGBrxnhSCfF5Xw
 pJHFG5XHBFO5T1ZmucqOo7BhHYHhBoJp8iEDMcQeXtpZAeEB9JvnGK9lJHrY3iNo8HwA
 fR+Q==
X-Gm-Message-State: AOAM532GXkVWdqdSz6KFdVjgWwTC3W+IeJmwjScH0VPKr2Io6kMO9og+
 HvCdGxjrbuNkrC8rEJE6xcOT6A==
X-Google-Smtp-Source: ABdhPJwxC1xj/F41v0H5XnVzziyNIhKmsc3QKEy+VvVawVWVILEfs+1ka8b4jxlkNvZDbalOWQBThQ==
X-Received: by 2002:a2e:b054:0:b0:248:5819:b946 with SMTP id
 d20-20020a2eb054000000b002485819b946mr7119493ljl.389.1648490501549; 
 Mon, 28 Mar 2022 11:01:41 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 a4-20020a2eb164000000b0024988e1cfb6sm1801559ljm.94.2022.03.28.11.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 11:01:41 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v5 1/4] drivers/net/virtio_net: Fixed padded vheader to use v1
 with hash.
Date: Mon, 28 Mar 2022 20:53:33 +0300
Message-Id: <20220328175336.10802-2-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328175336.10802-1-andrew@daynix.com>
References: <20220328175336.10802-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: mst@redhat.com, yuri.benditovich@daynix.com, yan@daynix.com,
 kuba@kernel.org, davem@davemloft.net
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
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
