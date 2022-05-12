Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF95C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 11:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19724610DE;
	Thu, 12 May 2022 11:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Am77cAq7EE0; Thu, 12 May 2022 11:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 97F9960E00;
	Thu, 12 May 2022 11:33:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E9CBC0039;
	Thu, 12 May 2022 11:33:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20327C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8BA8405B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z5gzflb1g73B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF2AD40025
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:22 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id p26so8477038lfh.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vWGmhmweV+dNU5jtCxsxI3a+Zh1xPCMPOBO82/gmlT8=;
 b=LKUD1yC32xjbxmkSjCnpvuGV+8W7U4BU65WpHJE3jq3pkQpn1jtn6WIi0hBwFbvO1H
 A9TSVFsVVQfZbvcjeW13k4cH6GFbrI5hb0Z4djPSZd1N6bBC67YPH452ep4LQwsk0WV8
 y2YzdhmWiMSLQZFLeedNKlvsJGIR0oAkoC9fTPqx1xNStO2xj0HGxgNgfWCkuf0BTSfB
 zhM0kGiyzLSCjeiQgbzY7bjCBK+FcgdMsz0UnP4Zgpjnb4SOX3/4bMiKLkJGKbXTrlDO
 KzFWIsuWwK6BVT0/jE4YaTxGKFY00f6wvNeNPO/Rek5sOuC08PXqLalP/n9r+2F1I/L+
 TFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vWGmhmweV+dNU5jtCxsxI3a+Zh1xPCMPOBO82/gmlT8=;
 b=m5KS7XNXJLySRyhUc+oAbhOAaiVmINnh5v123/eNeWPyKQRf7wEfC35BPIuf2hdOF6
 S1+w0xH9ZFR7ByIyDgX0uI6zySGi5blbjGm7hcGVXq0d1nHxRjsqmdB5BrI+gyMs/pIJ
 aLWmSakOiLOSsnFH9qSlaAaFzzBo0h8jKWWNsKJ8mLq3h6Jwar5vgyyixN07TcLFJjtd
 aUrUAm482aHYe0bxdynpEoXm0PzUHLboFvyqZQ2ZJyVOiUEivK+sKAAT1Bjnq9aLvZvP
 SBFlyKcRcAAh2wD1EX10AcBGtRXCp9qSAVRK5UYYPFUkfZ1yliQLtfCg1scCZuCfTd2o
 XZmA==
X-Gm-Message-State: AOAM533ZCjF4DE/DTvoovALu5ga7Vg4T9hpZ5/6YS+ykpgXdsq5tdArG
 Y3iaO38g9PRFKTrq6Bmy4tphEQ==
X-Google-Smtp-Source: ABdhPJxbWkbMoHZx9vnNhaWMQsFMmMpNbbKEDn9qoqWTiVezpVArTwZqGvvEio/w1aBmU0O0mXLwOg==
X-Received: by 2002:a05:6512:3e17:b0:473:205d:a3d5 with SMTP id
 i23-20020a0565123e1700b00473205da3d5mr23770800lfv.80.1652355200800; 
 Thu, 12 May 2022 04:33:20 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 r29-20020ac25a5d000000b0047255d211a6sm741758lfn.213.2022.05.12.04.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 04:33:20 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 2/5] driver/net/tun: Added features for USO.
Date: Thu, 12 May 2022 14:23:44 +0300
Message-Id: <20220512112347.18717-3-andrew@daynix.com>
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

Added support for USO4 and USO6.
For now, to "enable" USO, it's required to set both USO4 and USO6 simultaneously.
USO enables NETIF_F_GSO_UDP_L4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/tap.c | 10 ++++++++--
 drivers/net/tun.c |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index c3d42062559d..eae7c2c13713 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -955,6 +955,10 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 			if (arg & TUN_F_TSO6)
 				feature_mask |= NETIF_F_TSO6;
 		}
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
+			features |= NETIF_F_GSO_UDP_L4;
 	}
 
 	/* tun/tap driver inverts the usage for TSO offloads, where
@@ -965,7 +969,8 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 	 * When user space turns off TSO, we turn off GSO/LRO so that
 	 * user-space will not receive TSO frames.
 	 */
-	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6))
+	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
+	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
 		features |= RX_OFFLOADS;
 	else
 		features &= ~RX_OFFLOADS;
@@ -1089,7 +1094,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
-			    TUN_F_TSO_ECN | TUN_F_UFO))
+			    TUN_F_TSO_ECN | TUN_F_UFO |
+			    TUN_F_USO4 | TUN_F_USO6))
 			return -EINVAL;
 
 		rtnl_lock();
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dbe4c0a4be2c..ecad1bdee717 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -185,7 +185,7 @@ struct tun_struct {
 	struct net_device	*dev;
 	netdev_features_t	set_features;
 #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
-			  NETIF_F_TSO6)
+			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
 
 	int			align;
 	int			vnet_hdr_sz;
@@ -2861,6 +2861,12 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 		}
 
 		arg &= ~TUN_F_UFO;
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if (arg & TUN_F_USO4 && arg & TUN_F_USO6) {
+			features |= NETIF_F_GSO_UDP_L4;
+			arg &= ~(TUN_F_USO4 | TUN_F_USO6);
+		}
 	}
 
 	/* This gives the user a way to test for new features in future by
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
