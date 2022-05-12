Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AD4C4332F
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 11:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3CEA419E6;
	Thu, 12 May 2022 11:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QV1ASBUN_tRJ; Thu, 12 May 2022 11:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 671A4419DC;
	Thu, 12 May 2022 11:33:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA991C0080;
	Thu, 12 May 2022 11:33:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E44F2C0039
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D76F0419C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGCueJLw1_kt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E26534167F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:23 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id g16so6120657lja.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dQ6Kj1AFx+WOgmL0iPWurV5hXCaWyWM8z6CScgnZ/mE=;
 b=eZlrMjgNhGomXxclaICAouypvp3lRfwA6aZfhe3AuMITDC5aWokIMqIolhVdtaZYd2
 8NkrnkmRYFE86hKFaKF3lR5XNcvz5vRIqWhpY7UjzJ/mRrdMw+kXRu1GxHv10+l/grGb
 eYFVeRSPr0I/DORddBVbHRUdOebbrl2/EbqnfMeS2fLZbbyBLTu7lyPhSM71VKxO7p6E
 8CgT4Mv+1vL2Es14NninGcjg/EPWQF6UwwbzBPbNrUr0zvPgDoNdT2tknD9NQiY/eh9P
 Qdco9bi/vP/OBeQ+JDoSE+az1KTEBX8/LIkySJJCbfkibbj7YZuoDqCgwI0m1P8nAOEZ
 JFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dQ6Kj1AFx+WOgmL0iPWurV5hXCaWyWM8z6CScgnZ/mE=;
 b=bvrrJkFyllQsiETi67g54B5xZs0wk0E+F/3fKtDeVPt+60e338ZP0NhUD0IuaymAII
 vIIagz9EzNvJxoq17iVgl/HmjPA4gTDGxbTIeT9TK9LRxTC3DHrXWvNbjUcNmHKfaXLC
 cUxL4Yee+yaWT3Hv92sLFDzIPrCTn7ke1uJFBBo0EK343ElEhCh2eu5cHS/WOC5G1uv3
 wgzDwA9OQpq+lxRamxWcKafQBbH0vAXNHchERyavLU4dum677r0QBVcvBmpEiEPOnIMG
 M+pg6DpCzsPEIIpveOTGo0NMAtQK7/7SedLOcWdUaHBaS+sDmwbx1hmX3UKTLciSAwC3
 NxxQ==
X-Gm-Message-State: AOAM532gKZAme+u53Q1ba7MjSrItnSw3Haeyu9MUH/RBV+bKtOKtdayh
 W0s1gkpJGZE+zuhoUxOsYkXP5g==
X-Google-Smtp-Source: ABdhPJxBbnjmcbyqDTcs/WSaKg6jAB/MlcJZ2EYLz6uh2au/7rvOWL/6K4Gs9t4HeVQS/eC8xFyNYQ==
X-Received: by 2002:a2e:8902:0:b0:24f:1446:3101 with SMTP id
 d2-20020a2e8902000000b0024f14463101mr19979362lji.266.1652355201900; 
 Thu, 12 May 2022 04:33:21 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 r29-20020ac25a5d000000b0047255d211a6sm741758lfn.213.2022.05.12.04.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 04:33:21 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 3/5] uapi/linux/virtio_net.h: Added USO types.
Date: Thu, 12 May 2022 14:23:45 +0300
Message-Id: <20220512112347.18717-4-andrew@daynix.com>
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

Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
required for Windows guests.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 3f55a4215f11..c654feb1ed9b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,9 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
+#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
+#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
 
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
@@ -130,6 +133,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
+#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
