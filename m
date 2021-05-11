Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B3C43460
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3920E61923
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3920E61923
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC3E3606F5;
	Tue, 11 May 2021 04:43:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Eo55bburkWL; Tue, 11 May 2021 04:43:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id E49D960D4F;
	Tue, 11 May 2021 04:43:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D278AC000D;
	Tue, 11 May 2021 04:43:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FF11C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D7EB60D4C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sqDpGobRHaAQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4838A606F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:23 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id n84so10351183wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wwaKQDmQQxJQV6OXbMRvBq98650xZ8vtis+SN2tPPHc=;
 b=cUN8rJ9cxcb5J6kh+EpJHFwm6r407tanaasfSpuHrGBM+kNjPeuj+uFStN0RAyeYO2
 G7ZGTP5X4SVe+KtQutvXBZDfqcDiuskFS3LGFUH2BRfM9lRvRLN0hKenJODEmwH3MYSx
 cauxYNlkBpoVwDHMP7d9Kn04PWpufgsktbdx+tXD2qVh7s1mG7xpm4WItZHcC2CXAly/
 UVWK36bjkh2N+7p+DJfuraSMYBSlv+TZLPEXdCcUBZyVhgbCrtnEmTD+CkVLh5ZbYhWI
 BmZhfvJ0CkntkYidpQZApE2hWLUZMQ0OSV70dYLDAgnLX+fGTMG6C36Mxba+O8TpQFqJ
 XEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wwaKQDmQQxJQV6OXbMRvBq98650xZ8vtis+SN2tPPHc=;
 b=sgfCXxU2vaO9kF0lpS4wi7VSEKSWYoPxbNtT4aJ9xVZgxtHJjy/+55aaufZjAP0plL
 rZ+t8xYmOtnXjId7nQIvrHhzytHF75fRebvyBiIagNkkZhqTG9ySP+mxd1Rw3wh87CT7
 qHDu6aEBwEcNDyepi2E5hZlDuTD3N+9q1Y0nMmjFRtBkLvHNZWa/DkYrAXNzb2lRj32U
 U7QlJv8MMvE6HbLcg4VQJuDWwI1jvkuFc7m6u+TpgdzxGMBb7imjLat5ElFFzA/ktJfE
 uxHO1+yALeCtD9ST5Vi7D9wEDQp5UEuseuyHdAcQab7tmIfIjd6/e/vgtnxt4DTXT1Hf
 T1Sw==
X-Gm-Message-State: AOAM531l/PC6PbnNhfjgXy3A9UoTLx9++qi/RIydPRr+i0kQsug93jAK
 j6WD/NGxRY5qR0HoJf2dkt9tVQ==
X-Google-Smtp-Source: ABdhPJwHj435BmybraousVJN/rIUlLcWFmieWSwFi/CAKzS4FDUSyjNRR06B441/KbZuzZumpB1OVw==
X-Received: by 2002:a1c:1b49:: with SMTP id b70mr30552226wmb.147.1620708201504; 
 Mon, 10 May 2021 21:43:21 -0700 (PDT)
Received: from f1.Home (bzq-79-180-42-161.red.bezeqint.net. [79.180.42.161])
 by smtp.gmail.com with ESMTPSA id a9sm22360520wmj.1.2021.05.10.21.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 21:43:21 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 1/4] virtio-net: add definitions for host USO feature
Date: Tue, 11 May 2021 07:42:50 +0300
Message-Id: <20210511044253.469034-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511044253.469034-1-yuri.benditovich@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com
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

Define feature bit and GSO type according to the VIRTIO
specification.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 3f55a4215f11..a556ac735d7f 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_HOST_USO     56	/* Host can handle USO packets */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
@@ -130,6 +131,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
+#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4 UDP (USO) */
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
