Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543D0C43217
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 11:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 137D5419E0;
	Thu, 12 May 2022 11:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FqsReOJd8NF0; Thu, 12 May 2022 11:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DB3E419E2;
	Thu, 12 May 2022 11:33:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29A4DC008A;
	Thu, 12 May 2022 11:33:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B903C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A94B4419A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9O5cgsExyaCF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0C9D419C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:24 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id g16so6120657lja.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AuhXnTyXYfvNbLOGsXvQgDXjLOOfx+AfDHJa0gr2Q8A=;
 b=e/NKJfA0K3TVh2Uqqes8Fg6Z0r2h5rdevnONjrKcIbdfkj32ctf6vWieQiM2iNM0ve
 jlsoNaxpzQNSTeGfXF1xckXcKIlmKBHG7B/SulZth7jNS0kFG/Pxh9wGjH53ks8fpkAi
 ePuZRaOVxGFoNjIiGrhuvLNoNL9w6aND2iTpY1lO3SK76sZZmfjJVuqs1RX2HCVN9VCw
 4ZXSmCNyRtn5/xqrzSvgv8I1wET3wo/vDSgB2F+PRw0jG7/TV9n/zqkaPin4vQ9aL8LK
 efFxugQHftyB5jB7VyCChE1nUuORIYIeLOQS6v+XH1C8bBjTz+PRvO7yrXgp7hG6ERxJ
 hgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AuhXnTyXYfvNbLOGsXvQgDXjLOOfx+AfDHJa0gr2Q8A=;
 b=R/Ifmb3k+6YRSf4jx9VgKAnri+zzQCkzcxkb2JrsqJPgQu40DcdOL/0GmL+/Z9QIeh
 i5RkEyI6p/seLD31woVzu1iKsJx/SiN4AAg9xjf36btpO0JKwEo9wVZ0Q5xBFFnHCx33
 XzrRMFu4cMVlp7Yg2Hgb8e1YswsEOVu8SBR/sTXI8SGpGd9QLqEDu8MzIJ92rM9NVnlp
 rZiOELFFHL2xLB0lgVlm+y1nXVi3BDffrY8dsWzXH3/ZqGMBIqK3r1E2FH8eoFiLBH/P
 +Olo+d/2ZUdDEcb2qnmRUO3xUvy25LZLi4zzul6NGV3zyZb/guxzHk5ErBk4kPwxEqYj
 BCMA==
X-Gm-Message-State: AOAM530Uzf4rFqkdK2VIfJuesnZTAlr4dlrIhrpkPT+9hBcenY91jSak
 016f//89DerehZ+gkb7GUms1Eg==
X-Google-Smtp-Source: ABdhPJwOHf2aNvhc0cKjwxuR/gjiWUyFUU8LZPUO4MjSQClRg+GqK0Z8piXa6I+W2Y/Uroj3iNEMGw==
X-Received: by 2002:a2e:9dca:0:b0:24f:2924:9295 with SMTP id
 x10-20020a2e9dca000000b0024f29249295mr20745904ljj.480.1652355204073; 
 Thu, 12 May 2022 04:33:24 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 r29-20020ac25a5d000000b0047255d211a6sm741758lfn.213.2022.05.12.04.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 04:33:23 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 5/5] drivers/net/virtio_net.c: Added USO support.
Date: Thu, 12 May 2022 14:23:47 +0300
Message-Id: <20220512112347.18717-6-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512112347.18717-1-andrew@daynix.com>
References: <20220512112347.18717-1-andrew@daynix.com>
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

Now, it possible to enable GSO_UDP_L4("tx-udp-segmentation") for VirtioNet.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cbba9d2e8f32..17fb8be7e4f7 100644
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
@@ -2867,7 +2871,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
@@ -3507,6 +3513,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
+			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 		dev->features |= NETIF_F_GSO_ROBUST;
 
@@ -3552,7 +3560,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO) ||
+	    (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) &&
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6)))
 		vi->big_packets = true;
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
@@ -3780,6 +3790,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
 	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
 	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
+	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
