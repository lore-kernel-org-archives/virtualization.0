Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC387C3A5A7
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A8EE8213A;
	Thu,  1 Dec 2022 22:49:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A8EE8213A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=QIQ9QFt6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ytuebictnqh0; Thu,  1 Dec 2022 22:49:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E563682098;
	Thu,  1 Dec 2022 22:49:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E563682098
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1B0EC0035;
	Thu,  1 Dec 2022 22:49:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73ECDC0033
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F5D78209F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F5D78209F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGJipAhzUTyj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F89C820AD
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F89C820AD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:57 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id l8so3527713ljh.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMtP14B7qgPGyencUQ441983HC3jgMwtJjN+dpKWwyo=;
 b=QIQ9QFt6qMwp9XgTopg2JzMbaT24wt3HeYg+fxh2eIY25LpQKv/Bg1KkBosQnkMkAk
 1g6BLnAuxPG9e2PzRQufKdjdVlLeRsoUlCXoUwG8rQJZny/8lnZJwZarl54c/e2Rk3DM
 foc/e2m89DqxnydMwjnRTE4EZkN4LgASPDWndvyxzduxDuIeYQYXrYNvShkB/fD3euQL
 uyKLR84Hw0zsbK1mSf5R861QlHqUGw8cw8TSBuiczlmLHglE2C5EewwBws0xnaf837SH
 hrzCf2Z9MSQmbOlDlHcbNMftRtZ5BRS+P/nhsGycDTHSzKbIQMi9G9NFZAx9iAlWBBTn
 717A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMtP14B7qgPGyencUQ441983HC3jgMwtJjN+dpKWwyo=;
 b=si1xSSU1N/Decb4iuR7T3Tw2yHcnXARW1tAm3KJ5YCgRXW8a7YxHQIrps4U1b17QyT
 6k/6EYKNr8VAqPCEkEVTfVI46vrIu3FV/ujeTP5X5dhK6P4OhnlF4LSHIymlvLEjFvGa
 KCZQaJTQ00cpcmBJy1mpRZXBQtCY9LzA/z4Lx7atJ5AoRRyIbpeCiCO5h1B3U9xkgKQu
 Eert7ys7/c8b++J7g1pxA22IlSxX87l8aqc3G6kT/zACTttO/pF1jq0IDm2Cf4xCvYOB
 nfZ9MFCAKjBc0UFF+W4vcBJyPiiUws18JIz/Qn8T80+f+CMUdBpIPOd7PZBEnokem7Mr
 ITSw==
X-Gm-Message-State: ANoB5pnmfz9q2gJYuiOq81LiTJButd6J7HpPMWtAiOl7lx1D9/sDAw0k
 IY0l3dydbB3nemmwEYY56mvNlA==
X-Google-Smtp-Source: AA0mqf7iH4qKDrkzG9+Shl2zZSzIdLZslzUZoaguiNHYTQH5G1+QmGOuuQK8t7+Hz26D8DQgTqiZ6A==
X-Received: by 2002:a05:651c:12c5:b0:279:a905:b547 with SMTP id
 5-20020a05651c12c500b00279a905b547mr6590583lje.295.1669934936605; 
 Thu, 01 Dec 2022 14:48:56 -0800 (PST)
Received: from localhost.localdomain ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a056512118700b00497ab34bf5asm797573lfr.20.2022.12.01.14.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:48:56 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 6/6] drivers/net/virtio_net.c: Added USO support.
Date: Fri,  2 Dec 2022 00:33:32 +0200
Message-Id: <20221201223332.249441-6-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201223332.249441-1-andrew@daynix.com>
References: <20221201223332.249441-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: devel@daynix.com
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

Now, it possible to enable GSO_UDP_L4("tx-udp-segmentation") for VirtioNet.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 86e52454b5b5..97d63c819c7b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -60,13 +60,17 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
 	VIRTIO_NET_F_GUEST_UFO,
-	VIRTIO_NET_F_GUEST_CSUM
+	VIRTIO_NET_F_GUEST_CSUM,
+	VIRTIO_NET_F_GUEST_USO4,
+	VIRTIO_NET_F_GUEST_USO6
 };
 
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
-				(1ULL << VIRTIO_NET_F_GUEST_UFO))
+				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO6))
 
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
@@ -3085,7 +3089,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
-		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
 		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
 		return -EOPNOTSUPP;
 	}
@@ -3690,7 +3696,9 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
 	return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
-		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO);
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
+		(virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) &&
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6));
 }
 
 static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
@@ -3759,6 +3767,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
+			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 		dev->features |= NETIF_F_GSO_ROBUST;
 
@@ -4036,6 +4046,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
 	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
 	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
+	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
