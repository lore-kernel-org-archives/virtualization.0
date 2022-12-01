Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C8C47090
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3886410B0;
	Thu,  1 Dec 2022 22:48:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3886410B0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OQa+DAdU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kt4YU9VDKS4T; Thu,  1 Dec 2022 22:48:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3677641086;
	Thu,  1 Dec 2022 22:48:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3677641086
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17077C002D;
	Thu,  1 Dec 2022 22:48:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97E98C0033
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73AEC82092
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73AEC82092
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=OQa+DAdU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lo2y4Kh-HGCL
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F0268204A
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F0268204A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:54 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id z24so3561800ljn.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlO6QTZCwR1RLEDuFRe8THkhQOGpd88LnLO5Y8el1kY=;
 b=OQa+DAdUw25Ne94o8Inx5iCJ59YUCMg+QHfRo6xIu6a4xvMjlsgj5c2yxNNo+UVHxE
 HeENFmyRRYnS1NoX9sJhjEOFj5+NH0pCOGM4g1y5/p/r6KRF7qzeZEWMkgF6KiVjdQY0
 VB+Qqyl8R1w0leOOZ82Mhtoj/85biqpWkIevsh4n7JGId7+6BtCdn1LRtjcrttvpK45S
 sUk8RqXnMV5eqe3OIi+AHNAUMfAQv3xxUHEMuIHZr5wgOa19b0vfcPEGEebDjTPUjC7/
 ckOTciOmLdDcV4kdYI+fCuGBRYCNf0lusxwinAq2I5mZ580SvwR8PTwhEhKr1XuOc2nl
 ksnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BlO6QTZCwR1RLEDuFRe8THkhQOGpd88LnLO5Y8el1kY=;
 b=CZg1I3I7D4xtpS4ZKubX/4keNxU9qu0GCT0NAhj0DP71IzE962NdKBDFkalihTBQ97
 FCsB5mw6Y7ouViPWTOTi/JUhvP6JWkRlEB8rVkGGF+JTokx6O2c3v+DkSFZ3qmzYwhaz
 b9iyhZuD1vwSRWwoK5ds4AQyhi3iEIZQSHvzpidbJglc5feWt+XbKWs+c2cVzOLgxnFl
 5c54OmZIpfAha0x/Kr1CScMY5nBHr78WA8SekESTy8CQnXL8Ekx2kXq4jO9vllqQ2p5u
 HvS/U8CVQYx4PL1KZBcv8Ard6HXdnT/hx4UerSHYpXinQGTxkXzqrNbR7u/3REejZSkF
 ZnBg==
X-Gm-Message-State: ANoB5pkiVDtnsf3elnGtxR2p/94ChPch6H1dwFmJV25/Elvx+dFfDN6+
 eDvBlU3avQkZ/0n5OX66VtDhlw==
X-Google-Smtp-Source: AA0mqf5E3BX1xvmG/ZbvCu2JxFuLoiltJ9sVdMphUNGSiGKb9Gk6LgpxIlyJTnX8txMUn7W/r7Qskg==
X-Received: by 2002:a2e:b891:0:b0:277:8df:88a7 with SMTP id
 r17-20020a2eb891000000b0027708df88a7mr23324289ljp.139.1669934932549; 
 Thu, 01 Dec 2022 14:48:52 -0800 (PST)
Received: from localhost.localdomain ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a056512118700b00497ab34bf5asm797573lfr.20.2022.12.01.14.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:48:52 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 3/6] driver/net/tun: Added features for USO.
Date: Fri,  2 Dec 2022 00:33:29 +0200
Message-Id: <20221201223332.249441-3-andrew@daynix.com>
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

Added support for USO4 and USO6.
For now, to "enable" USO, it's required to set both
USO4 and USO6 simultaneously.
USO enables NETIF_F_GSO_UDP_L4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/tap.c | 10 ++++++++--
 drivers/net/tun.c |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9e75ed3f08ce..a2be1994b389 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -957,6 +957,10 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 			if (arg & TUN_F_TSO6)
 				feature_mask |= NETIF_F_TSO6;
 		}
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
+			features |= NETIF_F_GSO_UDP_L4;
 	}
 
 	/* tun/tap driver inverts the usage for TSO offloads, where
@@ -967,7 +971,8 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 	 * When user space turns off TSO, we turn off GSO/LRO so that
 	 * user-space will not receive TSO frames.
 	 */
-	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6))
+	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
+	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
 		features |= RX_OFFLOADS;
 	else
 		features &= ~RX_OFFLOADS;
@@ -1091,7 +1096,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
-			    TUN_F_TSO_ECN | TUN_F_UFO))
+			    TUN_F_TSO_ECN | TUN_F_UFO |
+			    TUN_F_USO4 | TUN_F_USO6))
 			return -EINVAL;
 
 		rtnl_lock();
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 24001112c323..a7b9808368d0 100644
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
@@ -2885,6 +2885,12 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
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
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
